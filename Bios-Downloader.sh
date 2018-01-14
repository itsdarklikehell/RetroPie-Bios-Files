#!/bin/bash
#echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
#echo "RetroPie/RetroArch/EmulationStation Bios files downloader"
#echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
CONFIGURE(){
echo "configuring working directories and copying bios files allready present in ~/RetroPie/BIOS directory to working directory"
WORKDIR=~/RetroPie-Bios-Files/BIOS
BIOSDIR=~/RetroPie/BIOS
cp -R $BIOSDIR/*.* $WORKDIR
MAKE_WORKDIR(){
echo "making $WORKDIR/$SYSNAME/"
mkdir -p $WORKDIR/$SYSNAME/
}
DOWNLOAD_ZIP(){
echo "downloading $BIOSNAME"
echo "from $LINK"
echo "to $WORKDIR/$SYSNAME"
echo "as $SYSNAME.$EXT"
wget -c $LINK -O $WORKDIR/$SYSNAME/$SYSNAME.$EXT
}
DOWNLOAD_FILE(){
echo "downloading $BIOSNAME"
echo "from $LINK"
echo "to $WORKDIR"
echo "as $BIOSNAME"
wget -c $LINK -O $WORKDIR/$BIOSNAME
}

CHECK_SUM(){
if [[ $SYSNAME  = Atari-7800 ]]
then
	md5sum $WORKDIR/"7800 BIOS (U).rom" | awk '{ print $1 }'
else
	md5sum $WORKDIR/$BIOSNAME | awk '{ print $1 }'
fi
if [[ $1 = $CHECKSUM ]] ## checking if $1 is $CHECKSUM.
then ## if not then download, extract, copy to workdir and check for validity.
    echo " !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! "
    echo "The checksum of $BIOSNAME is NOT VALID, it is not the same as $CHECKSUM !"
    echo " !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! "
else ## if flie exists then verify if checksum checks out.
	echo "The checksum of $BIOSNAME is valid."
    COPY_BIOSNAME_BIOSDIR
fi
}
EXTRACTZIP(){
echo "extracting $WORKDIR/$SYSNAME/$SYSNAME.$EXT"
unzip $WORKDIR/$SYSNAME/$SYSNAME.$EXT -d $WORKDIR/$SYSNAME
#rm $WORKDIR/$SYSNAME/$SYSNAME.$EXT
}
COPY_BIOSNAME_WORKDIR(){
echo "Copying $BIOSNAME to $WORKDIR"
cp $WORKDIR/$SYSNAME/*.* $WORKDIR
}
COPY_BIOSNAME_BIOSDIR(){
echo "Copying $BIOSNAME with verrified checksum $CHECKSUM to $BIOSDIR"
if [[ $SYSNAME  = Atari-7800 ]]
then 
	mv $WORKDIR/$SYSNAME/7800.ROM $WORKDIR/"7800 BIOS (U).rom"
else
	cp $WORKDIR/$BIOSNAME $BIOSDIR
fi
}
}

SYSTEM_DOWNLOAD(){

EXAMPLE_SYSTEM(){
echo "Example-System"
SYSNAME="Example-System" ##	Systemname for wich a workingdir is created. 
LINK="http//example.link"	## The link to download a file from.
EXT="zip"	## The extention of the downloaded file.
BIOSNAME="examplebios.rom" ## The name of the file needed by emulators.
CHECKSUM="somechecksumnumber" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    EXTRACTZIP ## Extract downoaded .zip file
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi
}

SEGA32X(){
echo "Sega32x"
SYSNAME="Sega32x"
LINK="http://50.7.92.186/ukIpalnq13Lasfp75BBaa/epforums/upload/2/3/4/5/2/192311740647317996.zip"
EXT="zip"

BIOSNAME="32X_G_BIOS.BIN"
CHECKSUM="6a5433f6a132a2b683635819a6dcf085"
if [ -e $WORKDIR/$BIOSNAME ]
then
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM
else
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_ZIP
    EXTRACTZIP
    COPY_BIOSNAME_WORKDIR
    CHECK_SUM
fi

BIOSNAME="32X_M_BIOS.BIN"
CHECKSUM="f88354ec482be09aeccd76a97bb75868"
if [ -e $WORKDIR/$BIOSNAME ]
then
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM
else
    echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_ZIP
    EXTRACTZIP
    COPY_BIOSNAME_WORKDIR
    CHECK_SUM
fi

BIOSNAME="32X_S_BIOS.BIN"
CHECKSUM="7f041b6a55cd7423a6c08a219335269e"
if [ -e $WORKDIR/$BIOSNAME ]
then
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM
else
    echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_ZIP
    EXTRACTZIP
    COPY_BIOSNAME_WORKDIR
    CHECK_SUM
fi
}

ATARI8BIT(){
echo "Atari 8-bit Series"
SYSNAME="Atari-8-bit-Series" ##	Systemname for wich a workingdir is created. 
LINK="http://marc-abramowitz.com/download/atari/OSRoms/5200.ROM"	## The link to download a file from.
EXT=".rom"	## The extention of the downloaded file.

BIOSNAME="5200.rom" ## The name of the file needed by emulators.
CHECKSUM="281f20ea4320404ec820fb7ec0693b38" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if not then download, extract, copy to workdir and check for validity.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM
else ## if flie exists then verify if checksum checks out.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_FILE
    #EXTRACTZIP
    mv $WORKDIR/5200.ROM $WORKDIR/$BIOSNAME
    #COPY_BIOSNAME_WORKDIR
    CHECK_SUM
fi

LINK="http://marc-abramowitz.com/download/atari/OSRoms/ATARIBAS.ROM"
BIOSNAME="ATARIBAS.ROM" ## The name of the file needed by emulators.
CHECKSUM="0bac0c6a50104045d902df4503a4c30b" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM
else ## if flie exists then verify if checksum checks out.
    echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_FILE
    #EXTRACTZIP
    #COPY_BIOSNAME_WORKDIR
    CHECK_SUM

fi

LINK="http://marc-abramowitz.com/download/atari/OSRoms/ATARIOSA.ROM"
BIOSNAME="ATARIOSA.ROM" ## The name of the file needed by emulators.
CHECKSUM="eb1f32f5d9f382db1bbfb8d7f9cb343a" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if not then download, extract, copy to workdir and check for validity.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM
else ## if flie exists then verify if checksum checks out.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_FILE
    #EXTRACTZIP
    #COPY_BIOSNAME_WORKDIR
    CHECK_SUM
fi

LINK="http://marc-abramowitz.com/download/atari/OSRoms/ATARIOSB.ROM"
BIOSNAME="ATARIOSB.ROM" ## The name of the file needed by emulators.
CHECKSUM="a3e8d617c95d08031fe1b20d541434b2" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if not then download, extract, copy to workdir and check for validity.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM
else ## if flie exists then verify if checksum checks out.
    echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_FILE
    #EXTRACTZIP
    #COPY_BIOSNAME_WORKDIR
    CHECK_SUM
fi

LINK="http://marc-abramowitz.com/download/atari/OSRoms/ATARIXL.ROM"
BIOSNAME="ATARIXL.ROM" ## The name of the file needed by emulators.
CHECKSUM="06daac977823773a3eea3422fd26a703" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if not then download, extract, copy to workdir and check for validity.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM
else ## if flie exists then verify if checksum checks out.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_FILE
    #EXTRACTZIP
    #COPY_BIOSNAME_WORKDIR
    CHECK_SUM
fi
}

ATARI_7800(){
echo "Atari 7800"
SYSNAME="Atari-7800" ##	Systemname for wich a workingdir is created. 
LINK="http://www.romcollector.com/storage/emulators/mess/a7800.zip"	## The link to download a file from.
EXT="zip"	## The extention of the downloaded file.
BIOSNAME="7800 BIOS (U).rom" ## The name of the file needed by emulators.
CHECKSUM="0763f1ffb006ddbe32e52d497ee848ae" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    EXTRACTZIP ## Extract downoaded .zip file 
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi
}

MSX(){
echo "Msx"
SYSNAME="Msx" ##	Systemname for wich a workingdir is created. 

LINK="https://www.k3nny.fr/BIOS_Recalbox_v4.1.zip"	## The link to download a file from.
EXT="zip"	## The extention of the downloaded file.

BIOSNAME="CARTS.SHA" ## The name of the file needed by emulators.
CHECKSUM="d6dedca1112ddfda94cc9b2e426b818b" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    EXTRACTZIP ## Extract downoaded .zip file
    cp $WORKDIR/$SYSNAME/bios/$BIOSNAME $WORKDIR/$SYSNAME
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi

BIOSNAME="CYRILLIC.FNT" ## The name of the file needed by emulators.
CHECKSUM="85b38e4128bbc300e675f55b278683a8" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    EXTRACTZIP ## Extract downoaded .zip file
    cp $WORKDIR/$SYSNAME/bios/$BIOSNAME $WORKDIR/$SYSNAME
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi

BIOSNAME="DISK.ROM" ## The name of the file needed by emulators.
CHECKSUM="80dcd1ad1a4cf65d64b7ba10504e8190" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    EXTRACTZIP ## Extract downoaded .zip file
    cp $WORKDIR/$SYSNAME/bios/$BIOSNAME $WORKDIR/$SYSNAME
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi

BIOSNAME="FMPAC.ROM" ## The name of the file needed by emulators.
CHECKSUM="6f69cc8b5ed761b03afd78000dfb0e19" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    EXTRACTZIP ## Extract downoaded .zip file
    cp $WORKDIR/$SYSNAME/bios/$BIOSNAME $WORKDIR/$SYSNAME
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi

BIOSNAME="FMPAC16.ROM" ## The name of the file needed by emulators.
CHECKSUM="af8537262df8df267072f359399a7635" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    EXTRACTZIP ## Extract downoaded .zip file
    cp $WORKDIR/$SYSNAME/bios/$BIOSNAME $WORKDIR/$SYSNAME
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi

BIOSNAME="ITALIC.FNT" ## The name of the file needed by emulators.
CHECKSUM="c83e50e9f33b8dd893c414691822740d" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    EXTRACTZIP ## Extract downoaded .zip file
    cp $WORKDIR/$SYSNAME/bios/$BIOSNAME $WORKDIR/$SYSNAME
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi

BIOSNAME="KANJI.ROM" ## The name of the file needed by emulators.
CHECKSUM="febe8782b466d7c3b16de6d104826b34" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    EXTRACTZIP ## Extract downoaded .zip file
    cp $WORKDIR/$SYSNAME/bios/$BIOSNAME $WORKDIR/$SYSNAME
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi

BIOSNAME="MSX.ROM" ## The name of the file needed by emulators.
CHECKSUM="aa95aea2563cd5ec0a0919b44cc17d47" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    EXTRACTZIP ## Extract downoaded .zip file
    cp $WORKDIR/$SYSNAME/bios/$BIOSNAME $WORKDIR/$SYSNAME
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi

BIOSNAME="MSX2.ROM" ## The name of the file needed by emulators.
CHECKSUM="ec3a01c91f24fbddcbcab0ad301bc9ef" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    EXTRACTZIP ## Extract downoaded .zip file
    cp $WORKDIR/$SYSNAME/bios/$BIOSNAME $WORKDIR/$SYSNAME
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi

BIOSNAME="MSX2EXT.ROM" ## The name of the file needed by emulators.
CHECKSUM="2183c2aff17cf4297bdb496de78c2e8a" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    EXTRACTZIP ## Extract downoaded .zip file
    cp $WORKDIR/$SYSNAME/bios/$BIOSNAME $WORKDIR/$SYSNAME
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi

BIOSNAME="MSX2P.ROM" ## The name of the file needed by emulators.
CHECKSUM="6d8c0ca64e726c82a4b726e9b01cdf1e" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    EXTRACTZIP ## Extract downoaded .zip file
    cp $WORKDIR/$SYSNAME/bios/$BIOSNAME $WORKDIR/$SYSNAME
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi

BIOSNAME="MSX2PEXT.ROM" ## The name of the file needed by emulators.
CHECKSUM="7c8243c71d8f143b2531f01afa6a05dc" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    EXTRACTZIP ## Extract downoaded .zip file
    cp $WORKDIR/$SYSNAME/bios/$BIOSNAME $WORKDIR/$SYSNAME
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi

BIOSNAME="MSXDOS2.ROM" ## The name of the file needed by emulators.
CHECKSUM="6418d091cd6907bbcf940324339e43bb" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    EXTRACTZIP ## Extract downoaded .zip file
    cp $WORKDIR/$SYSNAME/bios/$BIOSNAME $WORKDIR/$SYSNAME
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi

BIOSNAME="PAINTER.ROM" ## The name of the file needed by emulators.
CHECKSUM="403cdea1cbd2bb24fae506941f8f655e" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    EXTRACTZIP ## Extract downoaded .zip file
    cp $WORKDIR/$SYSNAME/bios/$BIOSNAME $WORKDIR/$SYSNAME
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi

BIOSNAME="RS232.ROM" ## The name of the file needed by emulators.
CHECKSUM="279efd1eae0d358eecd4edc7d9adedf3" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    EXTRACTZIP ## Extract downoaded .zip file
    cp $WORKDIR/$SYSNAME/bios/$BIOSNAME $WORKDIR/$SYSNAME
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi
}

TI994A(){
echo "TI-99/4A"
SYSNAME="TI-994A" ##	Systemname for wich a workingdir is created. 
LINK="https://github.com/billzajac/ti99sim/blob/master/roms/TI-994A.dat"	## The link to download a file from.
EXT="zip"	## The extention of the downloaded file.
BIOSNAME="TI-994A.ctg" ## The name of the file needed by emulators.
CHECKSUM="412ecbf991edcb68edd0e76c2caa4a59" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_FILE
    #DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    #EXTRACTZIP ## Extract downoaded .zip file
    #cp $WORKDIR/$SYSNAME/TI-994A.dat $WORKDIR/$SYSNAME
    #COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi
}

TANDY_COLOR(){
echo "Tandy Color Computer"
SYSNAME="Tandy-Color-Computer" ##	Systemname for wich a workingdir is created. 
LINK="http://www.colorcomputerarchive.com/coco/ROMs/XRoar/CoCo/BASIC_OS/bas13.rom"	## The link to download a file from.
EXT="zip"	## The extention of the downloaded file.
BIOSNAME="bas13.rom" ## The name of the file needed by emulators.
CHECKSUM="c2fc43556eb6b7b25bdf5955bd9df825" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_FILE
    #DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    #EXTRACTZIP ## Extract downoaded .zip file
    #COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi
}

SEGA_CD(){
echo "Sega CD"
SYSNAME="Sega-CD" ##	Systemname for wich a workingdir is created. 
LINK="http://fantasyanime.com/files/emulators/SegaCD_BIOS.zip"	## The link to download a file from.
EXT="zip"	## The extention of the downloaded file.


BIOSNAME="bios_CD_E.bin" ## The name of the file needed by emulators.
CHECKSUM="e66fa1dc5820d254611fdcdba0662372" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    EXTRACTZIP ## Extract downoaded .zip file
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi

BIOSNAME="bios_CD_J.bin" ## The name of the file needed by emulators.
CHECKSUM="278a9397d192149e84e820ac621a8edd" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    EXTRACTZIP ## Extract downoaded .zip file
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi

BIOSNAME="bios_CD_U.bin" ## The name of the file needed by emulators.
CHECKSUM="2efd74e3232ff260e371b99f84024f7f" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    EXTRACTZIP ## Extract downoaded .zip file
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi
}

SEGA_CD2(){
echo "Sega-CD2"
SYSNAME="Sega-CD2" ##	Systemname for wich a workingdir is created. 
LINK="https://www.k3nny.fr/BIOS_Recalbox_v4.1.zip"	## The link to download a file from.
EXT="zip"	## The extention of the downloaded file.

BIOSNAME="eu_mcd2_9306.bin" ## The name of the file needed by emulators.
CHECKSUM="d8b8b720dea6c6ba25c309ed633930f4" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    EXTRACTZIP ## Extract downoaded .zip file
    cp $WORKDIR/$SYSNAME/bios/$BIOSNAME $WORKDIR/$SYSNAME
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi

BIOSNAME="us_scd2_9306.bin" ## The name of the file needed by emulators.
CHECKSUM="854b9150240a198070150e4566ae1290" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    EXTRACTZIP ## Extract downoaded .zip file
    cp $WORKDIR/$SYSNAME/bios/$BIOSNAME $WORKDIR/$SYSNAME
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi

BIOSNAME="jp_mcd1_9112.bin" ## The name of the file needed by emulators.
CHECKSUM="bdeb4c47da613946d422d97d98b21cda" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    EXTRACTZIP ## Extract downoaded .zip file
    cp $WORKDIR/$SYSNAME/bios/$BIOSNAME $WORKDIR/$SYSNAME
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi

}

COLECO(){
echo "Colecovision"
SYSNAME="Colecovision" ##	Systemname for wich a workingdir is created. 
LINK="https://www.k3nny.fr/BIOS_Recalbox_v4.1.zip"	## The link to download a file from.
EXT="zip"	## The extention of the downloaded file.

BIOSNAME="coleco.rom" ## The name of the file needed by emulators.
CHECKSUM="2c66f5911e5b42b8ebe113403548eee7" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    EXTRACTZIP ## Extract downoaded .zip file
    cp $WORKDIR/$SYSNAME/bios/$BIOSNAME $WORKDIR/$SYSNAME
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi
}

DREAMCAST(){
echo "Dreamcast"
SYSNAME="Dreamcast" ##	Systemname for wich a workingdir is created. 
LINK="https://www.k3nny.fr/BIOS_Recalbox_v4.1.zip"	## The link to download a file from.
EXT="zip"	## The extention of the downloaded file.

BIOSNAME="dc_boot.bin" ## The name of the file needed by emulators.
CHECKSUM="e10c53c2f8b90bab96ead2d368858623" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    EXTRACTZIP ## Extract downoaded .zip file
    cp $WORKDIR/$SYSNAME/bios/dc_bios.bin $WORKDIR/$SYSNAME/$BIOSNAME
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi

BIOSNAME="dc_flash.bin" ## The name of the file needed by emulators.
CHECKSUM="74e3f69c2bb92bc1fc5d9a53dcf6ffe2" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    EXTRACTZIP ## Extract downoaded .zip file
    cp $WORKDIR/$SYSNAME/bios/$BIOSNAME $WORKDIR/$SYSNAME
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi
}

NINTENDO_FCDS(){
echo "Nintendo Family Computer Disk System"
SYSNAME="Nintendo-fcds" ##	Systemname for wich a workingdir is created. 
LINK="https://www.k3nny.fr/BIOS_Recalbox_v4.1.zip"	## The link to download a file from.
EXT="zip"	## The extention of the downloaded file.

BIOSNAME="disksys.rom" ## The name of the file needed by emulators.
CHECKSUM="ca30b50f880eb660a320674ed365ef7a" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    EXTRACTZIP ## Extract downoaded .zip file
    cp $WORKDIR/$SYSNAME/bios/$BIOSNAME $WORKDIR/$SYSNAME
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi
}

GAMEBOY_ADVANCED(){
echo "Nintendo Gameboy Advance"
SYSNAME="Gameboy-Advance" ##	Systemname for wich a workingdir is created. 
LINK="https://www.k3nny.fr/BIOS_Recalbox_v4.1.zip"	## The link to download a file from.
EXT="zip"	## The extention of the downloaded file.

BIOSNAME="gba_bios.bin" ## The name of the file needed by emulators.
CHECKSUM="a860e8c0b6d573d191e4ec7db1b1e4f6" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    EXTRACTZIP ## Extract downoaded .zip file
    cp $WORKDIR/$SYSNAME/bios/$BIOSNAME $WORKDIR/$SYSNAME
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi
}

LYNX(){
echo "Atari-Lynx"
SYSNAME="Atari-Lynx" ##	Systemname for wich a workingdir is created. 
LINK="https://www.k3nny.fr/BIOS_Recalbox_v4.1.zip"	## The link to download a file from.
EXT="zip"	## The extention of the downloaded file.

BIOSNAME="lynxboot.img" ## The name of the file needed by emulators.
CHECKSUM="fcd403db69f54290b51035d82f835e7b" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    EXTRACTZIP ## Extract downoaded .zip file
    cp $WORKDIR/$SYSNAME/bios/$BIOSNAME $WORKDIR/$SYSNAME
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi
}

VIDEOPAC-ODYSSEY(){
echo "Videopac / Odyssey 2"
SYSNAME="Videopac-Odyssey-2" ##	Systemname for wich a workingdir is created. 
LINK="https://www.k3nny.fr/BIOS_Recalbox_v4.1.zip"	## The link to download a file from.
EXT="zip"	## The extention of the downloaded file.

BIOSNAME="o2rom.bin" ## The name of the file needed by emulators.
CHECKSUM="562d5ebf9e030a40d6fabfc2f33139fd" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    EXTRACTZIP ## Extract downoaded .zip file
    cp $WORKDIR/$SYSNAME/bios/$BIOSNAME $WORKDIR/$SYSNAME
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi
}

PC_ENGINE(){
echo "PC Engine / TurboGrafx 16"
SYSNAME="PC-Engine-TurboGrafx-16" ##	Systemname for wich a workingdir is created. 
LINK="https://www.k3nny.fr/BIOS_Recalbox_v4.1.zip"	## The link to download a file from.
EXT="zip"	## The extention of the downloaded file.

BIOSNAME="syscard3.pce" ## The name of the file needed by emulators.
CHECKSUM="ff1a674273fe3540ccef576376407d1d" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    EXTRACTZIP ## Extract downoaded .zip file
    cp $WORKDIR/$SYSNAME/bios/$BIOSNAME $WORKDIR/$SYSNAME
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi

}

PSX(){
echo "Sony Playstation"
SYSNAME="Sony-Playstation" ##	Systemname for wich a workingdir is created. 
LINK="https://www.k3nny.fr/BIOS_Recalbox_v4.1.zip"	## The link to download a file from.
EXT="zip"	## The extention of the downloaded file.

BIOSNAME="scph5500.bin" ## The name of the file needed by emulators.
CHECKSUM="8dd7d5296a650fac7319bce665a6a53c" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    EXTRACTZIP ## Extract downoaded .zip file
    cp $WORKDIR/$SYSNAME/bios/$BIOSNAME $WORKDIR/$SYSNAME
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi

BIOSNAME="scph5501.bin" ## The name of the file needed by emulators.
CHECKSUM="924e392ed05558ffdb115408c263dccf" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    EXTRACTZIP ## Extract downoaded .zip file
    cp $WORKDIR/$SYSNAME/bios/$BIOSNAME $WORKDIR/$SYSNAME
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi

BIOSNAME="scph5502.bin" ## The name of the file needed by emulators.
CHECKSUM="e56ec1b027e2fe8a49217d9678f7f6bb" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    EXTRACTZIP ## Extract downoaded .zip file
    cp $WORKDIR/$SYSNAME/bios/$BIOSNAME $WORKDIR/$SYSNAME
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi
}

AMIGA(){
echo "Amiga"
SYSNAME="Amiga" ##	Systemname for wich a workingdir is created. 
EXT="zip"	## The extention of the downloaded file.

LINK="http://amigas.ru/amiftp/index.php?dir=AmiFTP/Amiga%20Kickstart%20Roms%20-%20Complete%20-%20TOSEC%20v0.04/KS-ROMs/&file=Kickstart%20v1.3%20rev%2034.5%20%281987%29%28Commodore%29%28A3000%29.rom"	## The link to download a file from.
BIOSNAME="kick13.rom" ## The name of the file needed by emulators.
CHECKSUM="192d6d950d0ed3df8040b788502831c2" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_FILE ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    #EXTRACTZIP ## Extract downoaded .zip file
    #cp $WORKDIR/$SYSNAME/bios/$BIOSNAME $WORKDIR/$SYSNAME
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi

LINK="http://amigas.ru/amiftp/index.php?dir=AmiFTP/Amiga%20Kickstart%20Roms%20-%20Complete%20-%20TOSEC%20v0.04/KS-ROMs/&file=Kickstart%20v2.05%20rev%2037.300%20%281991%29%28Commodore%29%28A600HD%29.rom"	## The link to download a file from.
BIOSNAME="kick20.rom" ## The name of the file needed by emulators.
CHECKSUM="dc10d7bdd1b6f450773dfb558477c230" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_FILE ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    #EXTRACTZIP ## Extract downoaded .zip file
    #cp $WORKDIR/$SYSNAME/bios/$BIOSNAME $WORKDIR/$SYSNAME
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi

LINK="http://amigas.ru/amiftp/index.php?dir=AmiFTP/Amiga%20Kickstart%20Roms%20-%20Complete%20-%20TOSEC%20v0.04/KS-ROMs/&file=Kickstart%20v3.1%20rev%2040.70%20%281993%29%28Commodore%29%28A4000%29.rom"	## The link to download a file from.
BIOSNAME="kick31.rom" ## The name of the file needed by emulators.
CHECKSUM="e40a5dfb3d017ba8779faba30cbd1c8e" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_FILE ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    #EXTRACTZIP ## Extract downoaded .zip file
    #cp $WORKDIR/$SYSNAME/bios/$BIOSNAME $WORKDIR/$SYSNAME
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi
}

DRAGON32(){
echo "Dragon-32"
SYSNAME="Dragon-32" ##	Systemname for wich a workingdir is created. 
LINK="http://www.roust-it.dk/coco/roms/d32V31.rom"	## The link to download a file from.
EXT="zip"	## The extention of the downloaded file.

BIOSNAME="d32.rom" ## The name of the file needed by emulators.
CHECKSUM="fcd403db69f54290b51035d82f835e7b" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_FILE
    #DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    #EXTRACTZIP ## Extract downoaded .zip file
    cp $WORKDIR/$SYSNAME/d32V31.rom $WORKDIR/$SYSNAME
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi
}

INTELLIVISION(){
echo "Intellivision"
SYSNAME="Intellivision" ##	Systemname for wich a workingdir is created. 
LINK="http://jasonwilliams400com.startlogic.com/snor/weeds/Intellivision/$BIOSNAME"	## The link to download a file from.
EXT="zip"	## The extention of the downloaded file.

BIOSNAME="exec.bin" ## The name of the file needed by emulators.
CHECKSUM="62e761035cb657903761800f4437b8af" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_FILE
    #DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    #EXTRACTZIP ## Extract downoaded .zip file
    cp $WORKDIR/$SYSNAME/d32V31.rom $WORKDIR/$SYSNAME
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi

BIOSNAME="grom.bin" ## The name of the file needed by emulators.
CHECKSUM="0cd5946c6473e42e8e4c2137785e427f" ## The checksum to be checked if file is valid.
if [ -e $WORKDIR/$BIOSNAME ] ## checking if file is present.
then ## if file exists then verify if checksum checks out.
    echo "$BIOSNAME already exists, checking if file is valid."
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
else ## if not then download, extract, copy to workdir and check for validity.
	echo "$BIOSNAME does not exist."
    MAKE_WORKDIR
    DOWNLOAD_FILE
    #DOWNLOAD_ZIP ## Use DOWNLOAD_FILE if its a direct link to a .rom file
    #EXTRACTZIP ## Extract downoaded .zip file
    cp $WORKDIR/$SYSNAME/d32V31.rom $WORKDIR/$SYSNAME
    COPY_BIOSNAME_WORKDIR ## copy $BIOSNAME to $WORKDIR
    CHECK_SUM ## verrify and if valid copy to $BIOSDIR
fi

}

#
#	LIST OF SYSTEM BIOS FILES WITH CHECKSUM AND DOWNLOADLINK (WIP):
#
#	system:		bios:			hash:

#43	TRS-80	level2.rom	ca74822ebc2803c6635a55116ecd9539	 

#46	Panasonic 3do	panafz10.bin	51f2f43ae2f3508a14d9f56597e2d3ce	 

#47	Sega Saturn	saturn_bios.bin	af5828fdff51384f99b3c4926be27762	 


DONE(){
echo "####################################"
echo "all bios files have been checked and downloaded!"
echo "####################################"
## DONE:

#1	Sega 32x	32X_G_BIOS.BIN	6a5433f6a132a2b683635819a6dcf085
#2	Sega 32x	32X_M_BIOS.BIN	f88354ec482be09aeccd76a97bb75868	 
#3	Sega 32x	32X_S_BIOS.BIN	7f041b6a55cd7423a6c08a219335269e	 
#	LINK:	http://50.7.92.186/ukIpalnq13Lasfp75BBaa/epforums/upload/2/3/4/5/2/192311740647317996.zip
#4	Atari 8-bit Series	5200.rom	#281f20ea4320404ec820fb7ec0693b38
#6	Atari 8-bit Series	ATARIBAS.ROM	0bac0c6a50104045d902df4503a4c30b	 
#7	Atari 8-bit Series	ATARIOSA.ROM	eb1f32f5d9f382db1bbfb8d7f9cb343a	 
#8	Atari 8-bit Series	ATARIOSB.ROM	a3e8d617c95d08031fe1b20d541434b2	 
#9	Atari 8-bit Series	ATARIXL.ROM	06daac977823773a3eea3422fd26a703	 
#	LINK:	http://marc-abramowitz.com/download/atari/OSRoms/
#5	Atari 7800	7800 BIOS (U).rom	0763f1ffb006ddbe32e52d497ee848ae	 
#	LINK:	http://www.romcollector.com/storage/emulators/mess/a7800.zip
#10	MSX	CARTS.SHA	d6dedca1112ddfda94cc9b2e426b818b	
#11	MSX	CYRILLIC.FNT	85b38e4128bbc300e675f55b278683a8	
#12	MSX	DISK.ROM	80dcd1ad1a4cf65d64b7ba10504e8190	
#13	MSX	FMPAC.ROM	6f69cc8b5ed761b03afd78000dfb0e19	
#14	MSX	FMPAC16.ROM	af8537262df8df267072f359399a7635	
#15	MSX	ITALIC.FNT	c83e50e9f33b8dd893c414691822740d	
#16	MSX	KANJI.ROM	febe8782b466d7c3b16de6d104826b34	
#17	MSX	MSX.ROM	aa95aea2563cd5ec0a0919b44cc17d47
#18	MSX	MSX2.ROM	ec3a01c91f24fbddcbcab0ad301bc9ef	
#19	MSX	MSX2EXT.ROM	2183c2aff17cf4297bdb496de78c2e8a	
#20	MSX	MSX2P.ROM	6d8c0ca64e726c82a4b726e9b01cdf1e	
#21	MSX	MSX2PEXT.ROM	7c8243c71d8f143b2531f01afa6a05dc	
#22	MSX	MSXDOS2.ROM	6418d091cd6907bbcf940324339e43bb	
#23	MSX	PAINTER.ROM	403cdea1cbd2bb24fae506941f8f655e	
#24	MSX	RS232.ROM	279efd1eae0d358eecd4edc7d9adedf3	
# LINK:	https://www.k3nny.fr/BIOS_Recalbox_v4.1.zip
#25	TI-99/4A	TI-994A.ctg	412ecbf991edcb68edd0e76c2caa4a59
# LINK: 	https://github.com/billzajac/ti99sim/blob/master/roms/TI-994A.dat
#26	Tandy Color Computer	bas13.rom	c2fc43556eb6b7b25bdf5955bd9df825	 
# LINK:	http://www.colorcomputerarchive.com/coco/ROMs/XRoar/CoCo/BASIC_OS/bas13.rom
#27	Sega CD	bios_CD_E.bin	e66fa1dc5820d254611fdcdba0662372	 
#28	Sega CD	bios_CD_J.bin	278a9397d192149e84e820ac621a8edd	 
#29	Sega CD	bios_CD_U.bin	2efd74e3232ff260e371b99f84024f7f	 
# LINK:	http://fantasyanime.com/files/emulators/SegaCD_BIOS.zip

#32	Dreamcast	dc_boot.bin	e10c53c2f8b90bab96ead2d368858623	 
#33	Dreamcast	dc_flash.bin	74e3f69c2bb92bc1fc5d9a53dcf6ffe2	 

#30	Colecovision	coleco.rom	2c66f5911e5b42b8ebe113403548eee7	 
#34	Nintendo Family Computer Disk System	disksys.rom	ca30b50f880eb660a320674ed365ef7a
#37	Game Boy Advance	gba_bios.bin	a860e8c0b6d573d191e4ec7db1b1e4f6	 
# LINK:	https://www.k3nny.fr/BIOS_Recalbox_v4.1.zip
#35	Sega CD	eu_mcd2_9306.bin	d8b8b720dea6c6ba25c309ed633930f4	 
#52	Sega CD	us_scd2_9306.bin	854b9150240a198070150e4566ae1290	
#39	Sega CD	jp_mcd1_9112.bin	bdeb4c47da613946d422d97d98b21cda	 
#44	Lynx	lynxboot.img	fcd403db69f54290b51035d82f835e7b	 
#45	Videopac / Odyssey 2	o2rom.bin	562d5ebf9e030a40d6fabfc2f33139fd	 
#51	PC Engine / TurboGrafx 16	syscard3.pce	ff1a674273fe3540ccef576376407d1d	 

#48	PSX	scph5500.bin	8dd7d5296a650fac7319bce665a6a53c	 
#49	PSX	scph5501.bin	924e392ed05558ffdb115408c263dccf	 
#50	PSX	scph5502.bin	e56ec1b027e2fe8a49217d9678f7f6bb	 

#40	Amiga	kick13.rom	192d6d950d0ed3df8040b788502831c2
#41	Amiga	kick20.rom	dc10d7bdd1b6f450773dfb558477c230	 
#42	Amiga	kick31.rom	e40a5dfb3d017ba8779faba30cbd1c8e	 
# LINK:	http://amigas.ru/amiftp/index.php?dir=AmiFTP/Amiga%20Kickstart%20Roms%20-%20Complete%20-%20TOSEC%20v0.04/KS-ROMs/&file=Kickstart%20v1.3%20rev%2034.5%20%281987%29%28Commodore%29%28A3000%29.rom

#31	Dragon 32	d32.rom	3420b96031078a4ef408cad7bf21a33f	 
# LINK:	http://www.roust-it.dk/coco/roms/d32V31.rom


#36	Intellivision	exec.bin	62e761035cb657903761800f4437b8af	 
#38	Intellivision	grom.bin	0cd5946c6473e42e8e4c2137785e427f	 

}
#EXAMPLE_SYSTEM 

#SEGA32X
#ATARI8BIT
#ATARI_7800
#MSX
#TI994A
#TANDY_COLOR
#SEGA_CD
#SEGA_CD2
#DREAMCAST
#COLECO
#NINTENDO_FCDS
#GAMEBOY_ADVANCED
#LYNX
#VIDEOPAC-ODYSSEY
#PC_ENGINE
#PSX
#AMIGA
#DRAGON32
INTELLIVISION

DONE
}
THEME(){
echo " = = = = = = = = = = = = = = = = = = = = "
echo "Installing custom emulationstation theme..."
echo " = = = = = = = = = = = = = = = = = = = = "
CURNTHEME="/etc/emulationstation/themes/carbon"
NEWTHEME="/opt/retropie/configs/all/emulationstation/themes/carbon-custom"
NEWART="menu-files/art"
mkdir -p $NEWART/bios-downloader
cp -u $CURNTHEME $NEWTHEME
cp -u $NEWART $NEWTHEME/bios-downloader/art
cp -u menu-files/theme.xml $NEWTHEME/bios-downloader/theme.xml
echo "A new custom theme has been set up at $NEWTHEME"
echo "Select it in emulationstation to use it"
read -rsp $'Press any key to continue...\n' -n 1 key
}
######## EXECUTION ########
CONFIGURE
SYSTEM_DOWNLOAD
THEME