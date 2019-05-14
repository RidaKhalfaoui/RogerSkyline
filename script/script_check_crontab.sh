#!/bin/bah

if [ -e /root/crontab_save_check ]
then
	md5 /etc/crontab | cut -d ' ' -f 4 > /tmp/crontab_check
	diff -q /tmp/crontab_check /root/crontab_hashed
	if [ $? -ne 0 ]
	then
		echo 'file /etc/crontab was modified' | senmail root
		md5sum /etc/crontab >> /root/crontab_hashed
	fi
else
	md5 /etc/crontab | cut -d ' ' -f 4 > /root/crontab_hashed
fi
