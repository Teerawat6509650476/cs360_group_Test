# CS360 1/2567 Term Project: [FoodAdvisor]

## Group Information

  
- **Group Name:** [SaveToFocus]

  Test

## Members

| Name | Student ID |
|--|--|
|Natthida Sae-tang |6509650070|
|Teerawat Nakornchai |6509650476|
|Napat Thaibankuai |6509650492|
|Punnatut Maneewong |6509650542|
|Wuttipat Pipopsukawadee |6509650716|

## Project Goal

The goal of this project is to study deployment processes and automate 10 tests. the project will focus on enhancing and developing new features. that system can be deployed and accessed externally.

### Features CRUD

- [Feature 1: Register and Authentication]  
- [Feature 2: Profile]  


### Technologies Used  
- **Backend:** Strapi V4  
- **Frontend:** React.js  
- **Hosting/Deployment:** AWS EC2  
- **Database:** SQLite

### Software Require 
- Node 16
- npm >=6.0.0
- yarn 1.22.22
- pm2 v.5.4.2
- git

## Setup AWS EC2 Instance

1.  **Launch `AWS EC2` Instance**:

    -  **Instance Type**: t2.medium

    -  **Operating System**: Amazon Linux

  

2.  **Configure Security Group Rules**:

    -  **Type**: `SSH`, **Protocol**: `TCP`, **Port Range**: `22`, **Source**: `::/0`

    -  **Type**: `HTTP`, **Protocol**: `TCP`, **Port Range**: `80`, **Source**: `0.0.0.0/0, ::/0`

    -  **Type**: `HTTPS`, **Protocol**: `TCP`, **Port Range**: `443`, **Source**: `0.0.0.0/0, ::/0`

    -  **Type**: `Custom TCP Rule`, **Protocol**: `TCP`, **Port Range**: `1337`, **Source**: `0.0.0.0/0`

    -  **Type**: `Custom TCP Rule`, **Protocol**: `TCP`, **Port Range**: `3000`, **Source**: `0.0.0.0/0`


## How to deploy and run the project manually

## Step-by-Step Guide
- Use `sudo yum check-update || sudo yum update -y` For Update (use other, If you use other OS)
- Use `sudo yum install git` If Your System Not have git


### 1. Install NVM (Node Version Management) on the AWS Instance ( Use other If you want )
- Install nvm, then install node 16 by nvm :
```bash

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash 
		
source ~/.bashrc
		
nvm install 16
		
nvm use 16
		
node -v

```

### 2. Install yarn on the AWS Instance
- Install yarn global by npm :
```bash

npm install -g yarn@1.22.22

```

### 3. Install pm2 on the AWS Instance
- Install pm2 by npm : 
```bash

npm install -g pm2@5.4.2

```

### 4. Setup environment

cd into `cs360_group` folder. `cd cs360_group`

* Strapi **Backend** :

	- use `curl ipinfo.io/ip` for get **PublicIPv4**
	- use `openssl rand -base64  32` For **STRAPI_ADMIN_CLIENT_PREVIEW_SECRET**
	- use `openssl rand -base64 16` For **JWT_SECRET**
```bash
# Create & Edit .env File (Backend)
nano  api/.env
```
```bash
# Copy The following into .env

NODE_ENV=production
HOST=0.0.0.0
PORT=1337
STRAPI_ADMIN_CLIENT_URL=http://<public IPv4 of the EC2 instance>:3000
STRAPI_ADMIN_CLIENT_PREVIEW_SECRET=<your srcret>
JWT_SECRET=<your secret>
# Ctrl+o > Enter > Ctrl+x. For Save File.
```

* NextJs **FontEnd** :
	- use `openssl rand -base64 32` For **PREVIEW_SECRET**
```bash
# Create & Edit .env File (FontEnd)
nano  client/.env
```
```bash
# Copy The following into .env
NEXT_PUBLIC_API_URL=http://<public  IPv4  of  the  EC2  instance>:1337
PREVIEW_SECRET=<your  Secret>
```

### 5. Start Project
- **Backend** 
```bash

#cd into api folder (backend)
cd api
			
# install Libs
yarn & yarn seed

# pm2 runtime
pm2 start yarn --name Backend -- start

```
- **Fontend** 
```bash

#cd into client folder (fontend)
cd ../client
			
# install Libs
yarn & yarn build

# pm2 runtime
pm2 start yarn --name Fontend -- start

```
> Use `pm2 list` for List Process
> Use `pm2 stop <name>`for Stop Process
> Use `pm2 del <name>` for Delete Process
 
### Strapi User Roles and Access
#### Super Admin
- **Email:** `admin@strapidemo.com`
- **Password:** `welcomeToStrapi123`

#### Editor
- **Email:** `editor@strapidemo.com`
- **Password:** `welcomeToStrapi123`

#### Author
- **Email:** `author@strapidemo.com`
- **Password:** `welcomeToStrapi123`

## How to deploy and run the project using the provided bash script [Specify the bash script path in the repo]

  
## Step-by-Step Guide

  

### 1. Install Git on the AWS Instance

- First, update the system packages:

```bash

sudo yum update -y

```

- Then, install Git:

```bash

sudo yum install git -y

```

  

### 2. Clone the Repository from GitHub

- Clone the repository using `git clone`:

```bash

git clone https://github.com/wuttipat6509650716/cs360_group.git

```

- Navigate into the cloned project directory:

```bash

cd cs360_group

```

  

### 3. Check the Permissions of `start.sh`

- Verify if the `start.sh` script has execute permissions:

```bash

ls -l start.sh

```

- If the script does not have execute permissions, grant it using the following command:

```bash

chmod +x start.sh

```

  

### 4. Run the `start.sh` Script

- Execute the script to deploy and run the project:

```bash

./start.sh

```

[ภาพ screen capture ของหนาเว็บแอปพลิเคชันซึ่ง deploy ไวบน EC2]
![Screen capture](https://media.discordapp.net/attachments/996073868768850002/1286932089958174760/image.png?ex=66efb468&is=66ee62e8&hm=69cac61d75e5500624b226f38e6c00a60a03f7e96880f09f24769c927eca3b7e&=&format=webp&quality=lossless&width=1514&height=946)

