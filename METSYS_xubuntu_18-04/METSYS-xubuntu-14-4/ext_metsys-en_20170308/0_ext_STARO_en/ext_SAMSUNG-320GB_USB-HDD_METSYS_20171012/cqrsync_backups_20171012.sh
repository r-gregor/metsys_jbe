#! /bin/bash

### Name:	qrsync_backups_20170911.sh
### Date:	2017_09_11
### Decription:
### 
### quick backup all (01_ ... 04_)
### *********************************************************************************************************

yes | (\
METSYS/01_rbckp_cgr_en.sh && \
METSYS/02_rbckp_cgr_en_2017.sh\
)

