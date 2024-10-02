#! /bin/bash

### Name:	qrsync-backups_20170222.sh
### Date:	2013-05-24 
### Decription:
### 
### UPDATED 20160112, 20160119 (remove timestamb from foldername), 20170104 (2016 --> 2017), 20170116 (-rtlv, --modify-window=2),
### UPDATED 20170207 (NO confirmation, test if location OK!)
### UPDATED 20170222 saved as qrsync: quick --> no DRY RUN, just rsync local files (no network drives)
###                  full backup at the end of the working week ...

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

### EXCLUDING FROM RUNNING:
: <<'EOF'
echo -e "\n-------------------------------------------------------"
echo "bekap /c/Users/gregor.redelonghi - DRY RUN ... "
rsync -rtlvn --delete --progress --modify-window=2 --exclude-from=${gr_DNBCKP} /c/Users/gregor.redelonghi/ /${gr_BEKAPD}/bekap-c_gregor.redelonghi/
echo

# A.1 - backup /c/Users/gregor.redelonghi/Downloads --to -- /${gr_BEKAPD}/bekap_c_greg.redelonghi/Downloads
echo -e "\n-------------------------------------------------------"
echo "bekap /c/Users/gregor.redelonghi/Downloads - DRY RUN"
rsync -rtlvn --progress --modify-window=2 /c/Users/gregor.redelonghi/Downloads/ /${gr_BEKAPD}/bekap-c_gregor.redelonghi_Downloads/
echo

# B - backup /home/gregor.redelonghi/ --to-- /${gr_BEKAPD}/bekap-cygwin-en_home-gregor.redelonghi/
echo -e "\n-------------------------------------------------------"
echo "bekap /home/gregor.redelonghi (cygwin-en) - DRY RUN"
rsync -rtlvn --progress --modify-window=2 --delete /home/gregor.redelonghi/ /${gr_BEKAPD}/bekap-cygwin-en_home-gregor.redelonghi/
echo

# C - backup /etc/ --to-- /${gr_BEKAPD}/bekap-cygwin-en_rut-etc/
echo -e "\n-------------------------------------------------------"
echo "bekap /etc/ (cygwin-en) - DRY RUN "
rsync -rtlvn --progress --modify-window=2 --delete /etc/ /${gr_BEKAPD}/bekap-cygwin-en_rut-etc/
echo

# D - backup /c/Users/gregor.redelonghi/2017 --to-- /${gr_BEKAPD}/bekap_en-2017/
echo -e "\n-------------------------------------------------------"
echo "bekap /c/Users/gregor.redelonghi/2017 - DRY RUN"
rsync -rtlvn --progress --modify-window=2 --delete /c/Users/gregor.redelonghi/2017/ /${gr_BEKAPD}/bekap_en-2017/
echo

# E - backup /h/energetika --to-- /${gr_BEKAPD}/bekap_h-energetika/
echo -e "\n-------------------------------------------------------"
echo "bekap /h/energetika - DRY RUN"
rsync -rtlvn --progress --modify-window=2 --delete /h/energetika/ /${gr_BEKAPD}/bekap_h-energetika/
echo

# F - backup /h/2017g/_2017_podloge/ --to-- /${gr_BEKAPD}/bekap_h-2017-podloge/
echo -e "\n-------------------------------------------------------"
echo "bekap /h/2017/_2017_podloge/ - DRY RUN"
rsync -rtlvn --progress --modify-window=2 /h/2017/_2017_podloge/ /${gr_BEKAPD}/bekap_h-2017-podloge/
echo

echo
echo    "*************************************"
echo    "* ?? IS IT OK TO DO REAL BACKUPS ?? *"
echo    "*************************************"
echo
read -p "Press any key to continue or <ctrl+c> to quit ..."
EOF
### EXCLUDING FROM RUNNING:


echo "[ $(date +%Y%m%d-%H%M%S) ] -- Starting backup ... " | tee -a ${gr_LOGF}

echo -e "\n-----------------------------------------------------------------------"
echo "Backing up /c/Users/gregor.redelonghi/ ..."
rsync -rtlv --delete --progress --modify-window=2 --exclude-from=${gr_DNBCKP} /c/Users/gregor.redelonghi/ /${gr_BEKAPD}/bekap-c_gregor.redelonghi/

echo -e "\n-----------------------------------------------------------------------"
echo "Backing up /c/Users/gregor.redelonghi/Downloads/ ..."
rsync -rtlv --progress --modify-window=2 /c/Users/gregor.redelonghi/Downloads/ /${gr_BEKAPD}/bekap-c_gregor.redelonghi_Downloads/

echo -e "\n-----------------------------------------------------------------------"
echo "Backing up @Cygwin/home/gregor.redelonghi/ ..."
rsync -rtlv --progress --modify-window=2 --delete /home/gregor.redelonghi/ /${gr_BEKAPD}/bekap-cygwin-en_home-gregor.redelonghi/

echo -e "\n-----------------------------------------------------------------------"
echo "Backing up @Cygwin/etc/ ..."
rsync -rtlv --progress --modify-window=2 --delete /etc/ /${gr_BEKAPD}/bekap-cygwin-en_rut-etc/

echo -e "\n-----------------------------------------------------------------------"
echo "Backing up /c/Users/gregor.redelonghi/2017/ ..."
rsync -rtlv --progress --modify-window=2 --delete /c/Users/gregor.redelonghi/2017/ /${gr_BEKAPD}/bekap_en-2017/

### excluded fro running:
# rsync -rtlv --progress --modify-window=2 --delete /h/energetika/ /${gr_BEKAPD}/bekap_h-energetika/
# rsync -rtlv --progress --modify-window=2 /h/2017/_2017_podloge/ /${gr_BEKAPD}/bekap_h-2017-podloge/

echo -e "\n-----------------------------------------------------------------------"
echo "[ $(date +%Y%m%d-%H%M%S) ] -- Successfuly backed up QUICK-SET." | tee -a ${gr_LOGF}
echo "[ $(date +%Y%m%d-%H%M%S) ] -----------------------------" | tee -a ${gr_LOGF}
echo 


echo
echo 'Done!'
exit

