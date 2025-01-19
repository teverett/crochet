

#!/bin/sh

pwd
sudo pkg install -y git
sudo pkg install -y python
sudo pkg install -y u-boot-rpi3
sudo pkg install -y sysutils/rpi-firmware
sudo git clone -b releng/14.2 https://git.freebsd.org/src.git /usr/src
ls -lat /usr/src
sh crochet.sh -c ci/configs/config_RaspberryPi3.sh

# we dont want to sync the all the obj's back to the ubuntu host
rm -rf work/obj

