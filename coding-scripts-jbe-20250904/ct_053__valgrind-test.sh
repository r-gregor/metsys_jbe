#! /usr/bin/env bash

executable="./bin/BrthReminder"
/usr/bin/valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes -s ${executable}

