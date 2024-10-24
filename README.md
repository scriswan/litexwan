# Step 1
```
apt update && apt upgrade -y --fix-missing && update-grub && sleep 2 && apt -y install xxd && apt install -y bzip2 && apt install -y wget && apt install -y curl && reboot
```

# Debian 10 & Ubuntu 20
```
wget -q https://raw.githubusercontent.com/scriswan/litexwan/main/install1.sh && chmod +x install1.sh && ./install1.sh
```

# Debian 11 & Ubuntu 22
```
wget -q https://raw.githubusercontent.com/scriswan/litexwan/main/install2.sh && chmod +x install2.sh && ./install2.sh
```
## UPDATE SCRIPT
```
wget -q https://raw.githubusercontent.com/scriswan/litexwan/main/update.sh && chmod +x update.sh && ./update.sh
```
