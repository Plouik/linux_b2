#!/bin/bash
mkdir -p projet/src projet/docs projet/tests
touch projet/docs/rapport.txt projet/docs/secrets.conf projet/src/script.sh
chmod 00 projet/docs/secrets.conf
chmod g+x projet/src/script.sh
chmod u+x projet/src/script.sh
find . -type f -mtime -1
tar -czf archive-name.tar.gz projet/

useradd test -m -G sudo
passwd demo
getent passwd