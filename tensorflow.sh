# this guide
# https://www.tensorflow.org/install/install_linux#nvidia_requirements_to_run_tensorflow_with_gpu_support 
sudo apt-get install libcupti-dev

conda uninstall tensorflow
conda install tensorflow-gpu  

# The following NEW packages will be INSTALLED:

#     cudatoolkit:         8.0-1
#     cudnn:               6.0.21-cuda8.0_0
#     tensorflow-gpu:      1.3.0-0
#     tensorflow-gpu-base: 1.3.0-py27cuda8.0cudnn6.0_0

# should I worry about installing cudnn again? 
# maybe it's just a python wrapper?

# test GPU support in tensorflow
python
import tensorflow as tf
sess = tf.Session(config=tf.ConfigProto(log_device_placement=True))

# ok that didn't work - 
# Device mapping: no known devices.

# let's try to build tensorflow-gpu from source
# https://www.tensorflow.org/install/install_sources

 bazel build --config=opt --config=cuda //tensorflow/tools/pip_package:build_pip_package --cxxopt="-D_GLIBCXX_USE_CXX11_ABI=0"

 # this bugfix helped
 # https://gist.github.com/taylorpaul/3e4e405ffad1be8355bf742fa24b41f0#getting-past-gblicxx_3418-error

# install the python whl package we just created
 sudo -H pip install /tmp/tensorflow_pkg/tensorflow-1.3.0-cp27-cp27mu-linux_x86_64.whl