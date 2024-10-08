#!/bin/zsh
arg=$1

if [[ $arg = "start" ]] || [[ $arg = "up" ]] || [[ $arg = "" ]]; then
    echo "starting nessus"
    sudo launchctl start com.tenablesecurity.nessusd
elif [[ $arg = "stop" ]] || [[ $arg = "down" ]]; then
    echo "stopping nessus"
    sudo launchctl stop com.tenablesecurity.nessusd
else
    echo "invalid argument (start/stop)"
fi