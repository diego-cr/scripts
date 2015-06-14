#!/bin/bash

# Time of build startup
res1=$(date +%s.%N)

sed -i -e 's/ezio84/diegocr/g' vendor/slim/config/common.mk

echo
#echo "change cm to slim"
#cp  device/samsung/chagallwifi/cm.mk device/samsung/chagallwifi/slim.mk
#cp  device/samsung/chagallwifi/cm.dependencies device/samsung/chagallwifi/slim.dependencies
#sed -i -e 's/cm/slim/g' device/samsung/chagallwifi/slim.mk

#echo
#echo "remove overlays"
#sed -i '/config_deviceHardwareWakeKeys/d' device/samsung/chagallwifi/overlay/frameworks/base/core/res/res/values/config.xml
#rm device/samsung/chagallwifi/overlay/frameworks/base/core/res/res/values/cm_arrays.xml

echo
echo "patch media codecs"
patch -N -p1 <device/samsung/chagallwifi/patches/OMX-google-ffmpeg.diff

export IS_RELEASED_BUILD=true
export USE_CCACHE=1
/usr/bin/ccache -M 50G

echo
echo building
#. build/envsetup.sh
#breakfast chagallwifi
#brunch chagallwifi

#./build_rom.sh chagallwifi nosync 5 noclean
./build_rom.sh chagallwifi nosync 5 clean

echo
echo "repacking..."
echo
#cd repackrom
#./repack.sh ../out/target/product/chagallwifi/Slim.diegocr*.zip 
#cd ..
mv ./out/target/product/chagallwifi/Slim.diegocr* ./1SlimLP

# Get elapsed time
echo
res2=$(date +%s.%N)
echo "${bldgrn}Total time elapsed: ${txtrst}${grn}$(echo "($res2 - $res1) / 60"|bc ) minutes ($(echo "$res2 - $res1"|bc ) seconds) ${txtrst}"
echo



