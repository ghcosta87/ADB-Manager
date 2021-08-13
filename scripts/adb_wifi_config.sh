#!/bin/bash
# Configura o adb sobre o Wifi

adb kill-server

echo "1"
adb tcpip 5555

sleep 5
echo "2"
ip=$(adb shell ip addr show wlan0 | awk '/inet / { print $2 }' | awk -F "/" '{ print $1 }')

echo "3"
echo "$ip"

sleep 2
echo "4"
adb connect $ip:5555

echo "5"
echo $ip > ip.txt

exit
