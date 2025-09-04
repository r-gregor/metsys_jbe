#! /bin/bash

### Name:	Scriptname ...
### Author:	Author ... 
### Date:	2013-05-24 
### Decription:
### 
### 
### 
 
gr_SRCPATH=/home/gregor.redelonghi/JAVA_en_testing/elektrika_en_20181009/application/elektrika

cd ${gr_SRCPATH}
echo $PWD


java -jar Elektrika.jar $@
