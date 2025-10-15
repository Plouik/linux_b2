#!/bin/bash
# Script de surveillance intégrée nginx + auditd

LOG_NGINX="/var/log/nginx/access.log"
AUDIT_LOG="/var/log/audit/audit.log"
RAPPORT_DIR="/home/demo/linux_b2/report"

surveiller_nginx_audit() {
 local date_actuelle=$(date +"%Y-%m-%d")
 local fichier_rapport="$RAPPORT_DIR/surveillance_$date_actuelle.log"
 
 echo "=== Surveillance nginx + audit - $(date) ===" >> "$fichier_rapport"
 
 # Analyse des logs nginx
 echo "--- Activité nginx ---" >> "$fichier_rapport"
 tail -n 1000 "$LOG_NGINX" | awk '
 $9 >= 400 { errors++ }
 END { 
 if (errors > 0) print "Erreurs HTTP détectées:", errors 
 else print "Aucune erreur récente"
 }' >> "$fichier_rapport"
 
 # Analyse des événements d'audit sur nginx
 echo "--- Événements d'audit nginx ---" >> "$fichier_rapport"
 ausearch -k nginx_logs -ts today 2>/dev/null | \
 grep -c "SYSCALL" | \
 awk '{print "Événements d audit nginx:", $1}' >> "$fichier_rapport"
 
 # Alerte si nécessaire
 local erreurs=$(tail -n 50 "$LOG_NGINX" | grep -c " 5[0-9][0-9] ")
 if [[ $erreurs -gt 10 ]]; then
 logger -t nginx_monitor "ALERTE: $erreurs erreurs serveur détectées"
 echo "ALERTE: Niveau d'erreur élevé ($erreurs)" >> "$fichier_rapport"
 fi
}


# Exécution
mkdir -p "$RAPPORT_DIR"
surveiller_nginx_audit