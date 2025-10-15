#!/bin/bash

# Définir le chemin à vérifier
chemin=$1

# Vérifier si le chemin existe et est un répertoire
if [ -d "$chemin" ]; then
    echo "Le chemin $chemin existe et est un répertoire."
elif [ -f "$chemin" ]; then
    echo "Le chemin $chemin existe et est un fichier régulier."
else
    echo "Le chemin $chemin n'existe pas."
fi   