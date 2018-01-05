#!/bin/bash
#echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
#echo "RetroPie/RetroArch/EmulationStation Bios files downloader"
#echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
CONFIGURE(){
WORKDIR=~/RetroPie-Bios-Files/BIOS
BIOSDIR=~/RetroPie/BIOS
cp $BIOSDIR $WORKDIR
MAKE_WORKDIR(){
mkdir -p $WORKDIR/$SYSNAME/
}
DOWNLOAD(){
cd $WORKDIR/$SYSNAME/
wget $LINK -o $WORKDIR/$SYSNAME/$SYSNAME.$EXT
}
EXTRACTZIP(){
unzip $WORKDIR/$SYSNAME/$SYSNAME.zip -d $WORKDIR/$SYSNAME
#rm $WORKDIR/$SYSNAME/$SYSNAME.zip
}
}

SYSTEM_DOWNLOAD(){

EXAMPLE_SYSTEM(){
echo "Example-System"
SYSNAME="Example-System"	## The system name of wich a folder will be created in the working dir
BIOSNAME="EXAMPLE_BIOS.BIN"	## The name of the bios file.
CHECKSUM="SOME MD5 HASH"	## The checksum to check for verification.
LINK="HTTP://SOMEURLTO/DOWNLOAD.ZIP" ## The link to download the file from.
EXT="ZIP" ## The extention of the downloaded file.
MAKE_WORKDIR	## Make the directories if not already present.
DOWNLOAD	## Download the file from the link.
EXTRACTZIP	## Extract the downloaded zip file.
}

SEGA32X(){
echo "Sega32x"
SYSNAME="Sega32x"

BIOSNAME="32X_G_BIOS.BIN"
CHECKSUM="6a5433f6a132a2b683635819a6dcf085"
BIOSNAME="32X_M_BIOS.BIN"
CHECKSUM="f88354ec482be09aeccd76a97bb75868"
BIOSNAME="32X_S_BIOS.BIN"
CHECKSUM="7f041b6a55cd7423a6c08a219335269e"

LINK="http://50.7.92.186/ukIpalnq13Lasfp75BBaa/epforums/upload/2/3/4/5/2/192311740647317996.zip"
EXT="zip"
MAKE_WORKDIR
DOWNLOAD
EXTRACTZIP
}

#
#	LIST OF SYSTEM BIOS FILES WITH CHECKSUM AND DOWNLOADLINK (WIP):
#
#	system:		bios:			hash:
#4	Atari 8-bit Series	5200.rom	281f20ea4320404ec820fb7ec0693b38
#5	Atari 7800	7800 BIOS (U).rom	0763f1ffb006ddbe32e52d497ee848ae	 
#6	Atari 8-bit Series	ATARIBAS.ROM	0bac0c6a50104045d902df4503a4c30b	 
#7	Atari 8-bit Series	ATARIOSA.ROM	eb1f32f5d9f382db1bbfb8d7f9cb343a	 
#8	Atari 8-bit Series	ATARIOSB.ROM	a3e8d617c95d08031fe1b20d541434b2	 
#9	Atari 8-bit Series	ATARIXL.ROM	06daac977823773a3eea3422fd26a703	 
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
#25	TI-99/4A	TI-994A.ctg	412ecbf991edcb68edd0e76c2caa4a59	 
#26	Tandy Color Computer	bas13.rom	c2fc43556eb6b7b25bdf5955bd9df825	 
#27	Sega CD	bios_CD_E.bin	e66fa1dc5820d254611fdcdba0662372	 
#28	Sega CD	bios_CD_J.bin	278a9397d192149e84e820ac621a8edd	 
#29	Sega CD	bios_CD_U.bin	2efd74e3232ff260e371b99f84024f7f	 
#30	Colecovision	coleco.rom	2c66f5911e5b42b8ebe113403548eee7	 
#31	Dragon 32	d32.rom	3420b96031078a4ef408cad7bf21a33f	 
#32	Dreamcast	dc_boot.bin	e10c53c2f8b90bab96ead2d368858623	 
#33	Dreamcast	dc_flash.bin	74e3f69c2bb92bc1fc5d9a53dcf6ffe2	 
#34	Nintendo Family Computer Disk System	disksys.rom	ca30b50f880eb660a320674ed365ef7a
#35	Sega CD	eu_mcd2_9306.bin	d8b8b720dea6c6ba25c309ed633930f4	 
#36	Intellivision	exec.bin	62e761035cb657903761800f4437b8af	 
#37	Game Boy Advance	gba_bios.bin	a860e8c0b6d573d191e4ec7db1b1e4f6	 
#38	Intellivision	grom.bin	0cd5946c6473e42e8e4c2137785e427f	 
#39	Sega CD	jp_mcd1_9112.bin	bdeb4c47da613946d422d97d98b21cda	 
#40	Amiga	kick13.rom	192d6d950d0ed3df8040b788502831c2	 
#41	Amiga	kick20.rom	dc10d7bdd1b6f450773dfb558477c230	 
#42	Amiga	kick31.rom	e40a5dfb3d017ba8779faba30cbd1c8e	 
#43	TRS-80	level2.rom	ca74822ebc2803c6635a55116ecd9539	 
#44	Lynx	lynxboot.img	fcd403db69f54290b51035d82f835e7b	 
#45	Videopac / Odyssey 2	o2rom.bin	562d5ebf9e030a40d6fabfc2f33139fd	 
#46	Panasonic 3do	panafz10.bin	51f2f43ae2f3508a14d9f56597e2d3ce	 
#47	Sega Saturn	saturn_bios.bin	af5828fdff51384f99b3c4926be27762	 
#48	PSX	scph5500.bin	8dd7d5296a650fac7319bce665a6a53c	 
#49	PSX	scph5501.bin	924e392ed05558ffdb115408c263dccf	 
#50	PSX	scph5502.bin	e56ec1b027e2fe8a49217d9678f7f6bb	 
#51	PC Engine / TurboGrafx 16	syscard3.pce	ff1a674273fe3540ccef576376407d1d	 
#52	Sega CD	us_scd2_9306.bin	854b9150240a198070150e4566ae1290	

## DONE:

#1	Sega 32x	32X_G_BIOS.BIN	6a5433f6a132a2b683635819a6dcf085
#2	Sega 32x	32X_M_BIOS.BIN	f88354ec482be09aeccd76a97bb75868	 
#3	Sega 32x	32X_S_BIOS.BIN	7f041b6a55cd7423a6c08a219335269e	 
#	LINK:	http://50.7.92.186/ukIpalnq13Lasfp75BBaa/epforums/upload/2/3/4/5/2/192311740647317996.zip



#EXAMPLE_SYSTEM
SEGA32X

}
######## EXECUTION ########
CONFIGURE
SYSTEM_DOWNLOAD