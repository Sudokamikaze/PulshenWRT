#!/bin/bash
mkdir tmp
echo Installing libs
./bin/prepare_utils.sh
echo Downloading sources
./bin/prepare_sources.sh
echo Downloading PulshenWRT modification
./pwrt_setup.sh
echo Done
