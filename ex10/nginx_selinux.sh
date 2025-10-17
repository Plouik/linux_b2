#!/bin/bash
# Script de configuration SELinux pour nginx

configurer_selinux_nginx() {
 echo "Configuration SELinux pour nginx..."
 
 # Vérifier le mode SELinux
 if [[ $(getenforce) == "Disabled" ]]; then
 echo "Attention: SELinux est désactivé"
 return 1
 fi
 
 # Permettre à nginx de se connecter au réseau
 setsebool -P httpd_can_network_connect on
 
 # Permettre à nginx de se connecter aux bases de données
 setsebool -P httpd_can_network_connect_db on
 
 # Configuration des contextes pour les répertoires web
 semanage fcontext -a -t httpd_exec_t "/usr/local/nginx/sbin/nginx"
 semanage fcontext -a -t httpd_config_t "/usr/local/nginx/conf(/.*)?"
 semanage fcontext -a -t httpd_log_t "/usr/local/nginx/logs(/.*)?"
 
 # Appliquer les nouveaux contextes
 restorecon -Rv /usr/local/nginx/
 
 # Autoriser nginx à écouter sur des ports personnalisés (exemple: 8080)
 semanage port -a -t http_port_t -p tcp 8080 2>/dev/null || \
 echo "Port 8080 déjà configuré ou erreur"
 
 echo "Configuration SELinux nginx terminée"
}

verifier_contextes_nginx() {
 echo "=== Vérification des contextes nginx ==="
 
 # Contextes des fichiers nginx
 ls -Z /usr/sbin/nginx 2>/dev/null || echo "nginx non trouvé dans /usr/sbin/"
 ls -Z /etc/nginx/ | head -5
 
 # Contextes des processus nginx
 ps -eZ | grep nginx || echo "nginx n'est pas en cours d'exécution"
 
 # Booléens nginx actifs
 echo "Booléens httpd actifs:"
 getsebool -a | grep httpd | grep -E "(on|off)" | head -10
}

analyser_violations_nginx() {
 echo "=== Analyse des violations SELinux nginx ==="
 
 # Rechercher les violations récentes
 local violations=$(ausearch -m avc -ts today 2>/dev/null | grep nginx | wc -l)
 
 if [[ $violations -gt 0 ]]; then
 echo "