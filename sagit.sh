rm out/target/product/sagit/system/build.prop

export USER_BUILD_NO_CHANGELOG=1

. build/envsetup.sh

lunch aicp_sagit-userdebug
make installclean
brunch sagit


