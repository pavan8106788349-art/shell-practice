#!/bin/bash

USERID=$(id -u)
LOGS_FOLDER="/var/log/shell-script"
TIME_STAMP= $(date + %Y-%m-%d-%H-%M-%S)
LOGS_FILE="$LOGS_FOLDER/$TIME_STAMP.log"

if [ $USERID -ne 0 ]; then
    echo "Please run this script with root user access"
    exit 1
fi

mkdir -p $LOGS_FOLDER

VALIDATE(){
    if [ $1 -ne 0 ]; then
         echo "$2 ... FAILURE"
         exit 1
    else
        echo "$2 ... SUCCESS"
    fi         
}

for package in $@ # sudo sh 13-loops.sh nginx mysql nodejs
do
    dnf install $pacakage -y
    VALIDATE $? "$package installation"
done    