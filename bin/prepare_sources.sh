#!/bin/bash
cd build_dir
echo ========================
echo 1 Barrier Breaker
echo 2 Chaos Calmer
echo 3 Trunk
echo ========================
echo -n "Choose action: "
read item
case "$item" in
  1) echo "Cloning repository"
  git clone git://git.openwrt.org/14.07/openwrt.git bb_wrt && cd bb_wrt && ./scripts/feeds update -a && ./scripts/feeds install -a
  cp ../../configs_default/config_bb ./.config
  ;;
  2) echo "Cloning repository"
  git clone git://git.openwrt.org/15.05/openwrt.git cc_wrt && cd cc_wrt && ./scripts/feeds update -a && ./scripts/feeds install -a
  cp ../../configs_default/config_cc ./.config
  ;;
  3) echo "Cloning repository"
  git clone git://git.openwrt.org/openwrt.git trunk_wrt && cd trunk_wrt && ./scripts/feeds update -a && ./scripts/feeds install -a
  ../../configs_default/config_trunk ./.config
  ;;
  *) echo "Waiting for input"
  ;;
esac
