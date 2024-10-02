#! /bin/bash

### Name:	01_rbckp_cgr-en.sh
### Date:	2017-09-11
### Decription:
### 
### rsync backup /c/Users/gregor.redelonghi/
### rsync backup /c/Users/gregor.redelonghi/myprogs/cygwin64
###
### UPDATE 20171208: timestamp function
### --progress replaced with --info=misc2,stats2,progress2 
### *********************************************************************************************************

# timestamp
function tms() {
    echo -n "[ $(date +%Y%m%d_%H%M%S) ] -- "
}


# VARIABLES
gr_CURRDATE="$(date +%Y%m%d)"
gr_DANES="$(date +%Y%m%d)"
gr_CURRT="$(date +%Y%m%d_%H%M%S)"
gr_CURDRV=${PWD//\//}

# VARIABLES new 20170303
# UPDATED 20171208: --progress replaced with --info=misc2,stats2,progress2
gr_RSDRO='rsync -rltDn  --info=misc2,stats2,progress2 --modify-window=2'       # DRY-RUN options
gr_RSO='rsync -rltD --info=misc2,stats2,progress2 --modify-window=2'           # RUN backup ptions


# EXPORTS
export gr_DRIVE=${gr_CURDRV}
export gr_EXTMOUNTP=${gr_DRIVE}
export gr_BEKAPD=${gr_EXTMOUNTP}/bekaps
export gr_LOGF=/${gr_BEKAPD}/bekap_en.log
export gr_DNBCKP=/${gr_EXTMOUNTP}/METSYS/DONOTBACKUP.txt


# RUN ...
tms; echo "Starting $0 ..."
read -p "Current Drive is: [ ${gr_CURDRV} ]. OK?"
tms; echo "log-file: ${gr_LOGF}"

# check if --exclude-from file exists
if [ ! -e ${gr_DNBCKP} ]; then
	tms; echo "Wrog DRIVE letter or there is no ${gr_DNBCKP}. Aborting ..."
	exit 1
fi

tms; echo "${gr_DNBCKP} exists. It is safe to continue ..."

cd /${gr_BEKAPD}
tms; echo "Current directory is ${PWD} ..."
read -p "Continue?"

# START
echo "[ $(date +%Y%m%d_%H%M%S) ] -- Starting backup of CGR-en and CYG-en ... " | tee -a ${gr_LOGF}
echo "-----------------------------------------------------------------------"
tms; echo "Backing up /c/Users/gregor.redelonghi/ ..."
${gr_RSO} --delete --exclude-from=${gr_DNBCKP} /c/Users/gregor.redelonghi/ /${gr_BEKAPD}/bekap_c_gregor.redelonghi/

echo "-----------------------------------------------------------------------"
tms; echo "Backing up /c/Users/gregor.redelonghi/Downloads/ ..."
${gr_RSO} /c/Users/gregor.redelonghi/Downloads/ /${gr_BEKAPD}/bekap_c_gregor.redelonghi_Downloads/

echo "-----------------------------------------------------------------------"
tms; echo "Backing up @Cygwin/home/gregor.redelonghi/ ..."
${gr_RSO} --delete /home/gregor.redelonghi/ /${gr_BEKAPD}/bekap_cygwin_en_home_gregor.redelonghi/

echo "-----------------------------------------------------------------------"
tms; echo "Backing up @Cygwin/etc/ ..."
${gr_RSO} --delete /etc/ /${gr_BEKAPD}/bekap_cygwin_en_rut_etc/

echo "-----------------------------------------------------------------------"
echo "[ $(date +%Y%m%d_%H%M%S) ] -- Successfuly backed up CGR-en and CYG-en." | tee -a ${gr_LOGF}
echo "[ $(date +%Y%m%d_%H%M%S) ] -------------------------------------------" >> ${gr_LOGF}

tms; echo 'DONE!'
echo "======================================================================="
exit

