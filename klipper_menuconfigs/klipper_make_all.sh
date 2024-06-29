#! /bin/bash

##########
# $1 is machine to flash, voron / bookworm
# $2 is start klipper true/false
# $3 is main / spare for UUID
##########

if [ "$#" -ne 3 ]; then
    echo "Illegal number of parameters"
	echo -n
	echo "arg 1 is machine to flash, voron / bookworm"
	echo "arg 2 is start klipper true/false"
	echo "arg 3 is main / spare for UUID"
	exit
fi

	
./klipper_make_raspberry.sh $2
./klipper_make_octopus-466.sh $2

case "$1" in

	voron)
	./klipper_make_voron_skirt_buttons.sh $2
	;;
	
	bookworm)
	if [[ -f /sys/class/net/can0/operstate ]]; then
		./klipper_make_mmb_can_backup.sh $2 $3
		./klipper_make_SB2209-can.sh $2
		./klipper_make_u2c.sh $2
	else
		echo can0 is DOWN.
	fi
	;;
esac

echo -n 
echo finished!! Starting klipper
sudo service klipper start
