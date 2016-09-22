#!/bin/bash
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

echo ======================================
echo "1. PulshenWRT stable (OPENWRT 15.05.1)"
echo "2. PulshenWRT upstream (OPENWRT Trunk)"
echo "3. PulshenWRT testing (LEDE TRUNK)"
echo ======================================
echo -n "Select version: "
read item
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
echo -n "Do you need U-Boot Unlock? "
read ubootcheck
if [ $ubootcheck == y ]; then
echo "OK, that version of PulshenWRT you have?"
elif [ $ubootcheck == Y ]; then
echo "OK, that version of PulshenWRT you have?"
else
  echo " "
fi
echo ======================================
echo 1 Unlock u-boot for PulshenWRT CC
echo 2 Unlock u-boot for PulshenWRT TRUNK
echo 3 Unlock u-boot for PulshenWRT LEDE
echo ======================================
echo -n "Choose an action: "
read uboot
case "$uboot" in
  1) echo "Unlocking for CC"
  calluboot
  ;;
  2) echo "Unlocking for TRUNK"
  calluboot
  ;;
  3) echo "Unlocking for LEDE"
  calluboot
  ;;
  *) echo "Waiiting for input"
  ;;
esac
echo Done
