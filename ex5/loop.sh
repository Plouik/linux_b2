#!/bin/bash
nohup nice -n 2 ./ex5.sh &> /dev/null &disown
#echo $! >> /var/run/command.pid
echo $! >> command.pid
nohup ./ex5.sh &> /dev/null &disown
echo $! >> command.pid
nohup ./ex5.sh &> /dev/null &disown
echo $! >> command.pid
sleep 2s
ps --sort=-nice -l