#!/bin/bash
echo -n "Install libs for building? Y/n: "
read libs
case "$libs" in
  y|Y) echo "Installing..."
  OS=$(cat /etc/*-release | grep ID=)
  echo $OS
  if [ $OS == ID=arch ]; then sudo pacman -S --needed subversion asciidoc bash bc binutils bzip2 fastjar flex git gcc util-linux gawk intltool zlib make cdrkit ncurses openssl patch perl-extutils-makemaker rsync sdcc unzip wget gettext libxslt boost libusb bin86 sharutils b43-fwcutter findutils
  elif [ $OS == ID=ubuntu ]; then sudo apt-get install subversion git g++ libncurses5-dev zlib1g-dev gawk libssl-dev
  else
   echo Unsuported distro
  fi
  echo Done!
  ;;
  n|N)
  ;;
esac
echo Select the device
echo ======================
echo "1 TPLink TL-WR841N(D)"
echo "2 x86(For virtualbox)"
echo ======================
echo -n "Choose the device: "
read item
case "$item" in
  1) echo "Starting the setup process for TL-WR841N"
  ;;
  2) echo "Starting the setup process for x86"
  cd build_dir
  git clone git://git.openwrt.org/openwrt.git trunk_wrt && cd trunk_wrt
  ./scripts/feeds update -a && ./scripts/feeds install -a
  cp ../../configs_default/config_x86 ./.config
  ;;
  *) echo "Nothing entered"
  ;;
esac
echo ========Openwrt=========
echo "1. Barrier Breaker"
echo "2. Chaos Calmer"
echo "3. Trunk"
echo =========LEDE===========
echo "4. Latest trunk"
echo ========================
echo -n "Choose version: "
read sources
case "$sources" in
  1) echo "Cloning repo"
  cd build_dir
  git clone git://git.openwrt.org/14.07/openwrt.git bb_wrt && cd bb_wrt
  ./scripts/feeds update -a && ./scripts/feeds install -a
  cp ../../configs_default/config_bb ./.config
  ;;
  2) echo "Cloning repo"
  cd build_dir
  git clone git://git.openwrt.org/15.05/openwrt.git cc_wrt && cd cc_wrt
  ./scripts/feeds update -a && ./scripts/feeds install -a
  cp ../../configs_default/config_cc ./.config
  ;;
  3) echo "Cloning repo"
  cd build_dir
  git clone git://git.openwrt.org/openwrt.git trunk_wrt && cd trunk_wrt
  ./scripts/feeds update -a && ./scripts/feeds install -a
  cp ../../configs_default/config_trunk ./.config
  ;;
  4) echo "Clonning repo"
  cd build_dir
  git clone git@github.com:lede-project/source.git trunk_lede && cd trunk_lede
  ./scripts/feeds update -a && ./scripts/feeds install -a
  cp ../../configs_default/config_lede_trunk ./.config
  ;;
  *) echo "Waiting for input"
  ;;
esac
echo "Starting PWRT setup script..."
cd ../../
./pwrt_setup.sh
