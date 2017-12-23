#!/system/bin/sh
BB=/sbin/busybox;
echo "[AK] Boot Script Started" | tee /dev/kmsg

# Mount root as RW to apply tweaks and settings Start
$BB mount -o remount,rw /
$BB mount -o rw,remount /system

sleep 10

#Kcal
echo 280 > /sys/devices/platform/kcal_ctrl.0/kcal_sat
echo 248 > /sys/devices/platform/kcal_ctrl.0/kcal_val
echo 269 > /sys/devices/platform/kcal_ctrl.0/kcal_cont
echo 256 254 256 > /sys/devices/platform/kcal_ctrl.0/kcal

sleep 2

#Scheduler
echo row > /sys/block/mmcblk0/queue/scheduler
echo 1024 > /sys/block/mmcblk0/bdi/read_ahead_kb

sleep 2

#Selinux
setenforce 0

sleep 5

#Build.prop
echo "ro.media.dec.jpeg.memcap=20000000" >> /system/build.prop
echo "ro.media.enc.hprof.vid.bps=8000000" >> /system/build.prop
echo "ro.media.enc.jpeg.quality=100" >> /system/build.prop
echo "net.rmnet0.dns1=8.8.8.8" >> /system/build.prop
echo "net.rmnet0.dns2=9.9.9.9" >> /system/build.prop
echo "net.dns1=8.8.8.8" >> /system/build.prop
echo "net.dns2=9.9.9.9" >> /system/build.prop
echo "dalvik.vm.heapgrowthlimit=128m" >> /system/build.prop
echo "dalvik.vm.heapsize=256m" >> /system/build.prop

sleep 2

# Wireless Speed Tweaks
setprop net.tcp.buffersize.default 4096,87380,256960,4096,16384,256960
setprop net.tcp.buffersize.wifi 4096,87380,256960,4096,16384,256960
setprop net.tcp.buffersize.umts 4096,87380,256960,4096,16384,256960
setprop net.tcp.buffersize.gprs 4096,87380,256960,4096,16384,256960
setprop net.tcp.buffersize.edge 4096,87380,256960,4096,16384,256960
echo row > /sys/block/mmcblk0/queue/scheduler

#Finish
echo "[AK] Exiting post-boot script" | tee /dev/kmsg
