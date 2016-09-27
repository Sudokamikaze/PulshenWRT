#!/bin/bash

# If u wan't to build *** define:
# trunk_lede for LEDE
# cc_wrt for Openwrt Chaos Calmer
# trunk_wrt for Openwrt TRUNK
BUILDDIR=trunk_lede

function update {
  cd build_dir/$BUILDDIR
  rm -rf files
  git pull
  ./scripts/feeds update -a
  ./scripts/feeds install -a
  cd ../../tmp
  if [ $BUILDDIR == trunk_lede ]; then
  git clone https://github.com/Sudokamikaze/PulshenWRT_LEDE
  currentver=PulshenWRT_LEDE
elif [ $BUILDDIR == trunk_wrt ]; then
  git clone https://github.com/Sudokamikaze/PulshenWRT_trunk
  currentver=PulshenWRT_trunk
elif [ $BUILDDIR == cc_wrt ]; then
  git clone https://github.com/Sudokamikaze/PulshenWRT_CC
  currentver=PulshenWRT_CC
fi
  cd $currentver
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
