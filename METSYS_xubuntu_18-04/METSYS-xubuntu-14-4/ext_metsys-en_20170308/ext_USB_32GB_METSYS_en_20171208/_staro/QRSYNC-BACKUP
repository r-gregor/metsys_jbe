#! /bin/bash

### Name:	qrsync-backups_20170222.sh
### Date:	2013-05-24 
### Decription:
### 
### UPDATED 20160112, 20160119 (remove timestamb from foldername), 20170104 (2016 --> 2017), 20170116 (-rtlv, --modify-window=2),
### UPDATED 20170207 (NO confirmation, test if location OK!)
### UPDATED 20170222 saved as qrsync: quick --> no DRY RUN, just rsync local files (no network drives)
###                  full backup at the end of the working week ...
### UPDATED 20170303 store rsync command and options to variables and compound rsync command from them ...
### UPDATED 20170901 NO MORE tar.gz-ed Dropbpx - rsync dirsctli to bakupdir: c_User_gregor.redelonghi_Dropbox_{ODPRTO,SKUPNI}
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
gr_RSO='rsync -rltDv --progress --modify-window=2'		# RUN backup ptions


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

echo "[ $(date +%Y%m%d-%H%M%S) ] -- Starting backup ... " | tee -a ${gr_LOGF}

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
echo "Backing up /c/Users/gregor.redelonghi/2017/ ..."
${gr_RSO} --delete /c/Users/gregor.redelonghi/2017/ /${gr_BEKAPD}/bekap_en-2017/


### NOVO 20170901
echo -e "\n-----------------------------------------------------------------------"
echo "Backing up /c/Users/gregor.redelonghi/Dropbox/{ODPRTO,SKUPNI} ..."
${gr_RSO} --delete /c/Users/gregor.redelonghi/Dropbox/ODPRTO/ /${gr_BEKAPD}/c_Users_gregor.redelonghi_Dropbox_ODPRTO/
${gr_RSO} --delete /c/Users/gregor.redelonghi/Dropbox/SKUPNI/ /${gr_BEKAPD}/c_Users_gregor.redelonghi_Dropbox_SKUPNI/

### excluded fro running:
# ${gr_RSO} --delete /h/energetika/ /${gr_BEKAPD}/bekap_h-energetika/
# ${gr_RSO} /h/2017/_2017_podloge/ /${gr_BEKAPD}/bekap_h-2017-podloge/

echo -e "\n-----------------------------------------------------------------------"
echo "[ $(date +%Y%m%d-%H%M%S) ] -- Successfuly backed up QUICK-SET." | tee -a ${gr_LOGF}
echo "[ $(date +%Y%m%d-%H%M%S) ] -----------------------------" | tee -a ${gr_LOGF}
echo 


echo
echo 'Done!'
exit

