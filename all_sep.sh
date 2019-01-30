
echo "making logcat, 10 seconds"
timeout 10 adb logcat | grep avc > log.txt
adb shell dmesg |grep avc >> log.txt                                                                                                                                                   

. build/envsetup.sh

lunch aicp_sagit-userdebug
external/selinux/prebuilts/bin/audit2allow -p out/target/product/sagit/root/sepolicy < log.txt > sep.txt

path="device/xiaomi/msm8998-common/sepolicy/"
#remove blank lines
sed '/^[[:space:]]*$/d' sep.txt > .sep.tmp

lines=$(wc -l < .sep.tmp)

while [ $lines != 0 ];
do
#remove 2 ###########
sed '0,/#============= /s///' .sep.tmp > .sep1.tmp
sed '0,/ ==============/s///' .sep1.tmp > .sep2.tmp
#all before #=========
sed -e '/#=========/,$d' .sep2.tmp > .sep1.tmp

#get file name and add .te
name=$(head -n 1 .sep1.tmp)
name="${name}.te"
echo $name
name="${path}${name}"
echo $name

#remove first line
tail -n +2 .sep1.tmp >> .sepf.tmp
#remove duplicates
sort -u .sepf.tmp >> $name

rm .sep1.tmp
rm .sep2.tmp
rm .sepf.tmp

#remove first line with ==============
sed -e '0,/==============/d' .sep.tmp > .sep1.tmp
#remove all before #======
sed -n -e '/#=======/,$p' .sep1.tmp > .sep.tmp

clean="$name.c"
awk '!seen[$0]++' $name  > $clean
mv $clean $name

#conut lines
lines=$(wc -l < .sep.tmp)
done

rm .sep.tmp

#banned
path="${path}*"
sed -i /adbtcp_prop/d $path
sed -i /hal_allocator_default/d $path
sed -i /init:process/d $path
sed -i /statsd/d $path
sed -i /storaged/d $path
sed -i /recovery_prop/d $path

