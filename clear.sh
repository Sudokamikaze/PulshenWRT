#!/bin/bash
VAR=$(ls | grep _wrt)
echo Removing there dirs : $VAR
rm -rf $VAR
echo Cleaning tmp dir
rm -rf tmp/
