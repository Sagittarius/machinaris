#!/bin/env bash
#
# Installs Madmax plotters from his binary repository
#

# MMX Plotter binaries, https://github.com/madMAx43v3r/chia-gigahorse
MADMAX_BRANCH=$1

# MMX blockchain container gets the "new" Madmax plotters, with compression, only available as binaries
if [[ (${mode} == 'fullnode' || ${mode} =~ "plotter") && (${blockchains} == 'mmx' || ${blockchains} == 'chia' || ${blockchains} == 'chives') ]]; then
    if [ ! -f /usr/bin/chia_plot ] && [[ "${madmax_skip_build}" != 'true' ]]; then
        arch_name="$(uname -m)"
        if [[ "${arch_name}" = "x86_64" ]]; then
            pushd /usr/bin
            curl -sLJO https://github.com/madMAx43v3r/chia-gigahorse/raw/${MADMAX_BRANCH}/cpu-plotter/linux/x86_64/chia_plot
            curl -sLJO https://github.com/madMAx43v3r/chia-gigahorse/raw/${MADMAX_BRANCH}/cpu-plotter/linux/x86_64/chia_plot_k34
            chmod 755 chia_plot*
            curl -sLJO https://github.com/madMAx43v3r/chia-gigahorse/raw/${MADMAX_BRANCH}/cuda-plotter/linux/x86_64/cuda_plot_k26
            curl -sLJO https://github.com/madMAx43v3r/chia-gigahorse/raw/${MADMAX_BRANCH}/cuda-plotter/linux/x86_64/cuda_plot_k29
            curl -sLJO https://github.com/madMAx43v3r/chia-gigahorse/raw/${MADMAX_BRANCH}/cuda-plotter/linux/x86_64/cuda_plot_k30
            curl -sLJO https://github.com/madMAx43v3r/chia-gigahorse/raw/${MADMAX_BRANCH}/cuda-plotter/linux/x86_64/cuda_plot_k31
            curl -sLJO https://github.com/madMAx43v3r/chia-gigahorse/raw/${MADMAX_BRANCH}/cuda-plotter/linux/x86_64/cuda_plot_k32
            curl -sLJO https://github.com/madMAx43v3r/chia-gigahorse/raw/${MADMAX_BRANCH}/cuda-plotter/linux/x86_64/cuda_plot_k33
            chmod 755 cuda_plot*
            curl -sLJO https://github.com/madMAx43v3r/chia-gigahorse/raw/${MADMAX_BRANCH}/chiapos/linux/x86_64/ProofOfSpace
            chmod 755 ProofOfSpace
            popd
            echo "Completed download of Madmax binaries for plotting:"
            echo "chia_plot @ "`chia_plot --version`
            echo "cuda_plot @ "`cuda_plot_k32 --version`
        else
            echo "Downloading MMX chia_plot and cuda_plot skipped -> unsupported architecture: ${arch_name}"
        fi
    fi
fi
