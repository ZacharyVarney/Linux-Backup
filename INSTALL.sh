#!/bin/bash

clear

read -p "Do you use an NVIDIA gpu [y/n]: " ANS

if [[ "$ANS" == "y" ]]; 
then
	sudo archinstall --config /home/zach/Desktop/nvidia_user_configuration.json
else
	sudo archinstall --config /home/zach/Desktop/user_configuration.json
fi

echo " "
echo " "
echo "Base system install completed."
