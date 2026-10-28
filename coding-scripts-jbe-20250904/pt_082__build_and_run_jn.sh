#! /usr/bin/env bash

jptnbk='folium_test_d.ipynb'
rqrmnts='requirements_d.txt'

if [ -d venv ]; then
    echo "'venv' virtual environment exists! Running jupyter notebook ..."
    sleep 3
    ./venv/bin/jupyter notebook ${jptnbk}
    exit 0
else
    /usr/bin/python3 -m venv venv
    ./venv/bin/python -m pip install --upgrade pip
    ./venv/bin/python -m pip install -r ${rqrmnts}
    ./venv/bin/jupyter notebook ${jptnbk}
fi

