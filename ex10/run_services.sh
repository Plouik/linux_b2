cp monitoring.service /etc/systemd/system/monitoring.service
cp monitoring.timer /etc/systemd/system/monitoring.timer

systemctl daemon-reload

systemctl enable monitoring.service
systemctl enable monitoring.timer

systemctl start monitoring.service
systemctl start monitoring.timer
