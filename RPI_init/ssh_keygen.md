```
https://www.youtube.com/watch?v=Lt65Z30JcrI

run powersheell 
cd C:\Users\BP5589\.ssh>
ssh-keygen.exe
'Át kell másolni a pub fájlt a PI-re
type $env:USERPROFILE\.ssh\id_rsa.pub | ssh 192.168.1.201 "cat >> /home/rpi/.ssh/authorized_keys"
'a config fájlba:
Host 192.168.1.201
  HostName 192.168.1.201
  User rpi
  IdentityFile ~/.ssh/id_rsa
```
