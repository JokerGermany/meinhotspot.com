#!/bin/sh
#replace in XX%3AXX%3AXX%3AXX%3AXX%3AXX the XX with your the MAC adress of your Fritz!Box 
RAND=$(echo "$(date +%s)" | md5sum | sed -n -e "s/\([0-9a-f]\{6\}\).*/\1/p" ) #zufällige Zahl für delay
echo "${RAND}"
BODY="dst=https%3A%2F%2Fconnect.meinhotspot.com%2Fde%2Fclient%2Fredirect&popup=true&username=XX%3AXX%3AXX%3AXX%3AXX%3AXX&password=XX%3AXX%3AXX%3AXX%3AXX%3AXX&mac=XX%3AXX%3AXX%3AXX%3AXX%3AXX"
wget -q -O- login.meinhotspot.com/login | grep 'Sie wurden soeben auf dem Hotspot eingeloggt und werden weitergeleitet.'
rc=$?
if [ $rc -ne 0 ]
then
	echo -ne "POST /login HTTP/1.1\r\nHost: login.meinhotspot.com\r\nUser-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:52.0) Gecko/20100101 	Firefox/52.0\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nAccept-Language: en-US,en;q=0.5\r\nAccept-Encoding: gzip, deflate, br\r\nReferer: https://connect.meinhotspot.com/en/client/welcome\r\nConnection: Close\r\nUpgrade-Insecure-Requests: 1\r\nContent-Type: application/x-www-form-urlencoded\r\nContent-Length: ${#BODY}\r\n\r\n${BODY}" | nc login.meinhotspot.com 80
	delay -d 10 ${RAND} '/var/media/ftp/FRITZ/meinhotspotschleife.sh  > /var/media/ftp/FRITZ/meinhotspot.log'
else
	time=`wget -q -O- login.meinhotspot.com/status | grep "s</td" | sed 's/<[^>]*>//g' | sed 's/\t//g' | cut -f3 -d"/"`
	echo $time | grep "h" 
	rc=$?
	if [ $rc -eq 0 ]
	then
		hour=`echo $time | cut -f1 -d"h"`
		echo $time | grep "m" 
		rc=$?
		if [ $rc -eq 0 ]
		then
			minute=$((`echo $time | cut -f2 -d"h" | cut -f1 -d"m"`+$hour*60))
		else
			minute=$(($hour*60))
		fi
	else
		echo $time | grep "m" 
		rc=$?
		if [ $rc -eq 0 ]
		then
			minute=`echo $time | cut -f1 -d"m"`
		else
			minute=1
		fi
	fi
	if [ $minute -lt 5 ]
	then
		echo "weniger als 5 Minuten"
		wget -qO- login.meinhotspot.com/logout>/dev/null
		#BODY_LEN=$( echo -n ${BODY} | wc -c )
		#echo $BODY_LEN
		#echo ${#BODY}
		sleep 1
		echo -ne "POST /login HTTP/1.1\r\nHost: login.meinhotspot.com\r\nUser-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:52.0) Gecko/20100101 	Firefox/52.0\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nAccept-Language: en-US,en;q=0.5\r\nAccept-Encoding: gzip, deflate, br\r\nReferer: https://connect.meinhotspot.com/en/client/welcome\r\nConnection: Close\r\nUpgrade-Insecure-Requests: 1\r\nContent-Type: application/x-www-form-urlencoded\r\nContent-Length: ${#BODY}\r\n\r\n${BODY}" | nc login.meinhotspot.com 80
		delay -d 10 ${RAND} '/var/media/ftp/FRITZ/meinhotspotschleife.sh  > /var/media/ftp/FRITZ/meinhotspot.log'
	else
		echo "mehr als 5 Minuten"
		#echo $minute
		seconds=$((minute*60-60))
		#echo $seconds
		#sleep $seconds
		delay -d $seconds ${RAND} '/var/media/ftp/FRITZ/meinhotspotschleife.sh  > /var/media/ftp/FRITZ/meinhotspot.log'
	fi
fi
