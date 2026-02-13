#!/bin/bash

for file in /project_storage/incoming/*; do

    if [[ "$file" == *.tar.gz ]]; then
        mv "$file" /project_storage/approved/
    else
        rm "$file"
    fi

done
