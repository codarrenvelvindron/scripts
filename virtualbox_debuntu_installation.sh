#!usr/bin/env bash
source="deb https://download.virtualbox.org/virtualbox/"
source_opts_os_deb=`cat /etc/os-release | grep '^ID=' | cut -d = -f 2`
source_opts_codename=`cat /etc/os-release | grep VERSION_CODENAME= | cut -d = -f 2`
source_opts_version=`cat /etc/os-release | grep '^VERSION_ID' | cut -d = -f 2 | tr -d '"'`
source_comp="contrib"
ubuntu_new_ver="16.04"
debian_new_ver="8"
ubuntu_deb_key_pub="oracle_vbox_2016.asc"
ubuntu_new_deb_key_dl="https://www.virtualbox.org/download/oracle_vbox_2016.asc"
ubuntu_old_deb_key_dl="https://www.virtualbox.org/download/oracle_vbox.asc"

if [ $source_opts_os_deb = debian ]; then
  echo debian detected
  if (( $(awk 'BEGIN {print ("'$source_opts_version'" < "'$debian_new_ver'")}') ));
  then
    echo "**We have detected a version less than 8\n"
    echo "adding keys"
    wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
  else
    echo "**You are using 8 or later\n"
    echo "adding keys"
    wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
  fi
else
  echo ubuntu detected
  if (( $(awk 'BEGIN {print ("'$source_opts_version'" < "'$ubuntu_new_ver'")}') ));
  then
    echo "**We have detected a version less than 16.04\n"
    echo "adding keys"
    wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
  else
    echo "**You are using 16.04 or later\n"
    wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
  fi
fi

echo "*****OS detected: $source_opts_os_deb\n"
echo "*****Distribution detected: $source_opts_codename\n"
echo "*****Version detected: $source_opts_version\n"
echo "*****Line to add to /etc/apt/sources.list: $source$source_opts_os_deb $source_opts_codename $source_comp\n"
echo "*****Downloading Oracle Public Keys\n"

echo "*****Updating system"
sudo apt-get update
echo "*****Installing Virtualbox"
sudo apt-get install virtualbox
sudo apt-get install virtualbox-guest-additions-iso
echo "**Virtualbox installation completed!"