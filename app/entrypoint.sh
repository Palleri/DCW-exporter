#!/bin/sh

echo $POSTGRES_PASSWORD
echo $MAIN_DCW

echo "# Starting Dockcheck-web #"
echo "# Checking for new updates #"
echo "# This might take a while, it depends on how many containers are running #"

if [ -n "$HOSTNAME" ]; then
        echo $HOSTNAME > /etc/hostname
fi

if [ -n "$CRON_TIME" ]; then
    
    hour=$(echo $CRON_TIME | grep -Po "\d*(?=:)")
    minute=$(echo $CRON_TIME | grep -Po "(?<=:)\d*")
    echo -e "\n$minute  $hour   *   *   *   run-parts /etc/periodic/daily" >> /app/root

    else

    echo -e "\n30 12  *   *   *   run-parts /etc/periodic/daily" >> /app/root 
fi

if [ "$NOTIFY" = "true" ]; then
    if [ -n "$NOTIFY_URLS" ]; then
        echo $NOTIFY_URLS > /app/NOTIFY_URLS
        echo "Notify activated"
    fi

    if [ -n "$EXCLUDE" ]; then
    echo $EXCLUDE > /app/EXCLUDE
    fi

    if [ "$NOTIFY_DEBUG" = "true" ]; then
        echo $NOTIFY_DEBUG > /app/NOTIFY_DEBUG
        echo "NOTIFY DEBUGMODE ACTIVATED"  
    fi
fi

cd /app && tar xzvf /app/docker.tgz > /dev/null 2>&1 && cp /app/docker/* /usr/bin/ > /dev/null 2>&1
chmod +x /app/dockcheck*
chmod +x /app/regctl
mv /app/regctl /usr/bin/regctl

/app/dockcheck

while :
do
	echo "Press [CTRL+C] to stop.."
	sleep 1
done