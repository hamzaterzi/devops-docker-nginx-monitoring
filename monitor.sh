#!/bin/bash

LOGFILE="$HOME/server_monitor.log"
DATE=$(date)

CPU=$(top -bn1 | grep "Cpu" | sed 's/.*, *\([0-9.]*\)%* id.*/\1/' | awk '{print 100 - $1}')
DISK=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')

echo "[$DATE] CPU: $CPU% | Disk: $DISK%" >> "$LOGFILE"

if [ "$DISK" -gt 80 ]; then
  echo "[$DATE] WARNING: Disk usage is above 80%" >> "$LOGFILE"
fi

if systemctl is-active --quiet nginx; then
  echo "[$DATE] Nginx is running" >> "$LOGFILE"
else
  echo "[$DATE] Nginx is down, restarting..." >> "$LOGFILE"
  sudo systemctl restart nginx
fi
