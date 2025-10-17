apt update && apt install ufw
ufw status verbose
ufw default deny incoming
ufw default allow outgoing   
ufw allow ssh   
ufw enable
ufw status verbose

