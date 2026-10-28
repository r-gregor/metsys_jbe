#! /bin/bash

### Name:	Scriptname ...
### Author:	Author ... 
### Date:	2013-05-24 
### Decription:
### 
### UPDATED 20160112, 20170103
###

### *********************************************************************************************************
echo 
echo "Enter drive letter [usually "j"]: "
read gr_DRIVE
export gr_EXTMOUNTP=${gr_DRIVE}
export gr_BEKAPD=${gr_EXTMOUNTP}/bekaps

echo
export gr_DNBCKP=/${gr_EXTMOUNTP}/METSYS/DONOTBACKUP.txt

if [ ! -e ${gr_DNBCKP} ]; then
	echo "Wrog DRIVE letter or there is no ${gr_DNBCKP}. Aborting ..."
	exit 1
fi

echo -n "${gr_DNBCKP} exists."
read -p " It is safe to continue ..."
 
cd /${gr_BEKAPD}
echo "Current directory is ${PWD} ..."
read -p "Continue?"

### *********************************************************************************************************

echo -e "\n-------------------------------------------------------"
echo "bekap /c/Users/gregor.redelonghi - DRY RUN ... "
rsync -rtlvn --delete --progress --modify-window=2 --exclude-from=${gr_DNBCKP} /c/Users/gregor.redelonghi/ /${gr_BEKAPD}/bekap-c_gregor.redelonghi/
echo
read -p "Continue?"

# A.1 - backup /c/Users/gregor.redelonghi/Downloads --to -- /${gr_BEKAPD}/bekap_c_greg.redelonghi_Downloads
echo -e "\n-------------------------------------------------------"
echo "bekap /c/Users/gregor.redelonghi/Downloads - DRY RUN"
rsync -rtlvn --progress --modify-window=2  /c/Users/gregor.redelonghi/Downloads/ /${gr_BEKAPD}/bekap-c_gregor.redelonghi_Downloads/
# clear && rsync -rtlv --progress --modify-window=2 /c/Users/gregor.redelonghi/Downloads/ /${gr_BEKAPD}/bekap-c_gregor.redelonghi_Downloads/		
echo
read -p "Continue?"
	
# B - backup /home/gregor.redelonghi/ --to-- /${gr_BEKAPD}/bekap-cygwin-en_home-gregor.redelonghi/
echo -e "\n-------------------------------------------------------"
echo "bekap /home/gregor.redelonghi (cygwin-en) - DRY RUN"
rsync -rtlvn --progress --modify-window=2 --delete  /home/gregor.redelonghi/ /${gr_BEKAPD}/bekap-cygwin-en_home-gregor.redelonghi/
echo
read -p "Continue?"

# C - backup /etc/ --to-- /${gr_BEKAPD}/bekap-cygwin-en_rut-etc/
echo -e "\n-------------------------------------------------------"
echo "bekap /etc/ (cygwin-en) - DRY RUN "
rsync -rtlvn --progress --modify-window=2 --delete  /etc/ /${gr_BEKAPD}/bekap-cygwin-en_rut-etc/
echo
read -p "Continue?"

	
# D - backup /c/Users/gregor.redelonghi/2017 --to-- /${gr_BEKAPD}/bekap_en-2017/
echo -e "\n-------------------------------------------------------"
echo "bekap /c/Users/gregor.redelonghi/2017 - DRY RUN"
rsync -rtlvn --progress --modify-window=2 --delete  /c/Users/gregor.redelonghi/2017/ /${gr_BEKAPD}/bekap_en-2017/
echo
read -p "Continue?"

# E - backup /h/energetika --to-- /${gr_BEKAPD}/bekap_h-energetika/
echo -e "\n-------------------------------------------------------"
echo "bekap /h/energetika - DRY RUN"
rsync -rtlvn --progress --modify-window=2 --delete  /h/energetika /${gr_BEKAPD}/bekap_h-energetika/
echo


echo
echo    "*************************************"
echo    "* ?? IS IT OK TO DO REAL BACKUPS ?? *"
echo    "*************************************"
echo
read -p "Press any key to continue or <ctrl+c> to quit ..."


rsync -rtlv --delete --progress --modify-window=2 --exclude-from=${gr_DNBCKP} /c/Users/gregor.redelonghi/ /${gr_BEKAPD}/bekap-c_gregor.redelonghi/
rsync -rtlv --progress --modify-window=2 /c/Users/gregor.redelonghi/Downloads/ /${gr_BEKAPD}/bekap-c_gregor.redelonghi_Downloads/
rsync -rtlv --progress --modify-window=2 --delete /home/gregor.redelonghi/ /${gr_BEKAPD}/bekap-cygwin-en_home-gregor.redelonghi/
rsync -rtlv --progress --modify-window=2 --delete /etc/ /${gr_BEKAPD}/bekap-cygwin-en_rut-etc/
rsync -rtlv --progress --modify-window=2 --delete /c/Users/gregor.redelonghi/2017/ /${gr_BEKAPD}/bekap_en-2017/
rsync -rtlv --progress --modify-window=2 --delete /h/energetika /${gr_BEKAPD}/bekap_h-energetika/

echo
echo 'Done!'
exit

