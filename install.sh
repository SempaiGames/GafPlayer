#!/bin/bash
dir=`dirname "$0"`
cd "$dir"
haxelib remove gafplayer
haxelib local gafplayer.zip
