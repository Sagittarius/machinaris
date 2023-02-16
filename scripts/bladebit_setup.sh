#!/bin/env bash
#
# Installs bladebit - A fast Chia plotter, offering disk, ram, and gpu modes.
# See https://github.com/Chia-Network/bladebit
#
# Can't acutally build on Github servers, must build on each target system 
# during container launch, otherwise get all sorts of errors.
#

BLADEBIT_BRANCH=$1

if [[ (${mode} == 'fullnode' || ${mode} =~ "plotter") && (${blockchains} == 'chia') ]]; then
    if [ ! -f /usr/bin/bladebit ] && [[ "${bladebit_skip_build}" != 'true' ]]; then
        arch_name="$(uname -m)"
        if [[ "${arch_name}" = "x86_64" ]] || [[ "${arch_name}" = "arm64" ]]; then
            apt update && apt install -y build-essential cmake libgmp-dev libnuma-dev
            cd /
            echo "Cloning bladebit from https://github.com/Chia-Network/bladebit.git on branch:${BLADEBIT_BRANCH}"
            git clone --recursive --branch ${BLADEBIT_BRANCH} https://github.com/Chia-Network/bladebit.git
            cd /bladebit && echo "Building bladebit on ${arch_name}..."
            mkdir -p build && cd build
            cmake ..
            cmake --build . --target bladebit --config Release
            ln -s /bladebit/build/bladebit /usr/bin/bladebit
            cd / && echo "Bladebit version: "`bladebit --version`
        else
            echo "Building bladebit skipped -> unsupported architecture: ${arch_name}"
        fi
    fi
fi
