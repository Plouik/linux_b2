#!/bin/bash
path=$1
for fichier in $(find "$path" -type f)
do
    echo "$fichier : $(cat $fichier | wc -l) ligne(s)"
done   