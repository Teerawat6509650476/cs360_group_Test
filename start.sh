#!/bin/bash

#Define
base_path=$(pwd)
echo "$base_path"

# อัปเดต package lists และติดตั้ง curl
echo "อัปเดต package lists..."
if command -v apt &> /dev/null; then
    echo "This system uses apt"
    sudo apt update && sudo apt upgrade -y
elif command -v yum &> /dev/null; then
    echo "This system uses yum"
    sudo yum check-update || sudo yum update -y
else
    echo "Unsupported package manager"
fi

if command -v curl &> /dev/null; then
    echo "curl is already installed."
else
    echo "curl is not installed. Installing..."
    sudo yum install -y curl
fi

publicIPv4=$(curl ipinfo.io/ip)

install_git(){
    sudo yum install git
}

install_nvm(){
    echo "Installing NodeJs V.16"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
    source ~/.bashrc
    nvm install 16
    nvm use 16
}

# NodeJs Check
if command -v node &> /dev/null; then
    echo "NodeJs is already installed. Node: $(node -v), npm: $(npm -v)"
else
    echo "NodeJs is not installed. Installing NodeJs..."
    install_nvm
    if command -v node &> /dev/null; then
        echo "NodeJs installed successfully. Node: $(node -v)"
    else
        echo "NodeJs installation failed. Exiting."
        exit 1
    fi
fi

# Git Check
if command -v git &> /dev/null; then
    echo "Git is already installed. Git: $(git --version)"
else
    echo "Git is not installed. Installing Git..."
    install_git
    if command -v git &> /dev/null; then
        echo "Git installed successfully. Git: $(git --version)"
    else
        echo "Git installation failed. Exiting."
        exit 1
    fi
fi

# pm2 Check
if command -v pm2 &> /dev/null; then
    echo "pm2 is already installed."
else
    echo "pm2 is not installed. Installing pm2..."
    npm install -g pm2
    if command -v pm2 &> /dev/null; then
        echo "pm2 installed successfully."
    else
        echo "pm2 installation failed. Exiting."
        exit 1
    fi
fi

# yarn Check
if command -v yarn &> /dev/null; then
    echo "yarn is already installed."
else
    echo "yarn is not installed. Installing yarn..."
    npm install -g yarn
    if command -v yarn &> /dev/null; then
        echo "yarn installed successfully."
    else
        echo "yarn installation failed. Exiting."
        exit 1
    fi
fi

source ~/.bashrc

path_api=$base_path/api/
path_client=$base_path/client/

cd $path_api
yarn

echo -e "HOST=0.0.0.0\nPORT=1337\nSTRAPI_ADMIN_CLIENT_URL=http://${publicIPv4}:3000\nSTRAPI_ADMIN_CLIENT_PREVIEW_SECRET=ARNFCb9zrC9ZHm5hZzCigWivD40icS4s" > .env
cat .env > logs.txt
yarn seed


echo "Starting Strapi..."
pm2 start yarn --name Strapi_Api -- start

cd $path_client

yarn
echo -e "NEXT_PUBLIC_API_URL=http://${publicIPv4}:1337\nPREVIEW_SECRET=ARNFCb9zrC9ZHm5hZzCigWivD40icS4s" > .env

echo "Build NextJS..."
yarn build
echo "Starting Client..."
pm2 start yarn --name client -- start

echo "Deploy Success"
