#!/bin/bash

# Program : uninstall.sh (uninstaller for RetroRun)
# Version : 1.3

# Use : 
# This uninstaller removes the RetroRun directory in RetroPie, 
# the application and associates filetypes with RetroRun.

# How to run :
# Make the program executable, dubbleclick and choose open in terminal.
# Or run it from the terminal with : ./uninstall.sh
# Do not run as root !
# (1 line uses sudo for removing the application file)

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


#remove RetroRun file associations
sed -i ':a;N;$!ba;s/application.*RetroRun.desktop\;\n//g' \
~/.config/mimeapps.list

#remove RetroRun.desktop
retrorundesktopfile=/usr/share/applications/RetroRun.desktop
sudo rm $retrorundesktopfile

#force remove RetroRun directory
retrorundir=~/RetroPie/RetroRun
rm -fr $retrorundir