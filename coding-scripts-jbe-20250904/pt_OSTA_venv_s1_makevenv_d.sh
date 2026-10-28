#! /usr/bin/env bash

ptn3="/usr/local/bin/python3.9"
py3="./venv/bin/python3"

echo "Creating virtual environment ./venv ..."
${ptn3} -m venv venv

echo "Upgrading pip to latest version ..."
${py3} -m pip install --upgrade pip

echo -e "To activate venv in bash shell run:\n\tsource ./venv/bin/activate!"

echo "Done!"

