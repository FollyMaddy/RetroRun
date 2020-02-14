# RetroRun

Open RetroPie roms in standard pcmanfm filemanager with 1 click !

Program : RetroRun.sh

Version : 1.5

#

Use : 

RetroRun is a simple program created to run allmost all ROMS of RetroPie from your windows desktop enviroment (X) with pcmanfm filemanager.

If a resolution is added to the script, then roms will run in an alternative resolution.

If you quit the rom, the computer turns back in the original resolution.

#

Files:

# RetroRun.sh

The actual program, after installation, a desktop file is linked to this program.

# RetroRun_onstart.sh

Addon-script for displaying an image while loading and exiting a rom.

Uses the program feh.

The feh line is commented in the script, so it's -> OFF <- by default !!!

So if you want to use this addon-script, install feh with :

sudo apt-get install feh

and :

uncomment your desired feh line in RetroRun_onstart.sh.

# install.sh

Creates a directory in RetroPie, makes an application (.desktop file) and associates filetypes with RetroRun.

# install_800x600.sh

Runs install.sh with 800x600 option, so RetroRun will run in low resolution after installation.

Created so you don't have to do this command, manually, in the terminal.

# uninstall.sh

Removes the RetroRun directory in RetroPie,  the application (.desktop file) and associated filetypes with RetroRun.

# use-vesa.conf

(for use on X86 computers)

If the resolution 800x600 is not possible with RetroRun :

Try another monitor and/or paste and use the file /usr/share/xorg.conf.d/use-vesa.conf .

A reboot is necessary to turn the computer into VESA mode, if file is used.

Remove the file if you want to turn back to the normal state.

#

Dependencies : 

RetroRun only works if RetroPie is installed on your computer.

RetroRun uses pcmanfm filemanager !!!

#

How to run :

Make the install.sh / uninstall.sh executable, dubbleclick and choose open in terminal.

Or run it from the terminal with : ./install.sh  or if you want to uninstall : ./uninstall.sh

If you want to start RetroRun in a different resolution,

run the installer from the terminal with, for example : ./install.sh 800x600

You can check your available resolutions with : xrandr

The resolution option is mainly created for old x86 pc's with old gfx-card.

(Actually, it also should work on the Raspberry-pi 4)

Old gfx cards don't run roms very well and are slow in high resolutions. 

With this option you bypass this problem !

- It get's the standard resolution;

- When running the emulator it changes to, for example: 800x600;

- It changes back to the standard resolution if you stop the emulator.

#

Additional tips :

The program uses the retropie directory rom directory structure, 

but the directory can also be X/roms/'system'/(X/)X.X (X=can be anything)

The above is handy for running roms directly from external media !!!

Seems like all files can be associated with RetroRun, including zip and cue.

Make sure rom files are not set as executable, otherwise some files will be detected as a script (like .cue) and then do not work!!

#

Issue with RetroRun => opening with other programs :

On raspbian,  zip or some octet files will not open with other programs anymore if using RetroRun.

So if you want them to open with another program than RetroRun use option : open with !!!

(tip : troublesome associations can be manually removed in the mimelist)

On lubuntu,  zip or some octet files will open with the first associated programs.

These additional associations are in /usr/share/applications/mimeinfo.cache and overrule associations in ~/.config/mimeapps.list

So if you want them to open with RetroRun use option : open with !!!
