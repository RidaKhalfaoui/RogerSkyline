#!/bin/bash

# Colors
_RED='\033[31m'
_RESET='\033[0m'
_BLUE='\033[34m'
_GREEN='\033[32m'
echo "$_RED   =====================================================================$_RESET\n"
echo "$_BLUE                        Disk infos $_RESET"
echo "$_GREEN   =====================================================================$_RESET\n"
fdisk -l


echo "$_RED   =====================================================================$_RESET\n"
echo "$_BLUE                        Update/upgrade $_RESET"
echo "$_GREEN   =====================================================================$_RESET\n"
apt-get -y update
apt-get -y upgrade


echo "$_RED   =====================================================================$_RESET\n"
echo "$_BLUE                        Install package $_RESET"
echo "$_GREEN   =====================================================================$_RESET\n"
apt-get install -y sudo
apt-get install -y fail2ban
apt-get install -y vim
apt-get install -y iptables-persistent
apt-get install -y netfilter-persistent
apt-get install -y net-tools
apt-get install -y git
apt-get install -y sendmail
apt-get install -y nmap
apt-get install -y portsentry


echo "$_RED   =====================================================================$_RESET\n"
echo "$_BLUE                       Downloading folder $_RESET"
echo "$_GREEN   =====================================================================$_RESET\n"
cd /root
git clone https://github.com/RidaKhalfaoui/RogerSkyline.git /root/roger
adduser Rida
adduser Rida sudo


echo "$_RED   =====================================================================$_RESET\n"
echo "$_BLUE                    Subtitute file Interfaces $_RESET"
echo "$_GREEN   =====================================================================$_RESET\n"
cp /etc/network/interfaces /etc/network/interfaces-save
rm -rf /etc/network/interfaces
cp /root/roger/files/interfaces /etc/network/


echo "$_RED   =====================================================================$_RESET\n"
echo "$_BLUE      Sed : Port/PermitRoot/PubKey/PasswordAuth /etc/ssh/sshdconfig$_RESET"
echo "$_GREEN   =====================================================================$_RESET\n"
sed -i -e 's/'"#Port 22"'/'"Port 4242"'/g' /etc/ssh/sshd_config
sed -i -e 's/'"#PermitRootLogin prohibit-password"'/'"PermitRootLogin no"'/g' /etc/ssh/sshd_config
sed -i -e 's/'"#PasswordAuthentication yes"'/'"PasswordAuthentication no"'/g' /etc/ssh/sshd_config
sed -i -e 's/'"#PubkeyAuthentication yes"'/'"PubkeyAuthentication yes"'/g' /etc/ssh/sshd_config


echo "$_RED   =====================================================================$_RESET\n"
echo "$_BLUE                        Subtitute file crontab$_RESET"
echo "$_GREEN   =====================================================================$_RESET\n"
cp /etc/crontab /etc/crontab-saved
echo "SHELL=/bin/sh\n" > /etc/crontab
echo "PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin\n" >> /etc/crontab
echo "# m h dom mon dow user command\n" >> /etc/crontab
echo "17 * * * * root cd / && run-parts --report /etc/cron.hourly\n" >> /etc/crontab
echo "25 6 * * * root test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.daily )\n" >> /etc/crontab
echo "47 6 * * 7 root test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.weekly )\n" >> /etc/crontab
echo "52 6 1 * * root test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.monthly )\n" >> /etc/crontab

echo "0 4 * * 1 root /bin/sh /root/script_update_sys.sh\n" >> /etc/crontab
echo "* * * * * root /bin/sh /root/script_check_crontab.sh\n" >> /etc/crontab
echo "@reboot root /bin/sh /root/script_update_sys.sh\n" >> /etc/crontab

#echo "0 4 * * 1 sudo /bin/sh /root/script_update_sys.sh\n" > /var/spool/cron/crontabs/root
#echo "@reboot sudo /bin/sh /root/script_update_sys.sh\n" >> /var/spool/cron/crontabs/root
#echo "*/1 * * * * sudo /bin/sh /root/script_check_crontab.sh\n" >> /var/spool/cron/crontabs/root
echo "#" >> /etc/crontab


echo "$_RED   =====================================================================$_RESET\n"
echo "$_BLUE                        Add hashed crontab$_RESET"
echo "$_GREEN   =====================================================================$_RESET\n"
md5sum /etc/crontab > /root/crontab_hashed


echo "$_RED   =====================================================================$_RESET\n"
echo "$_BLUE                          Script config$_RESET"
echo "$_GREEN   =====================================================================$_RESET\n"
touch /var/log/update_script.log
cp /root/roger/script/script_update_sys.sh /root
cp /root/roger/script/script_check_crontab.sh /root


echo "$_RED   =====================================================================$_RESET\n"
echo "$_BLUE                          Sed file hosts$_RESET"
echo "$_GREEN   =====================================================================$_RESET\n"
sed -i -e 's/'"127.0.0.1	localhost"'/'"127.0.0.1	localhost.localdomain localhost debianTEST"'/g' /etc/hosts

echo "$_RED   =====================================================================$_RESET\n"
echo "$_BLUE                         edit files rules  $_RESET"
echo "$_GREEN   =====================================================================$_RESET\n"

cp /root/roger/files/rules.v4 /etc/iptables/rules.v4
cp /root/roger/files/rules.v6 /etc/iptables/rules.v6




















