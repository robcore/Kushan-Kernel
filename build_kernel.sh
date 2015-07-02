#!/bin/bash
# Kushan-Kernel Build Script
# Copyright (C) Kushan

#vars
KERNEL_DIR=$(pwd)
DATE="`date +"%d-%m-%Y"`"
BUILD_JOB_NUMBER=`grep processor /proc/cpuinfo|wc -l`
OUTPUT=BUILD_$DATE

make clean
mkdir $KERNEL_DIR/BUILD_$DATE
mkdir $KERNEL_DIR/BUILD_$DATE/modules
export ARCH=arm
export USE_SEC_FIPS_MODE=true
export CROSS_COMPILE=/home/kushan/toolchain_linaro/bin/arm-eabi-
export ccache=ccache
# export ENABLE_GRAPHITE=true
make VARIANT_DEFCONFIG=jf_eur_defconfig kushan_defconfig SELINUX_DEFCONFIG=selinux_defconfig
make -j$BUILD_JOB_NUMBER
cp -r $KERNEL_DIR/arch/arm/boot/zImage $OUTPUT/zImage
find . -name "*.ko" -exec cp {} $OUTPUT/modules/ \;
