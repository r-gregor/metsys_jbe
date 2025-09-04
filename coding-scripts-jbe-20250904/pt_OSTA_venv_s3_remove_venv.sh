#! /usr/bin/env bash

VENVDIR=$(realpath ./venv)
echo $VENVDIR

if [ -d $VENVDIR ]; then
     echo "Removing ./venv ..."
     rm -rv ${VENVDIR}
     echo "Done"
else
    echo "No ${VENVDIR} found"
fi
