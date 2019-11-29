# RetroRun

Open RetroPie roms in standard pcmanfm filemanager with 1 click !

Program : RetroRun.sh

Version : 1.4


Use : 

RetroRun is a simple program created to run allmost all ROMS of RetroPie from your windows desktop enviroment (X) with pcmanfm filemanager

If a resolution is added to the script, then roms will run in an alternative resolution

If you quit the rom, the computer turns back in the original resolution


Dependencies : 

RetroRun only works if RetroPie is installed on your computer.

RetroRun uses pcmanfm filemanager !!!


How to run :

An install script and an uninstall script is added

Discription of what these scripts do are in the scripts themselves.

Make the program executable, dubbleclick and choose open in terminal.

Or run it from the terminal with : ./install.sh

If you want to start RetroRun in a different resolution then  run the installer from the terminal with, for example : ./install.sh 800x600

You can check your available resolutions with : xrandr

for uninstall use the file uninstall.sh


Additional tips :

The program uses the retropie directory rom directory structure, 

but the directory can also be */roms/'system'/(*/)*.* (*=can be anything)

Seems like all files can be associated with RetroRun, including zip and cue

Make sure rom files are not set as executable, otherwise some files will be detected as a script (like .cue) and then do not work!!


Issue with RetroRun => opening with other programs :

On raspbian,  zip or or some octet files will not open with other programs anymore if using RetroRun

So if you want them to open with another program than RetroRun use option : open with !!!

(tip : troublesome associations can be manually removed in the mimelist)

On lubuntu,  zip or some octet files will open with the first associated programs

These additional associations are in /usr/share/applications/mimeinfo.cache and overrule associations in ~/.config/mimeapps.list

So if you want them to open with RetroRun use option : open with !!!
