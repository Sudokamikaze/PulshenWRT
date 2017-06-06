#!/bin/bash

TOPDIR=$(pwd)

figlet PulshenWRT

function callpwrt {
  echo " "
  if [ "$branch" != "stable" ]; then
    cd tmp && git clone https://github.com/Sudokamikaze/"$git".git
  else
    cd tmp && git clone https://github.com/Sudokamikaze/"$git".git -b stable
  fi
  echo Applying patches
  cp -r $git/files ../build_dir/$dirwrt/
  cd ../build_dir/$dirwrt && patch < ../../tmp/$git/$git.diff
  cd ../../
}

function calluboot {
  cd build_dir/$dirwrt/target/linux/ar71xx/files/drivers/mtd/
  patch < ../../../../../../../../tmp/$git/uboot_unlock.patch
}

function definevars {
  case "$item" in
    1)
    git=PulshenWRT_CC
    dirwrt=cc_wrt
    callpwrt
    ;;
    2)
    git=PulshenWRT_trunk
    dirwrt=trunk_wrt
    callpwrt
    ;;
    3)
    git=PulshenWRT_LEDE
    dirwrt=trunk_lede
    callpwrt
    ;;
    4)
    git=PulshenWRT_LEDE
    branch=stable
    dirwrt=stable_lede
    callpwrt
    ;;
    *) echo "Error"
    exit 1
    ;;
  esac
}

function displaymenu {
  echo ======================================
  echo "1. PulshenWRT old stable (OPENWRT 15.05.1)"
  echo "2. PulshenWRT old stable (OPENWRT Trunk)"
  echo "3. PulshenWRT upsteam (LEDE TRUNK)"
  echo "4. PulshenWRT stable  (LEDE 17.01)"
  echo ======================================
   echo -n "Select version: "
   read item
   definevars
}

case "$manuallaunch" in
  false)
  if [ $autoinstall == cc_wrt ]; then
  item=1
elif [ $autoinstall == trunk_wrt ]; then
  item=2
elif [ $autoinstall == trunk_lede ]; then
  item=3
elif [ "$autoinstall" == "stable_lede" ]; then
  item=4
  fi
  definevars
  ;;
  *) displaymenu
  ;;
esac
echo -n "Do you need U-Boot Unlock? [Y/N]: "
read ubootcheck
case "$ubootcheck" in
  y|Y) calluboot
  ;;
esac
cd $DIR
rm -rf tmp/*
if [ $manuallaunch == false ]; then
unset manuallaunch
unset autoinstall
fi
