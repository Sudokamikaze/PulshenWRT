#!/bin/bash

PWD=$(pwd)
DIR=$PWD

figlet PulshenWRT

function callpwrt {
  cd tmp && git clone https://github.com/Sudokamikaze/"$git".git
  echo Applying patches
  cp -r $git/files ../build_dir/$dirwrt/
  cd ../build_dir/$dirwrt && patch < ../../tmp/$git/$git.diff
  cd ../../
}

function calluboot {
  cd build_dir/$dirwrt
  cd target/linux/ar71xx/files/drivers/mtd/
  patch < ../../../../../../../../tmp/$git/uboot_unlock.patch
}

function definevars {
  case "$item" in
    1) echo "Cloning repo"
    git=PulshenWRT_CC
    dirwrt=cc_wrt
    callpwrt
    ;;
    2) echo "Cloning repo"
    git=PulshenWRT_trunk
    dirwrt=trunk_wrt
    callpwrt
    ;;
    3) echo "Cloning repo"
    git=PulshenWRT_LEDE
    dirwrt=trunk_lede
    callpwrt
    ;;
    *) echo "Waiting for input"
    ;;
  esac
}

function displaymenu {
  echo ======================================
  echo "1. PulshenWRT stable (OPENWRT 15.05.1)"
  echo "2. PulshenWRT upstream (OPENWRT Trunk)"
  echo "3. PulshenWRT testing (LEDE TRUNK)"
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
  fi
  definevars
  ;;
  *) displaymenu
  ;;
esac
echo -n "Do you need U-Boot Unlock? [Y/N]: "
read ubootcheck
if [ $ubootcheck == y ]; then
echo "Unlock.."
elif [ $ubootcheck == Y ]; then
echo "Unlock.."
else
  echo " "
fi
case "$dirwrt" in
  cc_wrt) calluboot
  ;;
  trunk_wrt) calluboot
  ;;
  trunk_lede) calluboot
  ;;
esac
echo Done
cd $DIR
if [ $manuallaunch == false ]; then
unset manuallaunch
unset autoinstall
fi
