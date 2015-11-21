@echo off
SET dir=%~dp0
cd %dir%
haxelib remove gafplayer
haxelib local gafplayer.zip
