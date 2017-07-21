#!/bin/sh -e

apt-get -y install cmake libssl-dev libffi-dev python-pip
wget https://github.com/libgit2/libgit2/archive/v0.25.0.tar.gz
tar xfz v0.25.0.tar.gz
cd libgit2-0.25.0/
cmake .
make
sudo make install
ldconfig
pip install pygit2==0.25.0

