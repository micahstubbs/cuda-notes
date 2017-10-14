# http://forums.fast.ai/t/making-your-own-server/174/272
# I reinstalled fully twice and was crashing out with the same errors as you were getting.

# I installed 16.04 server.
# then used the standard instructions here https://github.com/fastai/courses/blob/master/setup/install-gpu.sh

# Except I used cuda 6.0.20 and it was crashing.

# The last two steps which fixed it were:
# Use the instructions here to setup libguparray http://deeplearning.net/software/libgpuarray/installation.html1
# extract/clone the source to a directory
# For libgpuarray:

cd directory
mkdir Build
cd Build
cmake .. -DCMAKE_BUILD_TYPE=Release # or Debug if you are investigating a crash
make
make install
cd ..

# Then change the .theanorc - here is mine:
[global]
device = cuda
floatX = float32

[cuda]
root = /usr/local/cuda

# Finally install pygpu
conda install pygpu

# that worked for me.

# Sorry for the formatting. MD is not working very well in this message