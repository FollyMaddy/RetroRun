#!/bin/bash

# Program : RetroRun.sh
# Version : 1.4

# Use : 
# RetroRun is a simple program created to run allmost all ROMS of RetroPie from your windows desktop enviroment (X) with pcmanfm filemanager
# If a resolution is added to the script, then roms will run in an alternative resolution
# If you quit the rom, the computer turns back in the original resolution

# Dependencies : 
# RetroRun only works if RetroPie is installed on your computer.
# RetroRun uses pcmanfm filemanager !!!

# How to run :
# An install script and an uninstall script is added
# Discription of what these scripts do are in the scripts themselves.
# Make the install or uninstall script executable, dubbleclick and choose open in terminal.
# Or run it from the terminal with : ./install.sh
# If you want to start RetroRun in a different resolution then  run the installer from the terminal with, for example : ./install.sh 800x600
# You can check your available resolutions with : xrandr
# for uninstall use the file uninstall.sh

# Additional tips :
# The program uses the retropie directory rom directory structure, 
# but the directory can also be (*=can be anything) --- >  */roms/'systemname'/('one or more subdirectory's'/)*.* 
# Seems like all files can be associated with RetroRun, including zip and cue
# Make sure rom files are not set as executable, otherwise some files will be detected as a script (like .cue) and then do not work!!

# Issue with RetroRun => opening with other programs :
# On raspbian,  zip or some octet files will not open with other programs anymore if using RetroRun
# So if you want them to open with another program than RetroRun use option : open with !!!
# (tip : troublesome associations can be manually removed in the mimelist)
#
# On lubuntu,  zip or some octet files will open with the first associated programs
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


#improvement due to Retropie Shell Style Guide
#in if "[" converted into "[["
#long commands with "|" splitted with "\"

#load file with bash script
option=$1
##if option contains a resolution then execute the commands or else run the filebrowser
if [[ -z "${option##640x480}" ]] || [[ -z "${option##800x600}" ]]; then
    low_resolution=$option
    echo $low_resolution
    #read the second option
    option=$2
    if [[ -z "${option}" ]]; then
        pcmanfm ~/RetroPie/roms
    else
    xrandroutput=$(xrandr | tr -d "\n")
    IFS=':,' read -ra xrandrsplit <<< "$xrandroutput"
    for xrandrpart in "${xrandrsplit[@]}"; do
        echo $xrandrpart
        xrandrpart=$(echo $xrandrpart | sed 's/ x /x/g')
        if [[ -z "${xrandrpart##current*}" ]]; then
            #search for current resolution and make an xrandr command to restore to current resolution
            IFS=' ' read -ra resolution <<< "$xrandrpart"
            #strange but this command works only with echo in front of xrandr, perhaps because of array value
            change_standard_resolution_cmd=$(echo xrandr -s "${resolution[1]}")
        #newline removed with (tr -d "\n") in line 17, then the whole output of xrandr can be checked for compatible resolutions
        elif [[ -z "${xrandrpart##*$low_resolution*}" ]]; then
            #low_resolution is possible command can be made and inserted
            change_low_resolution_cmd=$(xrandr -s "$low_resolution | ")
        fi
    done 
    fi 
fi  
#if option contains a file then execute the commands or else run the filebrowser
if [[ -n "$option" ]]; then
    IFS='/' read -ra pathsplit <<< "$option"
    counter=0
    for part in "${pathsplit[@]}"; do
        if [[ -z "${part##roms}" ]]; then
        #echo $part
        systemlocation=$((counter + 1))
        fi
        counter=$((counter + 1))
    done   
    #echo $romsdirlocation
    #echo $systemlocation
    #nog oplossen : cmd werkt in raspbian niet meer vanuit de terminal, bij lubuntu wel?
    $change_low_resolution_cmd \
    /opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ ${pathsplit[systemlocation]} "${option}"
    $change_standard_resolution_cmd
fi
