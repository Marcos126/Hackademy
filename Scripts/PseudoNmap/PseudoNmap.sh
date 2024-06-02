#!/bin/bash

function crtl_c (){
    echo -e "\n\n[!] Tarea finalizada de manera abrupta\n"
    tput cnorm; exit 1  
}

trap crtl_c SIGINT

ip="$1"

ports=$(seq 1 65535)

function pingPorts(){
    (exec 3<> /dev/tcp/$ip/$port) 2>/dev/null
    if [ $? -eq 0 ]; then
        echo "[+] Puerto \"$port\" abierto"
    fi
    exec 3>&-
    exec 3<&-
}
tput civis

if [ "$ip" = "" ]; then 
    echo "[!] Por favor ingrese una direccion IP"
    exit 1 
else
    for port in ${ports[@]}; do
        pingPorts $port &
    done
fi
wait

tput cnorm
