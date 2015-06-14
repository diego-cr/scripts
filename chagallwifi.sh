#!/bin/bash

# Time of build startup
res1=$(date +%s.%N)

sed -i -e 's/ezio84/diegocr/g' vendor/slim/config/common.mk


echo
echo "patch media codecs"
patch -N -p1 <device/samsung/chagallwifi/patches/OMX-google-ffmpeg.diff

export IS_RELEASED_BUILD=true
export USE_CCACHE=1
/usr/bin/ccache -M 50G

echo
echo building

./build_rom.sh chagallwifi nosync 5 clean

mv ./out/target/product/chagallwifi/Slim.diegocr* ./1SlimLP

# Get elapsed time
echo
res2=$(date +%s.%N)
echo "${bldgrn}Total time elapsed: ${txtrst}${grn}$(echo "($res2 - $res1) / 60"|bc ) minutes ($(echo "$res2 - $res1"|bc ) seconds) ${txtrst}"
echo



