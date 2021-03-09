rm -rf build_host
cmake -Bbuild_host -DCUDA_ARCH_BIN=7.5 -DCUDA_ARCH_PTX=7.5 -DCMAKE_CUDA_COMPILER=/usr/local/cuda-11.0/bin/nvcc -DWITHGPU=ON
cmake --build build_host