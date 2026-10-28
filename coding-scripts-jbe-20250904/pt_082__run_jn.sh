#! /usr/bin/env bash


if [ ! -d venv ]; then
    echo "Must run inside 'venv' virtual environment!"
    exit 1
fi

./venv/bin/jupyter notebook folium_test_d.ipynb

