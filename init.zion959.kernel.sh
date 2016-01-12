#!/system/bin/sh
#--------------------------------------------------
# ZION959- generated kernel options init script
#--------------------------------------------------

log_file="/data/kernel-boot.log"

echo "----------------------------------------------------" >$log_file
echo "ZION959- execution of kernel options init script" >>$log_file
echo "----------------------------------------------------" >>$log_file
echo "Kernel version : `uname -a`" >>$log_file
echo "Toybox used   : `which toybox`" >>$log_file

echo `date +"%F %R:%S : Checking for ZION959 kernel..."` >>$log_file

if [ "`uname -r | grep ZION959`" == "" ]
  then
    echo `date +"%F %R:%S : No zion959 kernel found, skip executing the config file"` >>$log_file
    exit
fi;

echo `date +"%F %R:%S : ZION959 kernel found, continue executing the config file..."` >>$log_file

echo `date +"%F %R:%S : Waiting for Android to start..."` >>$log_file

# Wait until we see some android processes to consider boot is more or less complete (credits to AndiP71)
while ! pgrep com.android ; do
  sleep 1
done

echo `date +"%F %R:%S : Android is starting up, let's wait another 30 seconds..."` >>$log_file

# Now that is checked, let's just wait another tiny little bit
sleep 30

echo `date +"%F %R:%S : Starting kernel configuration..."` >>$log_file

#----------------------------------------------------

# - SELinux Enforcing
setenforce 0
echo `date +"%F %R:%S : SELinux set to enforcing."` >>$log_file

# - init.d support by kernel/ramdisk not installed
echo `date +"%F %R:%S : Init.d script execution support disabled."` >>$log_file
ls -al /system/etc/init.d >>$log_file

# init.d
chmod 755 /system/etc/init.d/ -R
if [ ! -d /system/etc/init.d ]; then
mkdir -p /system/etc/init.d/;
chown -R root.root /system/etc/init.d;
chmod 777 /system/etc/init.d/;
else
/sbin/toybox run-parts /system/etc/init.d

# Set Userspace DVFS access to ignore
echo 0 > /sys/kernel/cpufreq_hardlimit/userspace_dvfs_lock
echo `date +"%F %R:%S : Userspace DVFS access set to ignore."` >>$log_file

# Set CPU Governor
echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo 1 > /sys/devices/system/cpu/cpu1/online
echo "interactive" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
echo 1 > /sys/devices/system/cpu/cpu2/online
echo "interactive" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
echo 1 > /sys/devices/system/cpu/cpu3/online
echo "interactive" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
echo `date +"%F %R:%S : CPU governor set to interactive."` >>$log_file
restorecon_recursive /sys/devices/system/cpu/cpufreq
echo `date +"%F %R:%S : Restore SELinux context for CPU governor."` >>$log_file

# Set CPU min. screen on frequency
echo 268800 > /sys/kernel/cpufreq_hardlimit/scaling_min_freq_screen_on
echo `date +"%F %R:%S : CPU min. screen on frequency hardlimit set to 0.268GHz."` >>$log_file

# Set CPU min. screen off frequency
echo 268800 > /sys/kernel/cpufreq_hardlimit/scaling_min_freq_screen_off
echo `date +"%F %R:%S : CPU min. screen off frequency hardlimit set to 0.268GHz."` >>$log_file

# Set CPU max. screen on frequency hardlimit
echo 3091200 > /sys/kernel/cpufreq_hardlimit/scaling_max_freq_screen_on
echo `date +"%F %R:%S : CPU max. screen on frequency hardlimit set to 3.09GHz."` >>$log_file

# Set CPU max. screen off frequency hardlimit
echo 3091200 > /sys/kernel/cpufreq_hardlimit/scaling_max_freq_screen_off
echo `date +"%F %R:%S : CPU max. screen off frequency hardlimit set to 3.09GHz."` >>$log_file

# Set CPU min. wakeup kick frequency
echo 2265600 > /sys/kernel/cpufreq_hardlimit/wakeup_kick_freq
echo `date +"%F %R:%S : CPU min. wakeup kick frequency set to 1.96GHz."` >>$log_file

# Set CPU min. wakeup kick delay
echo 1000 > /sys/kernel/cpufreq_hardlimit/wakeup_kick_delay
echo `date +"%F %R:%S : CPU min. wakeup kick delay set to 1 seconds."` >>$log_file

