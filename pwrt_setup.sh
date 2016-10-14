#!/bin/bash

manuallaunch=true

PWD=$(pwd)
DIR=$PWD

figlet PulshenWRT

function callpwrt {
  cd tmp && git clone https://github.com/Sudokamikaze/"$git".git
  echo Applying patches
  cp -r $git/files ../build_dir/$dirwrt/
  cd ../build_dir/$dirwrt && patch < ../../tmp/$git/$git.diff
  if [ $dirwrt == cc_wrt ]; then
  cp $git/feeds.conf.default ../build_dir/$dirwrt/
fi
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
  false) echo Automatic install for $dirwrt
  eval $(grep dirwrt= ./device_selector.sh)
  if [ $dirwrt == cc_wrt ]; then
  item=1
  elif [ $dirwrt == trunk_wrt ]; then
  item=2
  elif [ $dirwrt == trunk_lede ]; then
  item=3
  fi
  definevars
  ;;
  true) displaymenu
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
case "$morelove" in
  cc_wrt) calluboot
  ;;
  trunk_wrt) calluboot
  ;;
  trunk_lede) calluboot
  ;;
esac
echo Done
cd $DIR
