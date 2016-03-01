#!/bin/bash
cd build_dir
VAR=$(ls | grep _wrt)
cd $VAR
echo ===========================
echo 1 Build toolchain & tools
echo 2 Build firmware
echo ===========================
echo In the main build dir contains there versions :
echo $VAR
echo ============================
echo -n "Choose an action: "
read item
case "$item" in
  1) echo "Starting compilation..."
  make tools/install ${MAKEFLAGS="-j$(nproc)"} V=-1 && make toolchain/install ${MAKEFLAGS="-j$(nproc)"} V=-1
  ;;
  2) echo "Starting compilation..."
  make ${MAKEFLAGS="-j$(nproc)"} V=-1
  ;;
  *) echo "Waiting for input"
  ;;
esac
