#!/bin/bash

# Program : install.sh (installer for RetroRun)
# Version : 1.5
#
# Author : Folkert van der Meulen
# Date   : 27/01/2020
#
# Copyright 2020 Folkert van der Meulen
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

desiredresolution=$1

#copy script and make it executable
mkdir ~/RetroPie/RetroRun
cp RetroRun.sh ~/RetroPie/RetroRun/RetroRun.sh
chmod +x ~/RetroPie/RetroRun/RetroRun.sh
cp RetroRun_onstart.sh ~/RetroPie/RetroRun/RetroRun_onstart.sh
chmod +x ~/RetroPie/RetroRun/RetroRun_onstart.sh

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

