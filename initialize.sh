#! /bin/bash

# git name "d!sPl4Y"

# Update the system
#sudo apt-get update
#sudo apt-get upgrade
#sudo apt install curl git

# Setup Dropbox Uploader
sudo chmod +X dropbox_uploader.sh
./dropbox_uploader.sh
echo ""

# Setup display
echo "Specify the site name: "
read site_name

echo -ne "\n > The site name is $site_name. Looks ok? [y/N]: "
read -r answer
if [[ $answer != "y" ]]; then
    echo "Specify the site name: "
    read site_name
fi

mkdir ./remote
mkdir ./local
./dropbox_uploader.sh list $site_name > ./remote/files.txt
./dropbox_uploader.sh -s download $site_name ./remote

rm -fR ./local/*
mv ./remote/$site_name ./local
cp ./remote/files.txt ./local

sudo sh -c "echo @vlc --fullscreen --loop /home/pi/d!sPl4Y/local/$site_name/ --no-video-title-show >> /etc/xdg/lxsession/LXDE-pi/autostart"


# Build custom script
touch file_check.sh
echo "#! /bin/bash" > ./file_check.sh
echo "site_name=$site_name" >> ./file_check.sh
cat raw_script.txt >> ./file_check.sh

# Add cron job for checks
