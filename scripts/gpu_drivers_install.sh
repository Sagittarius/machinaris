#!/bin/export bash
#
# Installs GPU drivers for AMD.  Nvidia drivers are from the base image in dockerfile-jammy.base
#

arch_name="$(uname -m)"
ubuntu_ver=`lsb_release -r -s`
echo "Installing GPU drivers on ${arch_name} for ${ubuntu_ver}..."

# Install dependencies for GPU support of OpenCL
apt update && apt install -y git cmake build-essential ocl-icd-opencl-dev clinfo screen initramfs-tools ocl-icd-libopencl1 opencl-headers libnuma1

# For AMDGPU, install the amdgpu-install stub, optionally invoked later if OPENCL_GPU=amd at launch time
amd_deb=$(curl -s http://repo.radeon.com/amdgpu-install/latest/ubuntu/jammy/ | grep -m 1 -Po "amdgpu-install_[-\.\d]+_all.deb" | head -1)
curl -O http://repo.radeon.com/amdgpu-install/latest/ubuntu/jammy/${amd_deb}
apt install -y ./${amd_deb}
apt install -y radeontop
