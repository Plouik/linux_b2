calculer_taille_repertoire() {
    local repertoire="$1"
    local taille_octets=0

    # Vérifie si le répertoire existe
    if [ ! -d "$repertoire" ]; then
        echo "Erreur : Le répertoire '$repertoire' n'existe pas."
        return 1
    fi

    # Utilise find pour lister tous les fichiers (excluant les dossiers) et calcule la taille totale

    taille_octets=$(du -shbc $repertoire | tail -1 | cut -f1)
    echo "$taille_octets"
    # Convertit la taille en unités lisibles (KB, MB, GB)
    if [ "$taille_octets" -gt 1073741824 ]; then
        taille_formatee=$(echo $(($taille_octets / 1024 / 1024 / 1024))GB)
    elif [ "$taille_octets" -gt 1048576 ]; then
        taille_formatee=$(echo $(($taille_octets / 1024 / 1024))MB)
    elif [ "$taille_octets" -gt 1024 ]; then
        taille_formatee=$(echo $(($taille_octets / 1024 ))KB)
    else
        taille_formatee="${taille_octets} octets"
    fi

    # Affiche la taille totale
    echo "Taille totale du répertoire '$repertoire' : $taille_formatee"
}  
calculer_taille_repertoire $1