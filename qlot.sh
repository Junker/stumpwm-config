#!/bin/bash

CACHE_DIR=~/.cache/stumpwm
mkdir -p $CACHE_DIR
cd $CACHE_DIR
echo $CACHE_DIR
ln -s ~/.config/stumpwm/qlfile ~/.cache/stumpwm/qlfile
~/.roswell/bin/qlot $*
