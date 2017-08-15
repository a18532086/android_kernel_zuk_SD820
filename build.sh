#!/bin/bash
export CONFIG_FILE="ZLYJ_z2_plus_defconfig"
export TOOL_CHAIN_PATH="/home/a18532086/Downloads/gcc-linaro-7.1.1-2017.08-rc1-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-"
export objdir="../out"
compile() {
  mkdir ../out
  make O=$objdir $CONFIG_FILE -j4 
  make O=$objdir -j8
}
module(){
  cd ../out
  mkdir modules
  find . -name '*.ko' -exec cp -av {} modules/ \;
  # strip modules 
  ${TOOL_CHAIN_PATH}strip --strip-unneeded modules/*
  #mkdir modules/qca_cld
  #mv modules/wlan.ko modules/qca_cld/qca_cld_wlan.ko
}
dtbuild(){
  ./tools/dtbToolCM -2 -o $objdir/arch/arm64/boot/dt.img -s 4096 -p $objdir/scripts/dtc/ $objdir/arch/arm64/boot/dts/
}
#complie
module
#dtbuild
#cp $objdir/arch/arm64/boot/zImage $sourcedir/zImage
#cp $objdir/arch/arm64/boot/dt.img.lz4 $sourcedir/dt.img
