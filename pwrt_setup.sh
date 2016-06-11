#!/bin/bash
figlet PulshenWRT
echo ======================================
echo "1. PulshenWRT stable (OPENWRT 15.05.1)"
echo "2. PulshenWRT upstream (OPENWRT Trunk)"
echo "3. PulshenWRT testing (LEDE TRUNK)"
echo ======================================
echo -n "Select version: "
read item
case "$item" in
  1) echo "Cloning repo"
  cd tmp && git clone https://github.com/Sudokamikaze/PulshenWRT_CC.git
  echo Applying patches
  cp -r PulshenWRT_CC/files ../build_dir/cc_wrt/
  cd ../build_dir/cc_wrt && patch < ../../tmp/PulshenWRT_CC/PulshenWRT_CC.diff
  cp PulshenWRT_CC/feeds.conf.default ../build_dir/cc_wrt/
  ;;
  2) echo "Cloning repo"
  cd tmp && git clone https://github.com/Sudokamikaze/PulshenWRT_trunk.git
  echo Applying patches
  cp -r PulshenWRT_trunk/files ../build_dir/trunk_wrt/
  cd ../build_dir/trunk_wrt && patch < ../../tmp/PulshenWRT_trunk/PulshenWRT_trunk.diff
  ;;
  3) echo "Cloning repo"
  cd tmp && git clone git@github.com:Sudokamikaze/PulshenWRT_LEDE.git
  echo Applying patches
  cp -r PulshenWRT_LEDE/files ../build_dir/trunk_lede/
  cd ../build_dir/trunk_lede && patch < ../../tmp/PulshenWRT_LEDE/PulshenWRT_LEDE.diff
  ;;
  *) echo "Waiting for input"
  ;;
esac
echo Do you need U-Boot Unlock?
echo ======================================
echo 1 Unlock u-boot for PulshenWRT CC
echo 2 Unlock u-boot for PulshenWRT TRUNK
echo 3 Unlock u-boot for PulshenWRT LEDE
echo ======================================
echo -n "Choose an action: "
read uboot
case "$uboot" in
  1) echo "Unlocking for CC"
  cd build_dir/cc_wrt/target/linux/ar71xx/files/drivers/mtd/
  patch < ../../../../../../../../tmp/PulshenWRT_CC/uboot_unlock.patch
  ;;
  2) echo "Unlocking for TRUNK"
  cd build_dir/trunk_wrt/target/linux/ar71xx/files/drivers/mtd/
  patch < ../../../../../../../../tmp/PulshenWRT_trunk/uboot_unlock.patch
  ;;
  3) echo "Unlocking for LEDE"
  cd build_dir/trunk_lede/target/linux/ar71xx/files/drivers/mtd/
  patch < ../../../../../../../../tmp/PulshenWRT_LEDE/uboot_unlock.patch
  ;;
  *) echo "Waiiting for input"
  ;;
esac
echo Done
