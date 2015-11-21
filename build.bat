@echo off
SET dir=%~dp0
cd %dir%
if exist gafplayer.zip del /F gafplayer.zip
winrar a -afzip gafplayer.zip haxelib.json com
pause