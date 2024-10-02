#!/bin/bash

# Clear the screen
clear

# Print SSH login title
echo "◇━━━━━━━━━━━━━━━━━◇"
echo " 🔸 User SSH Logins 🔸"
echo "◇━━━━━━━━━━━━━━━━━◇"

# Determine the log file location based on the system
if [ -e "/var/log/auth.log" ]; then
    LOG="/var/log/auth.log"
elif [ -e "/var/log/secure" ]; then
    LOG="/var/log/secure"
else
    echo "Log file not found!"
    exit 1
fi

# Fetch Dropbear process IDs
dropbear_pids=($(ps aux | grep -i dropbear | awk '{print $2}'))

# Extract successful Dropbear login attempts
grep -i "dropbear" "$LOG" | grep -i "Password auth succeeded" > /tmp/login-db.txt

# Loop through each Dropbear process and check if it corresponds to a successful login
for PID in "${dropbear_pids[@]}"; do
    login_info=$(grep "dropbear\[$PID\]" /tmp/login-db.txt)
    if [ -n "$login_info" ]; then
        USER=$(echo "$login_info" | awk '{print $10}')
        IP=$(echo "$login_info" | awk '{print $12}')
        echo "PID: $PID - User: $USER - IP: $IP"
    fi
done

echo ""

# Extract SSHD login attempts
grep -i "sshd" "$LOG" | grep -i "Accepted password for" > /tmp/login-sshd.txt

# Fetch SSHD process IDs
sshd_pids=($(ps aux | grep "\[priv\]" | awk '{print $2}'))

# Loop through each SSHD process and check for successful logins
for PID in "${sshd_pids[@]}"; do
    login_info=$(grep "sshd\[$PID\]" /tmp/login-sshd.txt)
    if [ -n "$login_info" ]; then
        USER=$(echo "$login_info" | awk '{print $9}')
        IP=$(echo "$login_info" | awk '{print $11}')
        echo "PID: $PID - User: $USER - IP: $IP"
    fi
done

# Check OpenVPN TCP logs, if available
if [ -f "/etc/openvpn/server/openvpn-tcp.log" ]; then
    echo " "
    grep -w "^CLIENT_LIST" /etc/openvpn/server/openvpn-tcp.log | cut -d ',' -f 2,3,8 | sed -e 's/,/      /g'
fi

# Check OpenVPN UDP logs, if available
if [ -f "/etc/openvpn/server/openvpn-udp.log" ]; then
    echo " "
    grep -w "^CLIENT_LIST" /etc/openvpn/server/openvpn-udp.log | cut -d ',' -f 2,3,8 | sed -e 's/,/      /g'
fi

# Clean up temporary files
rm -f /tmp/login-db.txt /tmp/login-sshd.txt

echo ""
# Uncomment the line below if you want to pause and return to a menu
# read -n 1 -s -r -p "Press [ Enter ] to go back to the menu"
