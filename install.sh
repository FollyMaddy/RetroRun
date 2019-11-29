#!/bin/bash

# Program : install.sh (installer for RetroRun)
# Version : 1.4

# Use : 
# This installer creates a directory in RetroPie, 
# makes an application and associates filetypes with RetroRun.
# If a resolution is added to the script, then roms will run in an alternative resolution
# If you quit the rom, the computer turns back in the original resolution

# Dependencies : 
# RetroRun will only work if RetroPie is installed on your computer.
# RetroRun also uses pcmanfm filemanager !!!

# How to run :
# Do not run as root !
# Make the program executable, dubbleclick and choose open in terminal.
# Or run it from the terminal with : ./install.sh
# -------------------
# If run in terminal, you can add a resolution to the install.sh
# If you want to start RetroRun in a different resolution then  run the installer from the terminal with, for example : ./install.sh 800x600
# You can check your available resolutions with : xrandr

# Additional tips for RetroRun:
# The program uses the retropie directory rom directory structure, 
# but the directory can also be (*=can be anything) --- >  */roms/'systemname'/('one or more subdirectory's'/)*.* 
# Seems like all files can be associated with RetroRun, including zip and cue
# Make sure rom files are not set as executable, otherwise some files will be detected as a script (like .cue) and then do not work!!

# Issue with RetroRun => opening with other programs :
# On raspbian,  zip or or some octet files will not open with other programs anymore if using RetroRun
# So if you want them to open with another program than RetroRun use option : open with !!!
#
# On lubuntu,  zip or or some octet files will open with the first associated programs
# These additional associations are in /usr/share/applications/mimeinfo.cache and overrule associations in ~/.config/mimeapps.list
# So if you want them to open with RetroRun use option : open with !!!

#
# Author : Folkert van der Meulen
# Date   : 29/11/2019
#
# Copyright 2019 Folkert van der Meulen
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#--------------------------------------

#add desired resolution to the installation process, so run it, for example, like --> ./install.sh 800x600
#run 'xrandr' to see the possible resolutions
#on old computers the recommeded resolution is 800x600
#on new computers it is not recommeded to use this option  
desiredresolution=$1

#copy script and make it executable
mkdir ~/RetroPie/RetroRun
cp RetroRun.sh ~/RetroPie/RetroRun/RetroRun.sh
chmod +x ~/RetroPie/RetroRun/RetroRun.sh

#generate desktopfile in the user applications directory ( code idea is from emulationstation.sh in retropie setup )
desktopfile=~/.local/share/applications/RetroRun.desktop
homedir=$(echo $HOME)
#remove desktopfile if exists
rm $desktopfile
touch $desktopfile
cat > $desktopfile << _EOF_
[Desktop Entry]
Encoding=UTF-8
Name=RetroRun
Comment=Retro Game Runner
Type=Application
Exec=$homedir/RetroPie/RetroRun/RetroRun.sh $desiredresolution %f
Icon=/opt/retropie/supplementary/emulationstation/scripts/retropie.svg
Terminal=true
X-KeepTerminal=true
Categories=Emulator;Game
_EOF_

#if ~/.config/mimeapps.list does not jet exist, then associations will not be added !
#add associations, if no associations for RetroRun exists in mimeapps.list
mimeappsfile=~/.config/mimeapps.list
checkforinstall=$(cat $mimeappsfile)
if [[ -n "${checkforinstall##*RetroRun*}" ]]; then
sed -i '/\[Added.Associations\]/ {s/\[Added.Associations\]/&\
application\/zip=RetroRun\.desktop\;\
application\/octet\-stream\=RetroRun\.desktop\;\
application\/x\-atari\-7800\-rom\=RetroRun\.desktop\;\
application\/x\-atari\-lynx\-rom\=RetroRun\.desktop\;\
application\/x\-nes\-rom\=RetroRun\.desktop\;\
application\/x\-pc\-engine\-rom\=RetroRun\.desktop\;\
application\/x\-raw\-disk\-image\=RetroRun\.desktop\;\
application\/x\-genesis\-32x\-rom\=RetroRun\.desktop\;\
application\/x\-cue\=RetroRun\.desktop\;\
application\/x\-gameboy\-rom\=RetroRun\.desktop\;\
application\/x\-gba\-rom\=RetroRun\.desktop\;\
application\/x\-gameboy\-color\-rom\=RetroRun\.desktop\;\
application\/x\-sms\-rom\=RetroRun\.desktop\;\
application\/x\-sg1000\-rom\=RetroRun\.desktop\;\
application\/vnd\.nintendo\.snes\.rom\=RetroRun\.desktop\;\
application\/vnd\.stardivision\.mail\=RetroRun\.desktop\;\
model\/x\.stl\-binary\=RetroRun\.desktop\;/g}' \
$mimeappsfile
fi

