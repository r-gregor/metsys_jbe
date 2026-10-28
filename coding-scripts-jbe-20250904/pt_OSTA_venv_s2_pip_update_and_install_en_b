#! /usr/bin/env bash

FILE=$(realpath ./requirements.txt)
PY3="./venv/Scripts/python.exe"
echo $FILE

if [ -f $FILE ]; then
     echo "Updating pip ..."
     ${PY3} -m pip install --upgrade pip
     echo "Installing required dependencies from requirements.txt ..."
     ${PY3} -m pip install -r requirements.txt
     ${PY3} -m pip list
     echo "Done"
else
    echo "No requirements.txt file found"
fi

