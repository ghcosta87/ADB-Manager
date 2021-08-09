#!/bin/bash
# Salva os dados filtrados

function ler_ip(){
 ip=$(adb shell ip addr show wlan0 | awk '/inet / { print $2 }' | awk -F "/" '{ print $1 }')
 echo $ip
 echo "$ip" > ip.txt
}

function ler_endereco(){
 endereco=$(adb devices -l | awk '"List" { print $1 }' | awk -F "L" '{ print $1 }')
 echo $endereco
 echo "$endereco" > endereco.txt
}

function ler_modelo(){
 modelo=$(adb devices -l | awk '"List" { print $5 }' | awk -F ":" '{ print $2 }')
 echo $modelo
 echo "$modelo" > modelo.txt
}

function verificar_conexao(){
 modelo=$(cat modelo.txt)
 if [[ -z $modelo ]];then
  saida=0
  echo "$saida" > conexao.txt
 elif [[ -n "$modelo" ]]; then
  saida=1
  echo "$saida" > conexao.txt
 fi
  echo $saida
}

ler_ip

ler_endereco

ler_modelo

verificar_conexao

exit
