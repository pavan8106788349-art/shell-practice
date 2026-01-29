#!/bin/bash

USERID=$(id -u)
LOGS_FILE="/var/log/shell-script/$0.log"
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e0m"

if [ $USERID -ne 0 ]; then
    echo -e "$R Please run this script with root user access $N"
    exit 1
fi

mkdir -p $LOGS_FOLDER

VALIDATE(){
    if [ $1 -ne 0 ]; then
         echo "$2 ...$R FAILURE $N"
         exit 1
    else
        echo "$2 ...$G SUCCESS $Y"
    fi         
}

for package in $@ # sudo sh 13-loops.sh nginx mysql nodejs
do
    dnf list installed $package &>>$LOGS_FILE
    if [ $? -ne 0 ]; then
         echo "$package not installed, installing now"
    dnf install $pacakage -y &>>$LOGS_FILE
    VALIDATE $? "$package installation"
    else
       echo -e "$package already installed ...$Y, skipping $N"
    fi    
done   