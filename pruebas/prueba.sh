#!/bin/bash

# Comprueba que existe el fichero
if [ -e "paths.txt" ]; then

    # Lee cada linea y busca el fichero
    while IFS= read -r path; do
        echo "$path"
    done < "paths.txt"
else
    echo "paths.txt does not exist."
fi
