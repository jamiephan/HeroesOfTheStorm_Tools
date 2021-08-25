#!/bin/bash

# Update System
sudo apt update;
sudo apt dist-upgrade -y;
sudo apt upgrade -y;
sudo apt autoremove -y;
sudo apt autoclean -y;

# Install Dependencies

sudo apt-get install cmake libbz2-dev zlib1g-dev python build-essential -y;

# Clone storm-extract
cd ~
git clone https://github.com/nydus/storm-extract
cd storm-extract
git submodule init
git submodule update

# Build storm-extract
mkdir build
cd build
cmake ..
make
cd bin
sudo cp * /usr/bin/
cd ~
rm -rf storm-extract