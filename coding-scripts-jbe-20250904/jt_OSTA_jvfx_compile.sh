#! /bin/bash
# filename: jvfx_compile

SC_NAME=$1

javac --module-path $PATH_TO_FX --add-modules=javafx.controls ${SC_NAME}.java
