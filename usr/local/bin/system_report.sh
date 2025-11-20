#!/bin/bash

echo "==================== SYSTEM REPORT ===================="
echo "Date & Time: $(date)"
echo "Uptime: $(uptime -p)"
echo "CPU Usage: $(top -bn1 | grep '%Cpu' | awk '{print $2 + $4}')%"
echo "Memory Usage: $(free | grep Mem | awk '{print ($3/$2)*100}')%"
echo "Disk Usage: $(df -h / | awk 'NR==2 {print $5}')"
echo "Top 3 CPU Processes:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 4
echo "====================**************==================="
echo ""
