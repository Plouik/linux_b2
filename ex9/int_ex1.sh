#!/bin/bash

LOG_ERREURS="rapports_erreurs.log"
FICHIER_TEMP="/tmp/mon_fichier_temp.log"

# TODO: Activer pipefail
# set -o pipefail

# TODO: Mettre en place un trap pour supprimer FICHIER_TEMP
# trap ...

generer_rapport() {
    local username=$1
    local date_creation=$(date +"%Y-%m-%d %H:%M:%S")

    # TODO: Rediriger stderr de cette fonction vers $LOG_ERREURS
    echo "Génération du rapport pour $username..."
    echo "Rapport pour l'utilisateur $username créé le $date_creation" > "$FICHIER_TEMP"

    # Simulation d'une erreur
    if [[ "$username" == "admin" ]]; then
        echo "Erreur lors du traitement d'admin !" >&2
        return 1
    fi
    return 0
}

# Crée un fichier de log vide au début pour un test propre
> "$LOG_ERREURS"

echo "--- Début du script ---"

# Test de la gestion des erreurs et redirections
generer_rapport "user1"
generer_rapport "admin" # Devrait générer une erreur
generer_rapport "user2"

echo "--- Test de pipefail ---"
if false | grep "test"; then
    echo "Le pipeline a réussi (ce ne devrait pas arriver avec pipefail)."
else
    echo "Le pipeline a échoué comme prévu."
fi

echo "--- Fin du script ---"
echo "Consultez $LOG_ERREURS et $FICHIER_TEMP pour vérifier."
