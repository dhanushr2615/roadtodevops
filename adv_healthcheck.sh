#!/bin/bash
PATH=/usr/bin:/bin:/usr/sbin:/sbin
DATE=$(date "+%Y-%m-%d %H:%M:%S")
LOG=/tmp/adv_health.log
DISK_THRES=80
MEM_THRES=75
CPU_THRES=1.5
DATE=$(date "+%Y-%m-%d %H:%M:%S")

echo "======Advance Health Log of $DATE======" >> $LOG

DISK=$(df -h / | tail -1 | awk '{print $5}' | sed 's/%//')
if [ "$DISK" -gt "$DISK_THRES" ]; then
 echo "$DATE DISK ALERT: ${DISK}%" >> $LOG
 ALERT=1
else
 echo "$DATE DISK NORMAL: ${DISK}%" >> $LOG
fi

MEM=$(free | awk '/Mem/ {printf("%0.f" , $3/$2 * 100)}')
if [ "$MEM" -gt "$MEM_THRES" ]; then
 echo "$DATE MEMEORY ALERT: ${MEM}%" >> $LOG
 ALERT=1
else
 echo"$DATE MEMORY OK:${MEM}%" >> $LOG
fi

CPU=$(awk '{print $1}' /proc/loadavg)
if (( $(echo "$CPU > $CPU_THRES" | bc -l) )); then
 echo "$DATE CPU ALERT: LOAD AVG $CPU" >> $LOG
 ALERT=1
else
 echo "$DATE CPU OK : LOAD AVG $CPU" >> $LOG
fi

for services in ssh cron
do
 if systemctl is-active --quiet "$services";then
  echo "$DATE SERVICE $servcies Running" >> $LOG
else
  echo "$DATE SERVIEC $services NOT RUNNING" >> $LOG
  ALERT=1
fi
done

exit $ALERT

