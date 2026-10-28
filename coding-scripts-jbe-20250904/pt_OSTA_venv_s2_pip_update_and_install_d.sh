#! /usr/bin/env bash

FILE=$(realpath ./requirements.txt)
PY3="./venv/bin/python3"
echo $FILE

if [ -f $FILE ]; then
     echo "Upgrading pip to latest version ..."
     ${PY3} -m pip install --upgrade pip
     echo "Installing required dependencies from requirements.txt ..."
     ${PY3} -m pip install -r requirements.txt
     ${PY3} -m pip list
     echo "Done"
else
    echo "No requirements.txt file found"
fi
