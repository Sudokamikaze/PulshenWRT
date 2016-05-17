#!/bin/bash
figlet PulshenWRT
echo ====================
echo "1 - Build"
echo "2 - Clean"
echo "3 - Update"
echo ====================
echo -n "Choose an action: "
read menu
case "$menu" in
  1) echo "Starting build script section..."
  ;;
  2) echo "Starting clean script section..."
  echo There versions in main build dir:
  cd build_dir && ls
  echo -n "Select folder to clean and write name of it: "
  read clean
  cd $clean
  make clean
  echo Done!
  exit
  ;;
  3) echo "Starting update script section..."
  echo There versions in main build dir:
  cd build_dir && ls
  echo -n "Select folder to uodate and write name of it: "
  read update
  cd $update
  git pull
  ./scripts/feeds update -a
  ./scripts/feeds install -a
  echo Done!
  exit
  ;;
  *) echo "Error, unknow symbol, exiting..."
  ;;
esac
echo There versions in main build dir:
cd build_dir && ls
echo -n "Select folder to build and write name of it: "
read build
cd $build
echo ===========================
echo "1 Build toolchain & tools"
echo "2 Build firmware"
echo ===========================
echo -n "Choose an action: "
read pwrt
if [ $pwrt == 1 ]; then make tools/install ${MAKEFLAGS="-j$(nproc)"} V=-1 && make toolchain/install ${MAKEFLAGS="-j$(nproc)"} V=-1
elif [ $pwrt == 2 ]; then make ${MAKEFLAGS="-j$(nproc)"} V=-1
else
echo Error
fi
echo Done!
