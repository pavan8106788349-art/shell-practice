
USERID = $(id -u)

if [USERID -ne 0]; then
    echo "Please run this script with root user access"
fi
echo "installing nginx"
dnf install nginx -y    

