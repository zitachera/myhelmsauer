#!/bin/bash
 echo Update Schadenmelder
 
 if [[ -f ./schadenmelder ]] ;
 then
   scp ./schadenmelder  mailprox-jump-redmine:.
   ssh mailprox-jump-redmine 'sudo /home/jan/adm/update_schadenmelder'
 else
   echo no new schadenmelder found in current dir
 fi