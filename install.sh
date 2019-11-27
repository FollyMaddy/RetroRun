#!/bin/bash

# Program : install.sh (installer for RetroRun)
# Version : 1.3

# Use : 
# This installer creates a directory in RetroPie, 
# makes an application and associates filetypes with RetroRun.

# Dependencies : 
# RetroRun will only work if RetroPie is installed on your computer.
# RetroRun also uses pcmanfm filemanager !!!

# How to run :
# Make the program executable, dubbleclick and choose open in terminal.
# Or run it from the terminal with : ./install.sh
# Do not run as root !
# (1 line uses sudo for moving the application file)

# Additional tips for RetroRun:
# The program uses the retropie directory rom directory structure, 
# but the directory can also be */roms/'system'/(*/)*.* (*=can be anything)
# Seems like all files can be associated with RetroRun, including zip and cue
# Make sure rom files are not set as executable, otherwise some files will be detected as a script (like .cue) and then do not work!!

# Issue with RetroRun => opening with other programs :
# If zip or txt(octet) files are associated with RetroRun they will not open with other programs anymore !
# So if you want them to open with another program use option : open with !!!

#
# Author : Folkert van der Meulen
# Date   : 26/11/2019
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

#copy script and make it executable
mkdir ~/RetroPie/RetroRun
cp RetroRun.sh ~/RetroPie/RetroRun/RetroRun.sh
chmod +x ~/RetroPie/RetroRun/RetroRun.sh

#generate desktopfile, code idea from emulationstation.sh in retropie setup
desktopfileindirectory=~/RetroPie/RetroRun/RetroRun.desktop
desktopfile=/usr/share/applications/RetroRun.desktop
homedir=$(echo $HOME)
#check for desktopfile
checkfordesktopfile=$(ls $desktopfile)
if [[ -z "${checkfordesktopfile##RetroRun*}" ]]; then
touch $desktopfileindirectory
cat > $desktopfileindirectory << _EOF_
[Desktop Entry]
Encoding=UTF-8
Name=RetroRun
Comment=Retro Game Runner
Type=Application
Exec=$homedir/RetroPie/RetroRun/RetroRun.sh %f
Icon=/opt/retropie/supplementary/emulationstation/scripts/retropie.svg
Terminal=true
X-KeepTerminal=true
Categories=Emulator;Game
_EOF_
fi
#move generated desktopfile from ~/RetroPie/RetroRun/ to /usr/share/applications/
sudo mv $desktopfileindirectory $desktopfile

#if ~/.config/mimeapps.list does not jet exist, then associations will not be added !
#add associations, if no associations for RetroRun exists in mimeapps.list
mimeappsfile=~/.config/mimeapps.list
checkforinstall=$(cat $mimeappsfile)
if [[ -n "${checkforinstall##*RetroRun*}" ]]; then
sed -i '/\[Added.Associations\]/ {s/\[Added.Associations\]/&\
application\/zip=RetroRun\.desktop\;\
application\/octet\-stream\=RetroRun\.desktop\;\
application\/x\-atari\-7800\-rom\=RetroRun\.desktop\;\
application\/x\-nes\-rom\=RetroRun\.desktop\;\
application\/x\-pc\-engine\-rom\=RetroRun\.desktop\;\
application\/x\-raw\-disk\-image\=RetroRun\.desktop\;\
application\/x\-genesis\-32x\-rom\=RetroRun\.desktop\;\
application\/x\-cue\=RetroRun\.desktop\;\
application\/x\-gameboy\-rom\=RetroRun\.desktop\;/g}' \
$mimeappsfile
fi

