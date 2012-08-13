#!/sbin/sh

# DooMLoRD: auto script (v12) - Load Modules (sirkay)

# [START] setting up
echo "[START] remounting system" > /data/local/tmp/autolog.txt
/sbin/busybox mount -o remount,rw /system >> /data/local/tmp/autolog.txt

# [CHECK] searching if modules was loaded before
echo "[CHECK] searching for modules dir " >> /data/local/tmp/autolog.txt
if /sbin/busybox [ ! -f /system/lib/modules ]; 
then
	echo "[FOUND] modules dir " >> /data/local/tmp/autolog.txt

	# [CHECK] verify /system/xbin
	echo "[CHECK] verifying /system/lib/modules " >> /data/local/tmp/autolog.txt
	/sbin/busybox mv /system/lib/modules /system/lib/modules.old
	/sbin/busybox mkdir /system/lib/modules/
	/sbin/busybox chmod 755 /system/lib/modules/
	/sbin/busybox cp -fr /modules/* /system/lib/modules/.

	# [Permission] set permission
	echo "[Permission] set permission " >> /data/local/tmp/autorootlog.txt
	/sbin/busybox chmod 0644 /system/lib/modules/drivers/net/wireless/wl12xx/*
	/sbin/busybox chmod 0644 /system/lib/modules/net/mac80211/*
	/sbin/busybox chmod 0644 /system/lib/modules/net/wireless/*
	/sbin/busybox chmod 0644 /system/lib/modules/compat/*

#	# [old modules] checking old modules backup
#	echo "[busybox binary] remove existing occurances and push busybox" >> /data/local/tmp/autolog.txt
#	if /sbin/busybox [ ! -f /system/lib/modules.old ]; 
#	then	
#		echo "[old modules] found in /system/lib " >> /data/local/tmp/autolog.txt
#		if /sbin/busybox [ ! -f /system/bin/busybox ]; 
#		then	
#			echo "[busybox binary] not found in /system/bin/busybox " >> /data/local/tmp/autorootlog.txt
#			/sbin/busybox cp /res/autoroot/busybox /system/xbin/busybox
#			/sbin/busybox chown root.root /system/xbin/busybox
#			/sbin/busybox chmod 4777 /system/xbin/busybox
#		fi
#	fi
#
#	# [DONE] placing flag
#	echo "[DONE] placing flag" >> /data/local/tmp/autorootlog.txt
#	/sbin/busybox touch /system/autorooted 
#
else

	echo "[FOUND] modules dir " >> /data/local/tmp/autolog.txt
	echo "Device has modules loaded " >> /data/local/tmp/autolog.txt
	echo "nothing to do... bye bye..." >> /data/local/tmp/autolog.txt

fi;

# [DONE] all done exiting
echo "[DONE] all done exiting" >> /data/local/tmp/autolog.txt
