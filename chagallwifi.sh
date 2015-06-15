#!/bin/bash
sed -i -e 's/ezio84/diegocr/g' vendor/slim/config/common.mk

export IS_RELEASED_BUILD=true
export USE_CCACHE=1
/usr/bin/ccache -M 50G

echo
echo building

./build_rom.sh chagallwifi nosync 5 clean

mv ./out/target/product/chagallwifi/Slim.diegocr* ./1SlimLP




