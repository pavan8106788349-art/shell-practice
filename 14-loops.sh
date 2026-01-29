#!/bin/bash

USERID=$(id -u)
LOGS_FILE="/var/log/shell-script/$0.log"

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
    dnf list installed $package &>>>$LOGS_FILE
    if [ $? -ne 0 ]; then
         echo "$package not installed, installing now"
    dnf install $pacakage -y &>>$LOGS_FILE
    VALIDATE $? "$package installation"
    else
       echo "$package already installed, skipping"
    fi    
done   