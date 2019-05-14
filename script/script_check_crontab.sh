#!/bin/bah

if [ -e /root/crontab_hashed ]
then
	md5sum /etc/crontab > /tmp/crontab_check
	diff -q /tmp/crontab_check /root/crontab_hashed
	if [ $? -ne 0 ]
	then
		echo 'file /etc/crontab was modified' | sendmail root
		md5sum /etc/crontab > /root/crontab_hashed
	fi
else
	md5sum /etc/crontab > /root/crontab_hashed
fi
