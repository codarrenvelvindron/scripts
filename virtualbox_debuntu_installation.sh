#!usr/bin/env bash
source="deb https://download.virtualbox.org/virtualbox/"
source_opts_os_deb=`cat /etc/os-release | grep '^ID=' | cut -d = -f 2`
source_opts_codename_ubu=`cat /etc/os-release | grep VERSION_CODENAME= | cut -d = -f 2`
source_opts_codename_deb=`cat /etc/os-release | grep VERSION= | cut -d = -f 2 | tr -d '()"' | awk '{print $2}'`
source_opts_version=`cat /etc/os-release | grep '^VERSION_ID' | cut -d = -f 2 | tr -d '"'`

source_comp="contrib"
ubuntu_new_ver="16.04"
debian_new_ver="8"

ubuntu_deb_key_pub="oracle_vbox_2016.asc"
ubuntu_new_deb_key_dl="https://www.virtualbox.org/download/oracle_vbox_2016.asc"
ubuntu_old_deb_key_dl="https://www.virtualbox.org/download/oracle_vbox.asc"

debian_main_repo="deb http://deb.debian.org/"
debian_src_repo="deb-src http://deb.debian.org/"
debian_sec_repo="deb http://security.debian.org/debian-security/"
debian_src_sec="deb-src http://security.debian.org/debian-security/"

full_deb_sec_main="$debian_src_repo $debian_sec_main"
full_deb_sec_src="$debian_src_sec $debian_sec_main"
full_deb_main="$debian_main_repo$source_opts_os_deb $source_opts_codename_deb main"
full_deb_src="$debian_src_repo$source_opts_os_deb $source_opts_codename_deb main"
full_deb_upd_main="$debian_main_repo$source_opts_os_deb-updates main"
full_deb_upd_src="$debian_src_repo$source_opts_os_deb $source_opts_codename_deb main"

if [ $source_opts_os_deb = debian ]; then
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
echo "*****Downloading Oracle Public Keys\n"
echo "*****Adding Oracle VB sources\n"

if [ $source_opts_os_deb = ubuntu ]; then
  echo "*****Line to add to /etc/apt/sources.list: $source$source_opts_os_deb $source_opts_codename_ubu $source_comp\n"
  echo "$source$source_opts_os_deb $source_opts_codename_ubu $source_comp" >> /etc/apt/sources.list 
else
  echo "*****Line to add to /etc/apt/sources.list: $source$source_opts_os_deb $source_opts_codename_deb $source_comp\n"
  echo "$source$source_opts_os_deb $source_opts_codename_deb $source_comp" >> /etc/apt/sources.list
  echo "*****Do you wish to add additional sources?(Yes/No) No-Default should work. If not, rerun and say yes\n"
  read ans
  if [ "$ans" = Y ]; then
    echo ">> adding debian main, update and sec repos to sources.list\n"
    echo "$full_deb_sec_main" >> /etc/apt/sources.list
    echo "$full_deb_sec_src" >> /etc/apt/sources.list
    echo "$full_deb_main" >> /etc/apt/sources.list
    echo "$full_deb_src" >> /etc/apt/sources.list
    echo "$full_deb_upd_main" >> /etc/apt/sources.list
    echo "$full_deb_upd_src" >> /etc/apt/sources.list
    echo "<< done.."
  else
    echo "Nothing to do, proceeding"
  fi
fi
echo "*****Updating system"
sudo apt-get update
echo "*****Installing Virtualbox"
sudo apt-get install virtualbox
sudo apt-get install virtualbox-guest-additions-iso
echo "**Virtualbox installation completed!"
