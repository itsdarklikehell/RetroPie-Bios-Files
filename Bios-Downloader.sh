#!/bin/bash
#echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
#echo "RetroPie/RetroArch/EmulationStation Bios files downloader"
#echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
CONFIGURE(){
WORKDIR=~/RetroPie-Bios-Files/BIOS
BIOSDIR=~/RetroPie/BIOS
cp $BIOSDIR $WORKDIR
}
MAKE_WORKDIR(){
mkdir -p $WORKDIR/$SETNAME
}
COPY_BIOSDIR(){
cp $WORKDIR $BIOSDIR
}
DOWNLOADZIP(){
wget $SETLINK -O $WORKDIR/$SETNAME/$SETNAME.zip
}
EXTRACTZIP(){
unzip $WORKDIR/$SETNAME/$SETNAME.zip $WORKDIR/$SETNAME
}

SYSTEM_SELECT(){
ATARI_LYNX(){
echo "Atari Lynx"
SETLINK="https://download.loveroms.com/extras/files/bios/Atari%20Lynx%20Bios(USA,Europe).zip"
SETNAME="lynx"
MAKE_WORKDIR
DOWNLOADZIP
EXTRACTZIP

}

DREAMCAST(){
echo "Dreamcast"
echo "Note: Every dreamcast emulator is slightly different and requires a different BIOS file (so annoying). I've included all of them in one zip, you may need to tinker around to get it to work. I setup folders to help you out. These files will work for Chankast, Reicast, DEMUL and many others. Even so, try to find general getting started guides because it can be frustrating getting these to work."
SETLINK="https://download.loveroms.com/extras/files/bios/dreamcast-bios.zip"
#for reicast (android) use: https://download.loveroms.com/extras/files/bios/dreamcast_bios.zip
SETNAME="dreamcast"
}

GAMEBOY_ADVANCE(){
echo "Gameboy Advance"
SETLINK="https://download.loveroms.com/extras/files/bios/gba_bios.zip"
SETNAME="gba"
}

GAMEBOY_COLOR(){
echo "Gameboy Color"
SETLINK="https://m.loveroms.com/extras/files/bios/GameboyColorBios.zip "
SETNAME="gbc"
}

MAME(){
echo "MAME"
SETLINK="https://download.loveroms.com/extras/files/bios/MAME%20-%20Bios%20Pack.zip"
SETNAME="mame"
}

NEOGEO(){
echo "Neo Geo"
SETLINK="https://m.loveroms.com/extras/files/bios/neogeo.zip"
SETNAME="neogeo"
}

NINTENDO_DS(){
echo "Nintendo DS"
SETLINK="https://download.loveroms.com/extras/files/bios/nds_bios.zip"
SETNAME="nds"
}

PLAYSTATION(){
echo "Playstation"

USA(){
SETLINK="http://download.loveroms.com/extras/files/bios/SCPH1001.zip"
SETNAME="usa"
}
JAPAN(){
SETLINK="http://download.loveroms.com/extras/files/bios/Scph1000.zip"
SETNAME"japan"
}
EUROPE(){
SETLINK"http://download.loveroms.com/extras/files/bios/SCPH7003.zip"
SETNAME"europe"
}
USA
JAPAN
EUROPE
}

SEGA_GAMEGEAR(){
echo "Sega Game Gear"
SETLINK="https://m.loveroms.com/extras/files/bios/SegaGameGearBios.zip"
SETNAME="gamegear"
}

SEGA_GENESIS(){
echo "Sega Genesis"
SETLINK="https://m.loveroms.com/extras/files/bios/SegaGenesisBios.zip"
SETNAME="genesis"
}
ATARI_LYNX
#DREAMCAST
#GAMEBOY_ADVANCE
#GAMEBOY_COLOR
#MAME
#NEOGEO
#NINTENDO_DS
#PLAYSTATION
#SEGA_GAMEGEAR
#SEGA_GENESIS
}
######## EXECUTION ########
CONFIGURE
SYSTEM_SELECT