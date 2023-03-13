#!/bin/sh
trap "exit" SIGINT
trap "exit" SIGTERM

echo "# Starting Dockcheck-Exporter"
echo "# This might take a while, it depends on how many containers are running #"
echo "Will send information to" $MAIN_DCW

if [ -n "$HOSTNAME" ]; then
        echo $HOSTNAME > /etc/hostname
fi

#if [ -n "$CRON_TIME" ]; then
#    
#    hour=$(echo $CRON_TIME | grep -Po "\d*(?=:)")
#    minute=$(echo $CRON_TIME | grep -Po "(?<=:)\d*")
#    echo -e "\n$minute  $hour   *   *   *   run-parts /etc/periodic/daily" >> /app/root
#
#    else
#
#    echo -e "\n30 12  *   *   *   run-parts /etc/periodic/daily" >> /app/root 
#fi
if [ -n "$EXCLUDE" ]; then
    echo $EXCLUDE > /app/EXCLUDE
fi
cd /app && tar xzvf /app/docker.tgz > /dev/null 2>&1 && cp /app/docker/* /usr/bin/ > /dev/null 2>&1
chmod +x /app/dockcheck*
chmod +x /app/regctl
mv /app/regctl /usr/bin/regctl
exec /app/dockcheck


