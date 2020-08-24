#!/bin/bash


for f in $* ; do
    echo "Resetting log file: $f"
    cat < /dev/null > "$f"
done
