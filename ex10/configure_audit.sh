# Configuration des règles d'audit pour nginx
configurer_audit_nginx() {
 auditctl -w /var/log/nginx/ -p rwa -k nginx_log
 auditctl -w /etc/nginx/ -p wa -k nginx_config
 echo "Règles d'audit nginx configurées"
}

configurer_audit_nginx