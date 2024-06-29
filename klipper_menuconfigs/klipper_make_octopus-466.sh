#!/bin/bash

# device path to flash
DEVICE="/dev/serial/by-id/octopus"

cd ~/klipper/
make clean
#make menuconfig KCONFIG_CONFIG=~//printer_data/config/klipper_menuconfigs/config-octopus-446

echo -e 
echo -e 
echo -e 

echo -e "flashing: " $DEVICE

sudo service klipper stop
<<<<<<< HEAD
make flash FLASH_DEVICE=$flash_dev KCONFIG_CONFIG=~//printer_data/config/klipper_menuconfigs/config-octopus-446
make flash FLASH_DEVICE=0483:df11 KCONFIG_CONFIG=~//printer_data/config/klipper_menuconfigs/config-octopus-446

sudo service klipper start
=======
make flash FLASH_DEVICE=$DEVICE KCONFIG_CONFIG=~//printer_data/config/klipper_menuconfigs/config-octopus-446


# wait for the board to process, hopefully.
sleep 5

# sometimes this board will not flash correctly and get stuck in dfu mode.
# this additional flash line will ensure that it flashes there.
if [ ! -e "$DEVICE" ]; then
	echo -e
	echo -e
	echo -e 
	echo "reflashing, something went wrong"
	echo -e
	echo -e
	echo -e
	make flash FLASH_DEVICE=0483:df11 KCONFIG_CONFIG=~//printer_data/config/klipper_menuconfigs/config-octopus-446
fi

if [[ "$1" ]]; then
    echo NOT starting klipper
else
    echo starting klipper
    sudo service klipper start
fi

echo ---  END OCTOPUS  ---

>>>>>>> c094bdc098ac7e21e6b4851ff38611cf50abf1d1


