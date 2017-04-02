#!/bin/bash

# If u wan't to build *** define:
# trunk_lede for LEDE
# cc_wrt for Openwrt Chaos Calmer
# trunk_wrt for Openwrt TRUNK
BUILDDIR=trunk_lede

# DO NOT TOUCH THIS VARIABLES!
BUILDED_TARGET="build_dir/$BUILDDIR/bin/targets/ar71xx/generic/"
IMAGE="$HOME/Git/PulshenWRT/$BUILDED_TARGET/lede-ar71xx-generic-tl-wr841-v8-squashfs-sysupgrade.bin"


function config_def {
case "$BUILDDIR" in
  trunk_lede) config=lede_trunk
  ;;
  cc_wrt) config=cc
  ;;
  trunk) config=trunk
  ;;
esac
}

function update {
  cd build_dir/$BUILDDIR
  make clean
  rm -rf files
  git pull
  ./scripts/feeds update -a
  ./scripts/feeds install -a
  rm .config*
  config_def
  cp ../../configs_default/config_$config ./.config
  rm -rf ../../tmp/*
  cd ../../tmp
  case "$BUILDDIR" in
    trunk_lede) currentver=PulshenWRT_LEDE
    ;;
    trunk_wrt) currentver=PulshenWRT_trunk
    ;;
    cc_wrt) currentver=PulshenWRT_CC
    ;;
esac
  git clone https://github.com/Sudokamikaze/$currentver
  cd $currentver
  cp -r files/ ../../build_dir/$BUILDDIR
  cd ../../build_dir/$BUILDDIR && patch < ../../tmp/$currentver/$currentver.diff
  echo Done!
}

function build {
BUILD_START=$(date +"%s")

case "$pwrt" in
  2|t|T) make tools/install ${MAKEFLAGS="-j$(nproc)"} V=-1 && make toolchain/install ${MAKEFLAGS="-j$(nproc)"} V=-1
  ;;
  1|f|F) make ${MAKEFLAGS="-j$(nproc)"} V=-1
  ;;
esac

if [ -a $IMAGE ];
then

BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo "Firmware Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
cd ../../
cp $BUILDED_TARGET/*.bin out/
else
echo "Compilation failed! Fix the errors!"
fi
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
  cd build_dir/$BUILDDIR
  echo -n "Do you want to build firmware or only build toolchain? [F/T]: "
  read pwrt
  build
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
