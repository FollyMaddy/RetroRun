#!/bin/bash

# Program : rpie-low-res.sh
# Version : 1.5
#
# Author : Folkert van der Meulen
# Date   : 25/05/2020
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

#improvement due to Retropie Shell Style Guide
#in if "[" converted into "[["
#long commands with "|" splitted with "\"

#load file with bash script
option=$1
##if option contains a resolution then execute the commands
if [[ -z "${option##640x480}" ]] || [[ -z "${option##800x600}" ]] || [[ -z "${option##720x400}" ]]; then
    low_resolution=$option
    echo $low_resolution
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
#if option contains a file then execute the commands or else run the filebrowser

#nog oplossen : cmd werkt in raspbian niet meer vanuit de terminal, bij lubuntu wel?
$change_low_resolution_cmd \
emulationstation
$change_standard_resolution_cmd
