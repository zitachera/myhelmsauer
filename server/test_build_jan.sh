#!/bin/bash
wsl go build

 
 if [[ -f ./server ]] ;
 then
   scp ./server mailprox-test-deployer-jump-redmine:schadenmelder
   ssh mailprox-test-deployer-jump-redmine 'sudo /home/deployer/adm/update_schadenmelder'
 else
   echo no new server found in current dir
 fi