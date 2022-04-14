wsl go build

 
scp ./server  mailprox-jump-redmine:schadenmelder
ssh mailprox-jump-redmine "sudo /home/jan/adm/update_schadenmelder"
