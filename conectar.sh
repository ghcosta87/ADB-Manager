#!/bin/bash
# Configura o adb sobre o Wifi

adb kill-server

while getopts i: flag
do
    case "${flag}" in
        i) ip=${OPTARG};;
    esac
done

echo "ip para conectar: $ip";

adb connect $ip:5555

exit
