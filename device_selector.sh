#!/bin/bash

function callpwrt {
  git clone $git $dirwrt && cd $dirwrt
  ./scripts/feeds update -a && ./scripts/feeds install -a
  cp ../../configs_default/config_$config ./.config
}


echo -n "Install libs for building? Y/n: "
read libs
case "$libs" in
  y|Y) echo "Installing..."
  eval $(grep ID= /etc/os-release)
  if [ $ID == arch ]; then sudo pacman -S --needed subversion asciidoc bash bc binutils bzip2 fastjar flex git gcc-multilib util-linux gawk intltool zlib make cdrkit ncurses openssl patch perl-extutils-makemaker rsync sdcc unzip wget gettext libxslt boost libusb bin86 sharutils b43-fwcutter findutils
elif [ $ID == ubuntu ]; then sudo apt-get install subversion git g++ libncurses5-dev zlib1g-dev gawk libssl-dev
  else
   echo Unsuported distro, u may install this manualy.
  fi
  echo Done!
  ;;
  n|N)
  ;;
esac
echo Select the device
echo =======================================
echo "1 TPLink TL-WR841N(D) only V8 or V8.*"
echo "2 x86(For virtualbox)"
echo =======================================
echo -n "Choose the device: "
read item
case "$item" in
  1) echo "Starting the setup process for TL-WR841N"
  ;;
  2) echo "Starting the setup process for x86"
  cd build_dir
  git clone git@github.com:lede-project/source.git x86_lede && cd x86_lede
  ./scripts/feeds update -a && ./scripts/feeds install -a
  cp ../../configs_default/config_x86_lede ./.config
  ;;
  *) echo "Nothing entered"
  ;;
esac
echo ========Openwrt=========
echo "1. Chaos Calmer"
echo "2. Trunk"
echo =========LEDE===========
echo "3. Latest trunk"
echo ========================
echo -n "Choose version: "
read sources
case "$sources" in
  1) echo "Cloning repo"
dirwrt=cc_wrt
git=git://git.openwrt.org/15.05/openwrt.git
config=cc
callpwrt
  ;;
  2) echo "Cloning repo"
dirwrt=trunk_wrt
git=git://git.openwrt.org/openwrt.git
config=trunk
callpwrt
  ;;
  3) echo "Clonning repo"
dirwrt=trunk_lede
git=https://git.lede-project.org/source.git
config=lede_trunk
callpwrt
  ;;
  *) echo "Waiting for input"
  ;;
esac
echo "Starting PWRT setup script..."
cd ../../
find ./pwrt_setup.sh -name pwrt_setup.sh -exec sed -i "s/true/false/g" {} \;
./pwrt_setup.sh
find ./pwrt_setup.sh -name pwrt_setup.sh -exec sed -i "s/false/true/g" {} \;
