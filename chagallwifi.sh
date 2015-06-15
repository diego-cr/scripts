#!/bin/bash
sed -i -e 's/ezio84/diegocr/g' vendor/slim/config/common.mk

./build_rom.sh chagallwifi nosync 5 clean

mv ./out/target/product/chagallwifi/Slim.diegocr* ./1SlimLP




