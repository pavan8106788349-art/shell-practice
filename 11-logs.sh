#!/bin/bash

USERID=$(id -u)
LOGS_FOLDER="/var/log/shell-script"
LOGS_FILE="/VAR/log/shell-script/$0.log"

if [ $USERID -ne 0 ]; then
    echo "Please run this script with root user access"
    exit 1
fi

mkdir -p $LOGS_FOLDER

VALIDATE(){
    if [ $1 -ne o ]; then
        echo "$2 ... FAILURE"
        exit 1
    else
       echo "$2 ... SUCCESS"
    fi       
}

dnf install nginx -y &>> $LOGS_FILE
VALIDATE $? "Installing Nginx"

dnf install mysql -y &>> $LOGS_FILE
VALIDATE $? "Installing Mysql"

dnf install nodejs &>> $LOGS_FILE
VALIDATE $? "Installing nodejs"