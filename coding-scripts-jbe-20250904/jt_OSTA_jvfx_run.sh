#! /bin/bash
# filename: jvfx_compile

SC_NAME=$1

java --module-path $PATH_TO_FX --add-modules=javafx.controls ${SC_NAME}
