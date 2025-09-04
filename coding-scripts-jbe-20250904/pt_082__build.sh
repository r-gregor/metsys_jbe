#! /usr/bin/env bash

rqrmnts='requirements_d.txt'

if [ -d venv ]; then
    echo "'venv' virtual environment exists!"
    exit 0
else
    /usr/bin/python3 -m venv venv
    ./venv/bin/python -m pip install --upgrade pip
    ./venv/bin/python -m pip install -r ${rqrmnts}
fi

