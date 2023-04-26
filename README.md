# My Arch Linux Setup

## Description
This is the setup process to install a fresh arch system to be setup the way mine is.

## DISCLAIMER
This tutorial is based off of the main Arch ISO as I don't want to take the time maintaining my own. Their is also no guarantee this process will work the same on other Arch based distrobutions.


## Installation
1. After booting into the archiso git clone my repo that has the required config files.
```
git clone https://github.com/ZacharyVarney/Linux-Backup
```
2. Run the following command to install & run archinstall. *NOTE* You will need to change some of the archinstall values yourself as I cannot speak for you specific system, an example of this would be your disk partitioning.
```
cd Linux-Backup; pacman -Sy archinstall; archinstall --config user-configuration.json
```
4. After installation is finished it will ask you to chroot into the newly installed system, select no & reboot into the newly installed system.

5. Login under your created user & git clone my github repo again.
```
git clone https://github.com/ZacharyVarney/Linux-Backup
```
6. Run the following command for post installation setup.
```
cd ~/Linux-Backup; bash SETUP.sh
```
