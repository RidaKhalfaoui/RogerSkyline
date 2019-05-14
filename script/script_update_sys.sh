#! bin/bash

/usr/bin/apt-get update
/usr/bin/apt-get upgrade

echo "[NEW] ===============" >> /var/log/update_script.log
echo "date et Heure" >> /var/log/update_script.log
echo $(date "+%F %H:%M:%S") >> /var/log/update_script.log
echo "=====================" >> /var/log/update_script.log
