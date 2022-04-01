
wsl go build


  scp ./server mailprox-test-deployer-jump-redmine:schadenmelder
  ssh mailprox-test-deployer-jump-redmine "sudo /home/deployer/adm/update_schadenmelder"
