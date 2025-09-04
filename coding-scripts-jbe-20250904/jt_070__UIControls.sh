#! /bin/bash

i=3

for name in EMSO DS PL ZZZS; do
    echo "Label ${name}Label = new Label(\"${name} : \");"
    echo "gridPane.add(${name}Label, 0, $i);"
    echo ""
    echo "TextField ${name}Field = new TextField();"
    echo "${name}Field.setPrefHeight(40);"
    echo "gridPane.add(${name}Field, 1, $i);"
    echo "// -----------------------------------------------------"
    
    let i=i+1
done
