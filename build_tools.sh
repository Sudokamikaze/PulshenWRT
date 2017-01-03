#!/bin/bash

# If u wan't to build *** define:
# trunk_lede for LEDE
# cc_wrt for Openwrt Chaos Calmer
# trunk_wrt for Openwrt TRUNK
BUILDDIR=trunk_lede

function check {
  PWD=$(pwd)
  if [ -d $PWD/$currentver ]; then
  rm -rf $currentver
  fi
}

function update {
  cd build_dir/$BUILDDIR
  make clean
  rm -rf files
  git pull
  ./scripts/feeds update -a
  ./scripts/feeds install -a
  cd ../../tmp
  case "$BUILDDIR" in
    trunk_lede) currentver=PulshenWRT_LEDE
    check
    git clone https://github.com/Sudokamikaze/PulshenWRT_LEDE
    ;;
    trunk_wrt) currentver=PulshenWRT_trunk
    check
    git clone https://github.com/Sudokamikaze/PulshenWRT_trunk
    ;;
    cc_wrt) currentver=PulshenWRT_CC
    check
    git clone https://github.com/Sudokamikaze/PulshenWRT_CC
    ;;
esac
  cd $currentver
  rm -rf ../../build_dir/$BUILDDIR/files
  cp -r files/ ../../build_dir/$BUILDDIR
  echo Done!
}

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
  rm out/*
  cd build_dir/$BUILDDIR
  make clean
  echo Done!
  exit
  ;;
  3) echo "Starting update script section..."
  update
  exit
  ;;
  *) echo "Error, unknow symbol, exiting..."
  exit 1
  ;;
esac
cd build_dir/$BUILDDIR
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
cd ../../
mv build_dir/$BUILDDIR/bin/targets/ar71xx/generic/*.bin out/
