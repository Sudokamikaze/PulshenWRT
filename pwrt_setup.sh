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
  cd tmp && git clone https://github.com/Sudokamikaze/PulshenWRT_BB.git &&  echo Applying patches && cp -r PulshenWRT_BB/files ../bb_wrt/ && cd ../bb_wrt && patch < ../tmp/PulshenWRT_BB/PulshenWRT_BB.diff
  ;;
  2) echo "Cloning repository"
  cd tmp && git clone https://github.com/Sudokamikaze/PulshenWRT_CC.git &&  echo Applying patches && cp -r PulshenWRT_CC/files ../cc_wrt/ && cd ../cc_wrt && patch < ../tmp/PulshenWRT_CC/PulshenWRT_CC.diff
  ;;
  3) echo "Cloning repository"
  cd tmp && git clone https://github.com/Sudokamikaze/PulshenWRT_trunk.git &&  echo Applying patches && cp -r PulshenWRT_trunk/files ../trunk_wrt/ && cd ../trunk_wrt && patch < ../tmp/PulshenWRT_trunk/PulshenWRT_trunk.diff
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
  cd bb_wrt && patch < ../tmp/PulshenWRT_BB/uboot_unlock.patch
  ;;
  2) echo "Unlocking for CC"
  cd cc_wrt && patch < ../tmp/PulshenWRT_CC/uboot_unlock.patch
  ;;
  3) echo "Unlocking for trunk"
  cd trunk_wrt && patch < ../tmp/PulshenWRT_trunk/uboot_unlock.patch
  ;;
  *) echo "Waiiting for input"
  ;;
esac
echo Done
