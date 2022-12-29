#!/usr/bin/env bash
# A bash script that setsup a  web servers for the deployment of web_static

#install nginx
sudo apt-get update
sudo apt-get -y install nginx
sudo ufw allow 'Nginx HTTP'

# creating all the necessary directories and file
sudo mkdir -p /data/
sudo mkdir -p /data/web_static/
sudo mkdir -p /data/web_static/releases/
sudo mkdir -p /data/web_static/shared/
sudo mkdir -p /data/web_static/releases/test/
sudo touch /data/web_static/releases/test/index.html

sudo echo "<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>" | sudo tee /data/web_static/releases/test/index.html

#  check if the current directory exits and remove it
if [ -d "/data/web_static/current" ]
then
        sudo rm -rf /data/web_static/current
fi
# Create a symbolic link to test
ln -sf /data/web_static/releases/test/ /data/web_static/current

# change ownership to  ubuntu
sudo chown -hR ubuntu:ubuntu /data/

# Configure nginx to serve content pointed to by symbolic link to hbnb_static
sudo sed -i '/listen 80 default_server/a location /hbnb_static { alias /data/web_static/current/;}' /etc/nginx/sites-enabled/default

# Restart server
sudo service nginx restart