# Set CPU min. touchboost delay
echo 1000 > /sys/kernel/cpufreq_hardlimit/touchboost_delay
echo `date +"%F %R:%S : CPU min. touchboost delay set to 1 second."` >>$log_file

# Set CPU min. touchboost eventcount
echo 4 > /sys/kernel/cpufreq_hardlimit/touchboost_eventcount
echo `date +"%F %R:%S : CPU min. touchboost eventcount set to 4."` >>$log_file

# Set CPU touchboost low frequency
echo 883200 > /sys/kernel/cpufreq_hardlimit/touchboost_lo_freq
echo `date +"%F %R:%S : CPU min. touchboost low frequency set to 0.88GHz."` >>$log_file

# Set CPU touchboost high frequency
echo 1267200 > /sys/kernel/cpufreq_hardlimit/touchboost_hi_freq
echo `date +"%F %R:%S : CPU min. touchboost high frequency set to 1.27GHz."` >>$log_file

# Set CPU Hotplug driver
stop mpdecision
echo 300000 > /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq
echo 2649600 > /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq
echo 1 > /sys/devices/system/cpu/cpu1/online
echo 300000 > /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_min_freq
echo 2649600 > /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_max_freq
echo 1 > /sys/devices/system/cpu/cpu2/online
echo 300000 > /sys/devices/system/cpu/cpu2/cpufreq/cpuinfo_min_freq
echo 2649600 > /sys/devices/system/cpu/cpu2/cpufreq/cpuinfo_max_freq
echo 1 > /sys/devices/system/cpu/cpu3/online
echo 300000 > /sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_min_freq
echo 2649600 > /sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_max_freq
echo `date +"%F %R:%S : CPU min / max reset (thanx mpdecision for the mess)."` >>$log_file
#echo 1 > /sys/kernel/intelli_plug/intelli_plug_active
#echo 0 > /sys/kernel/intelli_plug/touch_boost_active
#echo `date +"%F %R:%S : CPU Hotplug driver set to IntelliPlug."` >>$log_file

# Set CPU Hotplug driver
#echo 2 > /sys/kernel/intelli_plug/nr_run_profile_sel
#echo `date +"%F %R:%S : IntelliPlug Profile set to Conservative."` >>$log_file

# Set CPU Hotplug driver
#echo 4 > /sys/kernel/intelli_plug/nr_run_hysteresis
#echo `date +"%F %R:%S : IntelliPlug Hysteresis set to fast (4)."` >>$log_file

# Set CPU Hotplug driver
#echo 3500 > /sys/kernel/intelli_plug/cpu_nr_run_threshold
#echo `date +"%F %R:%S : IntelliPlug Runqueue Threshold set to normal zombie (3500)."` >>$log_file

# msm hotplug settings
#echo 1 > /sys/module/msm_hotplug/msm_enabled
#echo 1 > /sys/module/msm_hotplug/min_cpus_online
#echo 500 > /sys/module/msm_hotplug/down_lock_duration
#echo 2500 > /sys/module/msm_hotplug/boost_lock_duration
#echo "200 5:100 50:50 350:200" > /sys/module/msm_hotplug/update_rates 
#echo 100 > /sys/module/msm_hotplug/fast_lane_load
#echo `date +"%F %R:%S : CPU Hotplug driver set to Msm HotPlug."` >>$log_file

# Set CPU Thermal driver
#stop thermal-engine
#echo 1 > /sys/module/msm_thermal/parameters/enabled
#echo 12 > /sys/module/msm_thermal/parameters/core_control_mask
#echo 15 > /sys/module/msm_thermal/parameters/freq_control_mask
#echo `date +"%F %R:%S : CPU Thermal driver set to IntelliThermal."` >>$log_file

# Set CPU Thermal driver
#echo 80 > /sys/module/msm_thermal/parameters/limit_temp_degC
#echo `date +"%F %R:%S : IntelliThermal Frequency Throttle limit set to 80 degrees celcius."` >>$log_file

# Set CPU Thermal driver
#echo 85 > /sys/module/msm_thermal/parameters/core_limit_temp_degC
#echo `date +"%F %R:%S : IntelliThermal Core Throttle limit set to 85 degrees celcius."` >>$log_file

# This is now an option in the ROM under Other Sounds settings
# - Vibrator strength
#echo 80 > /sys/vibrator/pwmvalue
#echo `date +"%F %R:%S : Vibrator strength set to normal (80)."` >>$log_file

