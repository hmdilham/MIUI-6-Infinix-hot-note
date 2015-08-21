#!/system/bin/sh
  echo 1 > /sys/module/sec/parameters/recovery_done		#tony
if ! applypatch -c EMMC:recovery:8216576:b9e644abd26511f864ac3d28d400e022630f5119; then
  log -t recovery "Installing new recovery image"
  applypatch -b /system/etc/recovery-resource.dat EMMC:boot:6821888:9c370aa1a1270ccc359b467c7ff87a8a4b345309 EMMC:recovery b9e644abd26511f864ac3d28d400e022630f5119 8216576 9c370aa1a1270ccc359b467c7ff87a8a4b345309:/system/recovery-from-boot.p
  if applypatch -c EMMC:recovery:8216576:b9e644abd26511f864ac3d28d400e022630f5119; then		#tony
	echo 0 > /sys/module/sec/parameters/recovery_done		#tony
        log -t recovery "Install new recovery image completed"
  else
	echo 2 > /sys/module/sec/parameters/recovery_done		#tony
        log -t recovery "Install new recovery image not completed"
  fi
else
  echo 0 > /sys/module/sec/parameters/recovery_done              #tony
  log -t recovery "Recovery image already installed"
fi
