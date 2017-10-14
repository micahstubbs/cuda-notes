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

# >>> import tensorflow as tf
# >>> hello = tf.constant('Hello, TensorFlow!')
# >>> sess = tf.Session()
# 2017-10-04 21:26:44.834460: W tensorflow/core/platform/cpu_feature_guard.cc:45] The TensorFlow library wasn't compiled to use SSE4.1 instructions, but these are available on your machine and could speed up CPU computations.
# 2017-10-04 21:26:44.834498: W tensorflow/core/platform/cpu_feature_guard.cc:45] The TensorFlow library wasn't compiled to use SSE4.2 instructions, but these are available on your machine and could speed up CPU computations.
# 2017-10-04 21:26:44.834518: W tensorflow/core/platform/cpu_feature_guard.cc:45] The TensorFlow library wasn't compiled to use AVX instructions, but these are available on your machine and could speed up CPU computations.
# 2017-10-04 21:26:44.834533: W tensorflow/core/platform/cpu_feature_guard.cc:45] The TensorFlow library wasn't compiled to use AVX2 instructions, but these are available on your machine and could speed up CPU computations.
# 2017-10-04 21:26:44.834548: W tensorflow/core/platform/cpu_feature_guard.cc:45] The TensorFlow library wasn't compiled to use FMA instructions, but these are available on your machine and could speed up CPU computations.
# 2017-10-04 21:26:44.882615: E tensorflow/stream_executor/cuda/cuda_driver.cc:406] failed call to cuInit: CUDA_ERROR_UNKNOWN
# 2017-10-04 21:26:44.882714: I tensorflow/stream_executor/cuda/cuda_diagnostics.cc:158] retrieving CUDA diagnostic information for host: m-GA-990FXA-UD3
# 2017-10-04 21:26:44.882736: I tensorflow/stream_executor/cuda/cuda_diagnostics.cc:165] hostname: m-GA-990FXA-UD3
# 2017-10-04 21:26:44.882824: I tensorflow/stream_executor/cuda/cuda_diagnostics.cc:189] libcuda reported version is: 384.81.0
# 2017-10-04 21:26:44.882880: I tensorflow/stream_executor/cuda/cuda_diagnostics.cc:369] driver version file contents: """NVRM version: NVIDIA UNIX x86_64 Kernel Module  384.81  Sat Sep  2 02:43:11 PDT 2017
# GCC version:  gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.4)
# """
# 2017-10-04 21:26:44.882931: I tensorflow/stream_executor/cuda/cuda_diagnostics.cc:193] kernel reported version is: 384.81.0
# 2017-10-04 21:26:44.882948: I tensorflow/stream_executor/cuda/cuda_diagnostics.cc:300] kernel version seems to match DSO: 384.81.0

nvidia-debugdump -l
# Found 1 NVIDIA devices
#         Device ID:              0
#         Device name:            GeForce GTX 1080   (*PrimaryCard)
#         GPU internal ID:        GPU-317aeb22-e67c-fc01-1c11-55d6f2d6094a

sudo apt-get install nvidia-modprobe