# d2tw values: 0:"Disabled", 1:"dt2w", 2:"dt2s"
#echo 1 > /sys/android_touch/doubletap2wake
#echo `date +"%F %R:%S : double tap to wake is enabled."` >>$log_file

# Sweep2Wake values: 0:"Disabled", 1:"Sweep Right", 2:"Sweep Left", 4:"Sweep Up", 8:"Sweep Down"
#echo 1 > /sys/android_touch/sweep2wake
#echo `date +"%F %R:%S : sweep2wake is enabled."` >>$log_file

# Sweep2Sleep values: 0:"Disabled", 1:"Sweep Right", 2:"Sweep Left", 3:"Sweep Left or Right"
#echo "0" > /sys/android_touch/sweep2sleep
#echo `date +"%F %R:%S : sweep2sleep is enabled."` >>$log_file

# Wait for everything to become ready
echo `date +"%F %R:%S : Waiting 60 seconds..."` >>$log_file
sleep 60
# Internal MMC readahead buffer size
echo 1024 > /sys/block/mmcblk0/bdi/read_ahead_kb
echo `date +"%F %R:%S : Internal MMC Readahead set to 1024Kb."` >>$log_file

# Internal MMC I/O scheduler
echo "fiops" > /sys/block/mmcblk0/queue/scheduler
echo `date +"%F %R:%S : Internal MMC scheduler set to FIOPS."` >>$log_file

# - Set color calibration to 6500k (reference)

#echo "250 250 255" > /sys/devices/platform/kcal_ctrl.0/kcal
#echo "243" > /sys/devices/platform/kcal_ctrl.0/kcal_sat
#echo "255" > /sys/devices/platform/kcal_ctrl.0/kcal_cont
#echo "1515" > /sys/devices/platform/kcal_ctrl.0/kcal_hue
#echo "250" > /sys/devices/platform/kcal_ctrl.0/kcal_val
#echo 1 > /sys/devices/platform/kcal_ctrl.0/kcal_enable
#echo `date +"%F %R:%S : Color calibration set to "reference" 6500k (RGB=250,250,255/SAT=243/CONT=255/HUE=1515/GAMMA=250)."` >>$log_file

# - zSwap activation - 1024Mb
if [ -e /sys/block/vnswap0/disksize ] ; then

  swapoff /dev/block/vnswap0

  echo 1073741824 > /sys/block/vnswap0/disksize

  mkswap /dev/block/vnswap0

  swapon /dev/block/vnswap0

fi
echo `date +"%F %R:%S : 1024Mb zSwap support enabled."` >>$log_file

# - swappiness set to 80
echo 80 > /proc/sys/vm/swappiness;
echo `date +"%F %R:%S : Swappiness set to 80."` >>$log_file

# Set msm-adreno-tz GPU governor
echo "msm-adreno-tz" > /sys/devices/fdb00000.qcom,kgsl-3d0/devfreq/fdb00000.qcom,kgsl-3d0/governor
echo `date +"%F %R:%S : GPU governor set to msm-adreno-tz."` >>$log_file

# Set Simple GPU algorithm (faux123)
echo 1 > /sys/module/simple_gpu_algorithm/parameters/simple_gpu_activate
echo `date +"%F %R:%S : Simple GPU algorithm set to enabled."` >>$log_file

# Set Simple GPU algorithm laziness (faux123)
echo 0 > /sys/module/simple_gpu_algorithm/parameters/simple_laziness
echo `date +"%F %R:%S : Simple GPU algorithm laziness set to 0."` >>$log_file

# Set Simple GPU algorithm ramp down threshold (faux123)
echo 0 > /sys/module/simple_gpu_algorithm/parameters/simple_ramp_threshold
echo `date +"%F %R:%S : Simple GPU algorithm ramp down threshold set to 0."` >>$log_file

# Set GPU max freq to 600MHz
echo 600000000 > /sys/devices/fdb00000.qcom,kgsl-3d0/devfreq/fdb00000.qcom,kgsl-3d0/max_freq
echo `date +"%F %R:%S : GPU max. freq. set to 600MHz."` >>$log_file

# i/o schedulers.
echo fiops > /sys/block/mmcblk0/queue/scheduler
echo fiops > /sys/block/mmcblk1/queue/scheduler
echo `date +"%F %R:%S : i/o schedulers set to FIOPS done."` >>$log_file

