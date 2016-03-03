#!/bin/bash
echo ============================
echo 1 PulshenWRT 14.04
echo 2 PulshenWRT 15.05
echo 3 PulshenWRT Trunk
echo ============================
echo -n "Choose an action: "
read item
case "$item" in
  1) echo "Cloning repository"
  cd tmp && git clone https://github.com/Sudokamikaze/PulshenWRT_BB.git &&  echo Applying patches && cp -r PulshenWRT_BB/files ../build_dir/bb_wrt/ && cd ../build_dir/bb_wrt && patch < ../../tmp/PulshenWRT_BB/PulshenWRT_BB.diff
  ;;
  2) echo "Cloning repository"
  cd tmp && git clone https://github.com/Sudokamikaze/PulshenWRT_CC.git &&  echo Applying patches && cp -r PulshenWRT_CC/files ../build_dir/cc_wrt/ && cd ../build_dir/cc_wrt && patch < ../../tmp/PulshenWRT_CC/PulshenWRT_CC.diff
  cp PulshenWRT_CC/feeds.conf.default ../build_dir/cc_wrt/
  ;;
  3) echo "Cloning repository"
  cd tmp && git clone https://github.com/Sudokamikaze/PulshenWRT_trunk.git &&  echo Applying patches && cp -r PulshenWRT_trunk/files ../build_dir/trunk_wrt/ && cd ../build_dir/trunk_wrt && patch < ../../tmp/PulshenWRT_trunk/PulshenWRT_trunk.diff
  ;;
  *) echo "Waiting for input"
  ;;
esac
echo ======================================
echo Do you need U-Boot Unlock?
echo 1 Unlock u-boot for PulshenWRT_BB
echo 2 Unlock u-boot for PulshenWRT_CC
echo 3 Unlock u-boot for PulshenWRT_trunk
echo ======================================
echo -n "Choose an action: "
read uboot
case "$uboot" in
  1) echo "Unlocking for BB"
  cd ../build_dir/bb_wrt/target/linux/ar71xx/files/drivers/mtd/
  patch < ../../../../../../../../tmp/PulshenWRT_BB/uboot_unlock.patch
  ;;
  2) echo "Unlocking for CC"
  cd ../build_dir/cc_wrt/target/linux/ar71xx/files/drivers/mtd/
  patch < ../../../../../../../../tmp/PulshenWRT_CC/uboot_unlock.patch
  ;;
  3) echo "Unlocking for trunk"
  cd ../build_dir/trunk_wrt/target/linux/ar71xx/files/drivers/mtd/
  patch < ../../../../../../../../tmp/PulshenWRT_trunk/uboot_unlock.patch
  ;;
  *) echo "Waiiting for input"
  ;;
esac
echo Done
