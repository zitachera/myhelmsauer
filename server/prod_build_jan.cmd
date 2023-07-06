wsl go build

 
scp ./server  mailprox:schadenmelder
ssh mailprox "sudo /home/jan/adm/update_schadenmelder"