# i/o read-ahead.
echo 2048 > /sys/block/mmcblk0/queue/read_ahead_kb
echo 2048 > /sys/block/mmcblk1/queue/read_ahead_kb
echo `date +"%F %R:%S : i/o read-ahead set to 2048 done."` >>$log_file

for i in /sys/block/*/queue/add_random; do
echo 0 > $i
done

# frandom permissions
chmod 444 /dev/erandom
chmod 444 /dev/frandom
echo `date +"%F %R:%S : Set frandom permissions done ."` >>$log_file

# HMP scheduler load tracking settings
echo 3 > /proc/sys/kernel/sched_ravg_hist_size
echo `date +"%F %R:%S : Set HMP scheduler load tracking settings done."` >>$log_file

# HMP Task packing settings
echo 20 > /proc/sys/kernel/sched_small_task
echo 30 > /proc/sys/kernel/sched_mostly_idle_load
echo 3 > /proc/sys/kernel/sched_mostly_idle_nr_run
echo 2 > /proc/sys/kernel/sched_window_stats_policy
echo 5 > /proc/sys/kernel/sched_ravg_hist_size
echo `date +"%F %R:%S : Set HMP Task packing settings set done."` >>$log_file

sync

#Set fauxsound defaults.
echo "0" > /sys/kernel/sound_control_3/gpl_sound_control_locked
echo "0 0" > /sys/kernel/sound_control_3/gpl_headphone_gain
echo "0 0" > /sys/kernel/sound_control_3/gpl_speaker_gain
echo "1" > /sys/kernel/sound_control_3/gpl_sound_control_locked
echo `date +"%F %R:%S : set fauxsound defaults done."` >>$log_file

# enabled dynamic fsync
echo "1" > /sys/kernel/dyn_fsync/Dyn_fsync_active
echo `date +"%F %R:%S : Set enabled dynamic fsync done."` >>$log_file

# - enabled USB forced fast charge
echo 1 > /sys/kernel/fast_charge/force_fast_charge
echo `date +"%F %R:%S : Set enabled USB forced fast charge done."` >>$log_file

# Memory management
echo "8192,16384,32768,65536,120320,131072" > /sys/module/lowmemorykiller/parameters/minfree

# Allow untrusted apps to read from debugfs (mitigate SELinux denials)
service supolicy /system/xbin/supolicy --live \
	"allow untrusted_app debugfs file { open read getattr }" \
	"allow untrusted_app sysfs_lowmemorykiller file { open read getattr }" \
	"allow untrusted_app sysfs_devices_system_iosched file { open read getattr }" \
	"allow untrusted_app persist_file dir { open read getattr }" \
	"allow debuggerd gpu_device chr_file { open read getattr }" \
	"allow netd netd capability fsetid" \
	"allow netd { hostapd dnsmasq } process fork" \
	"allow { system_app shell } dalvikcache_data_file file write" \
	"allow { zygote mediaserver bootanim appdomain }  theme_data_file dir { search r_file_perms r_dir_perms }" \
	"allow { zygote mediaserver bootanim appdomain }  theme_data_file file { r_file_perms r_dir_perms }" \
	"allow system_server { rootfs resourcecache_data_file } dir { open read write getattr add_name setattr create remove_name rmdir unlink link }" \
	"allow system_server resourcecache_data_file file { open read write getattr add_name setattr create remove_name unlink link }" \
	"allow system_server dex2oat_exec file rx_file_perms" \
	"allow mediaserver mediaserver_tmpfs file execute" \
	"allow drmserver theme_data_file file r_file_perms" \
	"allow zygote system_file file write" \
	"allow atfwd property_socket sock_file write" \
	"allow untrusted_app sysfs_display file { open read write getattr add_name setattr remove_name }" \
	"allow debuggerd app_data_file dir search"
     disabled
     oneshot

service supolicy /system/xbin/supolicy --live \
	"allow shell dalvikcache_data_file file write" \
	"allow shell dalvikcache_data_file dir { add_name create relabelfrom relabelto remove_name rename reparent rmdir search setattr write }" \
	"allow mediaserver mediaserver_tmpfs file execute" \
	"allow isolated_app app_data_file dir search" \
	"allow untrusted_app kernel dir search"
     disabled
     oneshot

echo `date +"%F %R:%S : Finished kernel configuration."` >>$log_file

chmod 644 $log_file

#--------------------------------------------------
# End of generated script
#--------------------------------------------------
