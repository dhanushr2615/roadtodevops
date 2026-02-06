#!/bin/bash
PATH=/usr/bin:/bin:/usr/sbin:/sbin
DATE=$(date "+%Y-%m-%d %H:%M:%S")
DISK_THRES=80
MEM_THRES=75
CPU_THRES=1.5
LOG=/tmp/health.log
ALERT=0

echo "==========HEALTH CHECK BEGINS $DATE============" >> "$LOG"

#=====DISK=======
DISK=$(df -h / | tail -1 | awk '{print $5}' | sed 's/%//')
if [ "$DISK" -gt "$DISK_THRES" ];then
  echo "DISK Threshold is ${DISK}%"  >> "$LOG"
  ALERT=1
else
  echo "DISK IS NORMAL ${DISK}%"  >> "$LOG"
fi

#=======MEM======
MEM=$(free | awk '/Mem/ {printf("%.0f",$3/$2 * 100)}')
if [ "$MEM" -gt "$MEM_THRES" ];then
 echo "Memory threshold is ${MEM}%" >> "$LOG"
 ALERT=1
else
 echo "Memory is normal ${MEM}%" >> "$LOG"
fi

#=======CPU========
CPU=$(awk '{print $1}' /proc/loadavg)
if (( $(echo "$CPU > $CPU_THRES" | bc -l) ));then
 echo "$DATE CPU ALERT: Load $CPU" >> "$LOG"
 ALERT=1
else 
 echo "$DATE CPU OK: $CPU" >> "$LOG"
fi

for service in ssh cron
do
 if systemctl is-active --quiet "$service";then
   echo "$service is running" >> "$LOG" 
 else
  echo "$service is not running" >> "$LOG"
 ALERT=1
 fi
done


