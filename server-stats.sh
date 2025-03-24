#!/bin/bash

# Print a header for the stats
echo "========================= Server Stats ========================="

# 1. OS Version
echo -e "\n# 1. OS Version:"
cat /etc/os-release | grep ^PRETTY_NAME=

# 2. Uptime
echo -e "\n# 2. Uptime:"
uptime -p

# 3. Load Average
echo -e "\n# 3. Load Average:"
uptime | awk -F'load average: ' '{ print $2 }'

# 4. Logged In Users
echo -e "\n# 4. Logged In Users:"
who

# 5. Failed Login Attempts (from /var/log/auth.log)
echo -e "\n# 5. Failed Login Attempts:"
grep "Failed password" /var/log/auth.log | wc -l

# 6. Total CPU Usage
echo -e "\n# 6. Total CPU Usage:"
top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}'

# 7. Total Memory Usage (Free vs Used)
echo -e "\n# 7. Total Memory Usage:"
free -h

# 8. Total Disk Usage (Free vs Used)
echo -e "\n# 8. Total Disk Usage:"
df -h

# 9. Top 5 Processes by CPU Usage
echo -e "\n# 9. Top 5 Processes by CPU Usage:"
ps -eo pid,ppid,%cpu,%mem,comm --sort=-%cpu | head -n 6

# 10. Top 5 Processes by Memory Usage
echo -e "\n# 10. Top 5 Processes by Memory Usage:"
ps -eo pid,ppid,%cpu,%mem,comm --sort=-%mem | head -n 6

# Stretch Goal: Adding additional stats
# 11. System Architecture
echo -e "\n# 11. System Architecture:"
uname -m

# 12. System Information (Kernel version and architecture)
echo -e "\n# 12. System Info (Kernel Version & Architecture):"
uname -a

# End of the script
echo -e "\n========================= End of Stats ========================="
