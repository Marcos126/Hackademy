#!/bin/bash

nombres=("Pedro" "Pablo" "Martin" "Walter" "Alan" "Owen")
pingPorts() {
  echo "Hola $nombre"
}
contador=0
for nombre in ${nombres[@]};do
  pingPorts
  ((contador++))
  echo $contador
done
