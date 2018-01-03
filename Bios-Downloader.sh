#!/bin/bash
echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
echo "RetroPie/RetroArch/EmulationStation Bios files downloader"
echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
CONFIGURE(){
WORKDIR=~/RetroPie-Bios-Files/BIOS
BIOSDIR=~/RetroPie/BIOS
}
MAKE_WORKDIR(){
cp $BIOSDIR $WORKDIR
}
COPY_BIOSDIR(){
cp $WORKDIR $BIOSDIR
}
DOWNLOAD(){
ATARI_LYNX(){
echo "Atari Lynx"
SETNAME=""
SETLINK="https://download.loveroms.com/extras/files/bios/Atari%20Lynx%20Bios(USA,Europe).zip"
}

DREAMCAST(){
echo "Dreamcast"
echo "Note: Every dreamcast emulator is slightly different and requires a different BIOS file (so annoying). I've included all of them in one zip, you may need to tinker around to get it to work. I setup folders to help you out. These files will work for Chankast, Reicast, DEMUL and many others. Even so, try to find general getting started guides because it can be frustrating getting these to work."
SETNAME=""
SETLINK="https://download.loveroms.com/extras/files/bios/dreamcast-bios.zip"
#for reicast (android) use: https://download.loveroms.com/extras/files/bios/dreamcast_bios.zip
}

GAMEBOY_ADVANCE(){
echo "Gameboy Advance"
SETLINK="https://download.loveroms.com/extras/files/bios/gba_bios.zip"
SETNAME=""
}

echo "Gameboy Color"
SETLINK=""
SETNAME=""

echo "MAME"
SETLINK=""
SETNAME=""


echo "Neo Geo"
SETLINK=""
SETNAME=""


echo "Nintendo DS"
SETLINK=""
SETNAME=""

echo "Playstation"
SETLINK=""
SETNAME=""

echo "Sega Game Gear"
SETLINK=""
SETNAME=""

echo "Sega Genesis"
SETLINK=""
SETNAME=""


}
######## EXECUTION ########
CONFIGURE
