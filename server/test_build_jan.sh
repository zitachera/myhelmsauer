#!/bin/bash
wsl go build

 
 if [[ -f ./server ]] ;
 then
   scp ./server testmailprox:schadenmelder
   ssh testmailprox 'sudo /home/jan/adm/update_schadenmelder'
 else
   echo no new server found in current dir
 fi