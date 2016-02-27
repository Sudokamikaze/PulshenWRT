#!/bin/bash
VAR=$(cat /etc/*-release | grep ID=)
echo $VAR
if [ $VAR == ID=arch ]; then sudo pacman -S --needed subversion asciidoc bash bc binutils bzip2 fastjar flex git gcc util-linux gawk intltool zlib make cdrkit ncurses openssl patch perl-extutils-makemaker rsync sdcc unzip wget gettext libxslt boost libusb bin86 sharutils b43-fwcutter findutils
elif [ $VAR == ID=ubuntu ]; then sudo apt-get install subversion git g++ libncurses5-dev zlib1g-dev gawk libssl-dev
else
 echo Unsuported distro
fi
echo Completed!
