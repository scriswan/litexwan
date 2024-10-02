#!/bin/bash

# Function to convert bytes to human-readable format
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

# Clear the screen
clear

# Clear the temporary file
echo -n > /tmp/other.txt

# Extract user accounts from the config file
data=($(grep -E "^###" "/etc/xray/config.json" | cut -d ' ' -f 2 | sort -u))


# Loop through each user account
for user in "${data[@]}"; do
    if [[ -z "$user" ]]; then
        continue  # Skip if no account found
    fi

    # Clear temporary file for IPs
    echo -n > /tmp/ipxray.txt

    # Extract IP addresses from logs
    data2=($(grep -w "$user" /var/log/xray/access.log | tail -n 500 | awk '{print $3}' | sed 's/tcp://g' | cut -d ":" -f 1 | sort -u))

    # Loop through IPs and process them
    for ip in "${data2[@]}"; do
        if grep -qw "$ip" /var/log/xray/access.log; then
            echo "$ip" >> /tmp/ipxray.txt
        else
            echo "$ip" >> /tmp/other.txt
        fi
    done

    # Check if the user has any associated IPs
    if [[ -s /tmp/ipxray.txt ]]; then
        # Print the user's IP information
        lastlogin=$(grep -w "$user" /var/log/xray/access.log | tail -n 500 | awk '{print $2}' | tail -1)
        iplimit=$(cat /etc/kyt/limit/vmess/ip/${user})
        jum2=$(cat /tmp/ipvmess.txt | wc -l)
        byte=$(cat /etc/vmess/${user})
        lim=$(con ${byte})
        wey=$(cat /etc/limit/vmess/${user})
        gb=$(con ${wey})
        echo "User: ${user}"
        echo "Online Time: ${lastlogin}"
        echo "Usage Quota: ${gb}" 
        echo "Limit Quota: ${lim}" 
        echo "Limit IP: $iplimit" 
        echo "Login IP: $jum2" 
        
        nl /tmp/ipxray.txt  # Display IP list with line numbers
        echo ""
    fi
done

# Clean up temporary files
rm -f /tmp/other.txt /tmp/ipxray.txt