#!/bin/bash
SM=schadenmelder
NEWVERSION=$(date +'%Y%m%d_%H:%M:%S %s' )
echo ${NEWVERSION}
sed  -i  s/"__VER:.*__"/"__VER:${NEWVERSION}__"/ ${SM} 
