echo -n "Enter your Object Storage Access Key ID and press [ENTER]: "
read AWS_ACCESS_KEY_ID
echo "" | awk '{print $1}'
echo $AWS_ACCESS_KEY_ID > ociaccess
echo -n "Enter your Object Storage Secret Access Key and press [ENTER]: "
read AWS_SECRET_ACCESS_KEY
echo $AWS_SECRET_ACCESS_KEY >> ociaccess
echo -n "Enter your Kasten password and press [ENTER]: "
read KASTEN_USER_PASSWORD
echo $KASTEN_USER_PASSWORD >> ociaccess

clear

echo "" | awk '{print $1}'
echo "You are ready to deploy now!"
echo "" | awk '{print $1}'


