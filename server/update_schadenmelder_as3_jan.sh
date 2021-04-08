#!/bin/bash
wsl go build

 
 if [[ -f ./server ]] ;
 then
   scp ./server  mailprox-jump-redmine:schadenmelder
   ssh mailprox-jump-redmine 'sudo /home/jan/adm/update_schadenmelder'
 else
   echo no new server found in current dir
 fi