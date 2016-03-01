#!/bin/bash
cd build_dir
VAR=$(ls | grep _wrt)
echo Removing there dirs : $VAR
rm -rf $VAR
echo Cleaning tmp dir
rm -rf ../tmp/
