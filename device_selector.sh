#!/bin/bash
echo -n "Install libs for building? Y/n: "
read libs
case "$libs" in
  y|Y) ./bin/prepare_utils.sh
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
  ./bin/prepare_sources.sh
  ./pwrt_setup.sh
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
echo Done!
