#!/bin/bash
dir=`dirname "$0"`
cd "$dir"
rm -f gafplayer.zip
zip -0r gafplayer.zip haxelib.json com
