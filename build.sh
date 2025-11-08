#!/bin/bash
set -e
# It's easier to refer to the script's original location and I'll use the home variable as the ~/ shortcut don't work on my system in the path variable and other issues.
export SCRIPT_RAN_FROM_DIR=$PWD

## Clean up first, want an if-exist here as I don't want to accidentally rmrfrootlol some poor persons system like I once did to myself,
## also I could try the self-rerun trick I did 2014 but have a check root.
# sudo rm -rf $HOME/.local/var/pmbootstrap
# rm -rf out
# rm -rf pmbootstrap

# Git identity, not needed I don't think... didn't make git break for me.
# git config --global user.email "example@example.com"
# git config --global user.name "Nonta72"

# Replace placeholders in .cfg files, checked and this really is needed during my line by line debug.
find . -type f -name "*.cfg" -exec sed -i "s|HOME|$(echo $HOME)|;s|NPROC|$(nproc)|" {} +

# Setup environment
export KERNEL_BRANCH=danila/spacewar-testing

# Install pmbootstrap from Git
git clone https://gitlab.postmarketos.org/postmarketOS/pmbootstrap.git --depth 1
mkdir -p $HOME/.local/bin
export PATH="$PATH:$HOME/.local/bin"
# really need an if-exist here, can't just have loose rm's evrywhere, made that mistake once, paranoid of them since ._.
# sudo rm $HOME/.local/bin/pmbootstrap
ln -s "$PWD/pmbootstrap/pmbootstrap.py" $HOME/.local/bin/pmbootstrap
pmbootstrap --version

# Init, bruv
echo -e '\n\n' | pmbootstrap init || true
cd $HOME/.local/var/pmbootstrap/cache_git/pmaports

# Kernel branch setup
export DEFAULT_BRANCH=danila/spacewar-mr
git remote add sc7280 https://github.com/mainlining/pmaports.git
git fetch sc7280 $DEFAULT_BRANCH
git reset --hard sc7280/$DEFAULT_BRANCH
export DEFAULT_BRANCH=danila/spacewar-testing
echo "Default branch is $DEFAULT_BRANCH"
git clone https://github.com/mainlining/linux.git --single-branch --branch $KERNEL_BRANCH --depth 1

# Copy config to pmbootstrap
cp $SCRIPT_RAN_FROM_DIR/nothing-spacewar.cfg $HOME/.config/pmbootstrap_v3.cfg

# Compile kernel image
cd linux
shopt -s expand_aliases
source $SCRIPT_RAN_FROM_DIR/pmbootstrap/helpers/envkernel.sh
make defconfig sc7280.config
make -j$(nproc)
pmbootstrap build --envkernel linux-postmarketos-qcom-sc7280

# Build pmos images, failed here, but doesn't look like script issue
echo building images
cp $SCRIPT_RAN_FROM_DIR/nothing-spacewar.cfg $HOME/.config/pmbootstrap.cfg
pmbootstrap install --password 1114

# Export build images to outdir
echo exporting images
pmbootstrap export
mkdir $SCRIPT_RAN_FROM_DIR/out

cp /tmp/postmarketOS-export/boot.img $SCRIPT_RAN_FROM_DIR/out/boot-nothing-spacewar.img
cp /tmp/postmarketOS-export/nothing-spacewar.img $SCRIPT_RAN_FROM_DIR/out/rootfs-nothing-spacewar.img
tar -c -I 'xz -9 -T0' -f $SCRIPT_RAN_FROM_DIR/out/Spacewar_pmos.tar.xz $SCRIPT_RAN_FROM_DIR/out/rootfs-nothing-spacewar.img $SCRIPT_RAN_FROM_DIR/out/boot-nothing-spacewar.img
echo -e "n\nn\ny\n" | pmbootstrap zap
