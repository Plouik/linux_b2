#!/bin/bash

# Script d'arguments et informations système
# Affiche diverses informations système et traite les arguments fournis

# Vérification des arguments
if [ $# -eq 0 ]; then
    echo "Usage: $0 [arguments]" >&2
    echo "Affiche les informations système et traite les arguments." >&2
    exit 1
fi

# Affichage des informations système
echo "----------------------------------------------"
echo "UTILISATEUR : $USER"
echo "DATE ET HEURE : $(date)"
echo "RÉPERTOIRE COURANT : $(pwd)"
echo "----------------------------------------------"

# Traitement des arguments
echo "Arguments fournis :"
for arg in "$@"; do
    echo "  - $arg"
    value=$(env | grep "$arg")
    if [ -z  "${value}" ];then 
        echo "n'existe pas"
    else 
        echo "$value";
    fi
done

# Exemple d'utilisation de variables d'environnement et de commandes système
echo "Nom de la machine : $(hostname)"
echo "Système d'exploitation : $(uname -s)"
echo "Version du noyau : $(uname -r)"
echo "Architecture : $(uname -m)"
echo "----------------------------------------------"   