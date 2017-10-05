# commands to switch back to cuda8 from cuda9 on ubuntu 16.04

cd Downloads

# install cuda 8
sudo sh cuda_8.0.61_375.26_linux.run --override
# Do you accept the previously read EULA?
# accept/decline/quit:    accept

# Install NVIDIA Accelerated Graphics Driver for Linux-x86_64 375.26?
# (y)es/(n)o/(q)uit: no

# Install the CUDA 8.0 Toolkit?
# (y)es/(n)o/(q)uit: yes

# Enter Toolkit Location
#  [ default is /usr/local/cuda-8.0 ]:

# Do you want to install a symbolic link at /usr/local/cuda?
# (y)es/(n)o/(q)uit: yes

# Install the CUDA 8.0 Samples?
# (y)es/(n)o/(q)uit: yes

# Enter CUDA Samples Location
#  [ default is /home/m ]:

# post install steps
#
# http://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#post-installation-actions
export PATH=/usr/local/cuda-8.0/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

# verify installation
nvcc --version
# nvcc: NVIDIA (R) Cuda compiler driver
# Copyright (c) 2005-2016 NVIDIA Corporation
# Built on Tue_Jan_10_13:22:03_CST_2017
# Cuda compilation tools, release 8.0, V8.0.61

nvidia-smi

# now let's install the patch
sudo sh cuda_8.0.61.2_linux.run

# now lets switch back to cuDNN v6.0
#
# https://askubuntu.com/questions/767269/how-can-i-install-cudnn-on-ubuntu-16-04
# http://docs.nvidia.com/deeplearning/sdk/cudnn-install/index.html

# we could install from a deb, but that doesn't seem to work
# sudo dpkg -i libcudnn6_6.0.21-1+cuda8.0_amd64.deb

# find out where your cuda install is
which nvcc
# /usr/local/cuda-8.0/bin/nvcc

# alternate installation from a tar.gz
tar -xvzf cudnn-8.0-linux-x64-v6.0.tgz
cd cuda
sudo cp -P include/cudnn.h /usr/include
sudo cp -P lib64/libcudnn* /usr/lib/x86_64-linux-gnu/
sudo chmod a+r /usr/lib/x86_64-linux-gnu/libcudnn*

# to check that the cudnn installation worked:
cat /usr/include/cudnn.h | grep CUDNN_MAJOR -A 2
