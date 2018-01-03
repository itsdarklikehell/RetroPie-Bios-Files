#!/bin/bash
echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
echo "RetroPie/RetroArch/EmulationStation Bios files downloader"
echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="


MAKE_WORKDIR(){
cp ~/RetroPie/BIOS ~/RetroPie-Bios-Files/BIOS
}
COPY_BIOSDIR(){
cp ~/RetroPie-Bios-Files/BIOS/*.* ~/RetroPie/BIOS
}
######## EXECUTION ########