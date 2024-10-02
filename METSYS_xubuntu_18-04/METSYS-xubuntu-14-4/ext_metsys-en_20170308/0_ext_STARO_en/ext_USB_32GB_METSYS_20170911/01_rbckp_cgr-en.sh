#! /bin/bash

### Name:	01_rbckp_cgr-en.sh
### Date:	2017-09-11
### Decription:
### 
### rsync backup /c/Users/gregor.redelonghi/
### rsync backup /c/Users/gregor.redelonghi/myprogs/cygwin64
### *********************************************************************************************************

# VARIABLES
gr_CURRDATE="$(date +%Y%m%d)"
gr_DANES="$(date +%Y%m%d)"
gr_CURRT="$(date +%Y%m%d-%H%M%S)"
gr_CURDRV=${PWD//\//}

read -p "Current Drive is: [ ${gr_CURDRV} ]. OK?"
export gr_DRIVE=${gr_CURDRV}
export gr_EXTMOUNTP=${gr_DRIVE}
export gr_BEKAPD=${gr_EXTMOUNTP}/bekaps
export gr_LOGF=/${gr_BEKAPD}/bekap-en.log

# VARIABLES new 20170303
gr_RSDRO='rsync -rltDvn --progress --modify-window=2'		# DRY-RUN options
gr_RSO='rsync -rltDv --progress --modify-window=2'  		# RUN backup ptions


# RUN ...
echo "log-file: ${gr_LOGF}"

export gr_DNBCKP=/${gr_EXTMOUNTP}/METSYS/DONOTBACKUP.txt

if [ ! -e ${gr_DNBCKP} ]; then
	echo "Wrog DRIVE letter or there is no ${gr_DNBCKP}. Aborting ..."
	exit 1
fi

echo "${gr_DNBCKP} exists. It is safe to continue ..."

cd /${gr_BEKAPD}
echo "Current directory is ${PWD} ..."
read -p "Continue?"

### *********************************************************************************************************


echo
echo    "*************************************"
echo    "* ?? IS IT OK TO DO REAL BACKUPS ?? *"
echo    "*************************************"
echo
read -p "Press any key to continue or <ctrl+c> to quit ..."

echo "[ $(date +%Y%m%d-%H%M%S) ] -- Starting backup of CGR-EN ... " | tee -a ${gr_LOGF}

echo -e "\n-----------------------------------------------------------------------"
echo "Backing up /c/Users/gregor.redelonghi/ ..."
${gr_RSO} --delete --exclude-from=${gr_DNBCKP} /c/Users/gregor.redelonghi/ /${gr_BEKAPD}/bekap-c_gregor.redelonghi/

echo -e "\n-----------------------------------------------------------------------"
echo "Backing up /c/Users/gregor.redelonghi/Downloads/ ..."
${gr_RSO} /c/Users/gregor.redelonghi/Downloads/ /${gr_BEKAPD}/bekap-c_gregor.redelonghi_Downloads/

echo -e "\n-----------------------------------------------------------------------"
echo "Backing up @Cygwin/home/gregor.redelonghi/ ..."
${gr_RSO} --delete /home/gregor.redelonghi/ /${gr_BEKAPD}/bekap-cygwin-en_home-gregor.redelonghi/

echo -e "\n-----------------------------------------------------------------------"
echo "Backing up @Cygwin/etc/ ..."
${gr_RSO} --delete /etc/ /${gr_BEKAPD}/bekap-cygwin-en_rut-etc/

echo -e "\n-----------------------------------------------------------------------"
echo "[ $(date +%Y%m%d-%H%M%S) ] -- Successfuly backed up CGR-EN." | tee -a ${gr_LOGF}
echo "[ $(date +%Y%m%d-%H%M%S) ] --------------------------------" | tee -a ${gr_LOGF}
echo 


echo
echo 'Done!'
exit

