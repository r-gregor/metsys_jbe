#! /bin/bash

### Name:	Scriptname ...
### Author:	Author ... 
### Date:	2013-05-24 
### Decription:
### 
### 
### 
 
grPrefix="/home/rgregor/majstaf/coding/JAVA_d/JAVA_d_testing/jn032_elektrika_en_20181120"

gr_SRCPATH=${grPrefix}/application/elektrika

cd ${gr_SRCPATH}
echo $PWD


java -jar ${gr_SRCPATH}/Elektrika_E2017.jar $@

