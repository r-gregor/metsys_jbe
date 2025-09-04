#! /usr/bin/env bash

# executable="./BrthReminder"
# /usr/bin/valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes -s ${executable}
/usr/bin/valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes -s $@

