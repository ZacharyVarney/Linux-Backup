#!/bin/bash

clear

read -p "Do you use an NVIDIA gpu [y/n]: " ANS

if [[ "$ANS" == "y" ]]; 
then
	sudo archinstall --config /home/live/install-configs/nvidia_user_configuration.json
else
	sudo archinstall --config /home/live/install-configs/user_configuration.json
fi

echo " "
echo " "
echo " "
echo "Base system installed, you may now reboot & run SETUP.sh"
sleep 5
