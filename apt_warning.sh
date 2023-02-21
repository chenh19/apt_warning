#!/bin/bash
# This script configures KDE plasma settings

# set terminal font color
TEXT_YELLOW='\e[1;33m'
TEXT_GREEN='\e[1;32m'
TEXT_RESET='\e[0m'

# set working directory
sudo echo ""
cd ~

# download gpg transferring script
echo -e "${TEXT_YELLOW}Transferring legacy gpg.${TEXT_RESET}\n" && sleep 1
[ ! -f ./.gpg_transfer.sh ] && wget -q https://raw.githubusercontent.com/chenh19/apt_warning/main/gpg_transfer.sh -O ./.gpg_transfer.sh

# edit gpg transferring script and run
echo -e "${TEXT_YELLOW}Please manually assign the IDs (last 8 characters, no space) , then save and close the script file to continue.${TEXT_RESET}\n"
sudo apt-key list >> ./.gpg_transfer.sh && kwrite ./.gpg_transfer.sh
sleep 1 && sed -i "30,500d" ./.gpg_transfer.sh
sleep 1 && bash ./.gpg_transfer.sh && sleep 1

# disable ESM apps warning
if grep -q "deb https://esm.ubuntu.com/apps/ubuntu jammy-apps-security main" /var/lib/ubuntu-advantage/apt-esm/etc/apt/sources.list.d/ubuntu-esm-apps.list ; then sudo sed -i 's+deb https://esm.ubuntu.com/apps/ubuntu jammy-apps-security main+#deb https://esm.ubuntu.com/apps/ubuntu jammy-apps-security main+g' /var/lib/ubuntu-advantage/apt-esm/etc/apt/sources.list.d/ubuntu-esm-apps.list  && sudo update-grub ; fi
if grep -q "deb https://esm.ubuntu.com/apps/ubuntu jammy-apps-updates main" /var/lib/ubuntu-advantage/apt-esm/etc/apt/sources.list.d/ubuntu-esm-apps.list ; then sudo sed -i 's+deb https://esm.ubuntu.com/apps/ubuntu jammy-apps-updates main+#deb https://esm.ubuntu.com/apps/ubuntu jammy-apps-updates main+g' /var/lib/ubuntu-advantage/apt-esm/etc/apt/sources.list.d/ubuntu-esm-apps.list  && sudo update-grub ; fi

# update apt
sudo update-grub && sudo apt-get update
rm -f ./.gpg_transfer.sh

