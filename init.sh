#!/bin/bash

echo "Update..."
sudo apt update --fix-missing
sudo apt dist-upgrade -y
sudo apt autoremove -y

echo "Installing Nvidia driver (Assumption: 384 supported)..."
sudo apt install -y curl nvidia-384 nvidia-cuda-toolkit
nvcc --version
echo "Successfully done."

echo "Installing Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update --fix-missing

sudo apt-get install --yes docker-ce
sudo rm -rf /var/lib/docker/aufs
sudo apt-get install --yes -f

sudo service docker start
echo "Successfully done."

echo "Installing nvidia-docker2..."
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | \
sudo apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \
sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update
sudo apt install -y nvidia-docker2
