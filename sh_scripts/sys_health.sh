#!/bin/bash

LOG=/tmp/system_health.log
DATE=$(date "+%Y-%m-%d %H:%M:%S")

echo "===========Health check at $DATE============" >> $LOG

DISK=$(df -h / |tail -1 | awk '{print $5}' | sed 's/%//')
echo "Disk Usage: ${DISK}%" >> $LOG

MEM=$(free | awk '/mem/ {printf("%.0f" , $3/$2 * 100)}')
echo "mempry Usage: ${MEM}%" >> $LOG

if systemctl is-active --quiet ssh; then
 echo "Service is running"  >> $LOG
else 
 echo " Service is not running" >> $LOG
fi

echo "=============================" >> $LOG


