#!/bin/bash

manuallaunch=true

figlet PulshenWRT

function callpwrt {
  cd tmp && git clone https://github.com/Sudokamikaze/"$imlovewrt".git
  echo Applying patches
  cp -r $imlovewrt/files ../build_dir/$morelove/
  cd ../build_dir/$morelove && patch < ../../tmp/$imlovewrt/$imlovewrt.diff
  if [ $morelove == cc_wrt ]; then
  cp $imlovewrt/feeds.conf.default ../build_dir/$morelove/
fi
  cd ../../
}

function calluboot {
  cd build_dir/$morelove
  cd target/linux/ar71xx/files/drivers/mtd/
  patch < ../../../../../../../../tmp/$imlovewrt/uboot_unlock.patch
}

function definevars {
  case "$item" in
    1) echo "Cloning repo"
    imlovewrt=PulshenWRT_CC
    morelove=cc_wrt
    callpwrt
    ;;
    2) echo "Cloning repo"
    imlovewrt=PulshenWRT_trunk
    morelove=trunk_wrt
    callpwrt
    ;;
    3) echo "Cloning repo"
    imlovewrt=PulshenWRT_LEDE
    morelove=trunk_lede
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
echo -n "Do you need U-Boot Unlock? "
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
