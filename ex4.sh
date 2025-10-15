#!/bin/bash
mkdir -p projet/src projet/docs projet/tests
ls /etc/*.conf > projet/src/conf.txt
grep -r "error" /var/log/* | wc -l
echo "error" >> /var/log/errer_demo.txt
alias ll="ls -lra"