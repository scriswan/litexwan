#!/bin/bash

# Function to convert bytes to a human-readable format
function con() {
    local -i bytes=$1
    if (( bytes < 1024 )); then
        echo "${bytes}B"
    elif (( bytes < 1048576 )); then
        echo "$(( (bytes + 1023) / 1024 ))KB"
    elif (( bytes < 1073741824 )); then
        echo "$(( (bytes + 1048575) / 1048576 ))MB"
    else
        echo "$(( (bytes + 1073741823) / 1073741824 ))GB"
    fi
}

# Print table header
echo "◇━━━━━━━━━━━━━━━━━◇"
echo "|🔸Akun | Quota | IP Limit🔸|"
echo "◇━━━━━━━━━━━━━━━━━◇"

# Read account data from configuration
mapfile -t data < <(grep '^###' "/etc/xray/config.json" | cut -d ' ' -f 2 | sort -u)

# Process each account
for akun in "${data[@]}"; do
    # Extract relevant information
    exp=$(grep -wE "^### $akun" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort -u)
    iplimit=$(<"/etc/kyt/limit/vmess/ip/${akun}")
    byte=$(<"/etc/vmess/${akun}")
    lim=$(con "${byte}")
    wey=$(<"/etc/limit/vmess/${akun}")
    gb=$(con "${wey}")

    # Print account information in a formatted manner
    printf "%-10s %-12s %-10s\n" "${akun}" "${gb}/${lim}" "${iplimit} IP"
done

# Exit script
exit 0
