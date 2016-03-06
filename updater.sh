#!/bin/bash
echo =================================
echo 1 Update CC_WRT sources
echo 2 Update BB_WRT sources
echo 3 Update trunk_WRT sources
echo =================================
echo -n "Choose an action: "
read item
case "$item" in
  1) echo "Updating..."
  cd build_dir/cc_wrt && git pull
  ;;
  2) echo "Updating..."
  cd build_dir/bb_wrt && git pull
  ;;
  3) echo "Updating..."
  cd build_dir/trunk_wrt && git pull
  ;;
  *) echo "Nothing entered"
  ;;
esac
