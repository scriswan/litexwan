#!/bin/bash
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# System Request : Debian 9+/Ubuntu 18.04+/20+
# Develovers » Riswanvpn
# Email      » Riswanvpn@gmail.com
# telegram   » https://t.me/Riswanvpn

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Riswanvpn

dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
#########################
# Getting
clear
export CHATID="6348824977"
export KEY="6854390843:AAHnygrqUOSq-5spVPBBrOvBMy4xcdUBPBU"
export TIME="10"
export URL="https://api.telegram.org/bot$KEY/sendMessage"
clear
sldomain=$(cat /root/nsdomain)
cdndomain=$(cat /root/awscdndomain)
slkey=$(cat /etc/slowdns/server.pub)
clear
cekray=`cat /root/log-install.txt | grep -ow "XRAY" | sort | uniq`
if [ "$cekray" = "XRAY" ]; then
domen=`cat /etc/xray/domain`
else
domen=`cat /etc/v2ray/domain`
fi
portsshws=`cat ~/log-install.txt | grep -w "SSH Websocket" | cut -d: -f2 | awk '{print $1}'`
wsssl=`cat /root/log-install.txt | grep -w "SSH SSL Websocket" | cut -d: -f2 | awk '{print $1}'`

clear
IP=$(curl -sS ifconfig.me);
ossl=`cat /root/log-install.txt | grep -w "OpenVPN" | cut -f2 -d: | awk '{print $6}'`
opensh=`cat /root/log-install.txt | grep -w "OpenSSH" | cut -f2 -d: | awk '{print $1}'`
db=`cat /root/log-install.txt | grep -w "Dropbear" | cut -f2 -d: | awk '{print $1,$2}'`
ssl="$(cat ~/log-install.txt | grep -w "Stunnel4" | cut -d: -f2)"
sqd="$(cat ~/log-install.txt | grep -w "Squid" | cut -d: -f2)"
ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"

OhpSSH=`cat /root/log-install.txt | grep -w "OHP SSH" | cut -d: -f2 | awk '{print $1}'`
OhpDB=`cat /root/log-install.txt | grep -w "OHP DBear" | cut -d: -f2 | awk '{print $1}'`
OhpOVPN=`cat /root/log-install.txt | grep -w "OHP OpenVPN" | cut -d: -f2 | awk '{print $1}'`

Login=trial`</dev/urandom tr -dc X-Z0-9 | head -c4`
hari="1"
Pass=1
echo Ping Host Trial SSH OpenVPN
echo Create Trial Account  : $Login
sleep 0.5
echo Setting User Password : $Pass
sleep 0.5
clear
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
PID=`ps -ef |grep -v grep | grep sshws |awk '{print $2}'`

if [[ ! -z "${PID}" ]]; then
echo -e "\e[33m───────────────────────────\033[0m" 
echo -e "\E[40;1;37m          🔹TRIAL ACCOUNT SSH🔹   \E[0m" 
echo -e "\e[33m───────────────────────────\033[0m" 
echo -e "Nameserver: $sldomain" 
echo -e "domain: $(cat /etc/xray/domain)" 
echo -e "Username: $Login" 
echo -e "Password: $Pass" 
echo -e "\e[33m───────────────────────────\033[0m" 
echo -e "UDP: $domen:1-65535@$Login:$Pass" 
echo -e "SSH: $domen:80@$Login:$Pass" 
echo -e "\e[33m───────────────────────────\033[0m" 
echo -e "Aktif Selama   : $pup 60 menit"
echo -e "\E[40;1;37mJagan lupa order sesudah trial😁  \E[0m"
echo -e "\E[40;1;37mScript by @Riswanvpnstore  \E[0m"
echo -e "\e[33m───────────────────────────\033[0m"  
else

echo -e "\e[33m───────────────────────────\033[0m" 
echo -e "\E[40;1;37m          🔹TRIAL ACCOUNT SSH🔹   \E[0m" 
echo -e "\e[33m───────────────────────────\033[0m" 
echo -e "Nameserver : $sldomain" 
echo -e "domain: $(cat /etc/xray/domain)" 
echo -e "Username: $Login" 
echo -e "Password: $Pass" 
echo -e "\e[33m───────────────────────────\033[0m" 
echo -e "UDP: $domen:1-65535@$Login:$Pass" 
echo -e "SSH: $domen:80@$Login:$Pass" 
echo -e "\e[33m───────────────────────────\033[0m" 
echo -e "Aktif Selama   : $pup 60 menit"
echo -e "\E[40;1;37mJagan lupa order sesudah trial😁  \E[0m"
echo -e "\E[40;1;37mScript by @Riswanvpnstore  \E[0m"
echo -e "\e[33m───────────────────────────\033[0m"  
fi
echo "" 
read -n 1 -s -r -p "Press any key to back on menu"
menu
