#!/bin/bash
mkdir tmp
mkdir build_dir
echo Installing libs
./bin/prepare_utils.sh
echo Downloading sources
./bin/prepare_sources.sh
echo Downloading PulshenWRT modification
./bin/pwrt_setup.sh
echo Done
