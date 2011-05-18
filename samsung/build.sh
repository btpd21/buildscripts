#/bin/bash

START=$(date +%s)

DEVICE="$1"
ADDITIONAL="$2"

case "$DEVICE" in
	clean)
		make clean
		rm -rf ./out 
		exit
		;;
     	prepare) 
          	cd vendor/cyanogen 
          	./get-rommanager
          	./get-google-files
          	exit
          	;;
	captivatemtd)
		lunch=cyanogen_captivatemtd-eng
		brunch=captivatemtd
		;;
	epic)
		lunch=cyanogen_epic-eng
		brunch=epic		
                ;;
	fascinate)
		lunch=cyanogen_fascinate-eng
		brunch=fascinate
                ;;
	galaxys)
		lunch=cyanogen_galaxys-eng
		brunch=galaxys
		;;
	galaxysb)
		lunch=cyanogen_galaxysb-eng
		brunch=galaxysb
		;;
	vibrantmtd)
		lunch=cyanogen_vibrantmtd-eng
		brunch=vibrantmtd
		;;
	*)
		echo "Usage: $0 DEVICE ADDITIONAL"
		echo "Example: ./build.sh galaxys (full build)"
		echo "Example: ./build.sh galaxys kernel (kernel only)"
		echo "Supported Devices: captivatemtd, epic, fascinate, galaxys, galaxysb, vibrantmtd"
		exit 2
		;;
esac


. build/envsetup.sh


case "$ADDITIONAL" in
	kernel)
		lunch ${lunch}
		cd kernel/samsung/2.6.35
		./build.sh "$DEVICE"
		cd ../../..
		brunch ${brunch}
		;;
	*)
		brunch ${brunch}
		;;
esac

#
# unconditionally build initial flashable zip as well
#
cd releasetools
./universal.sh "$DEVICE"
cd ../../..
##

END=$(date +%s)
ELAPSED=$((END - START))
E_MIN=$((ELAPSED / 60))
E_SEC=$((ELAPSED - E_MIN * 60))
printf "Elapsed: "
[ $E_MIN != 0 ] && printf "%d min(s) " $E_MIN
printf "%d sec(s)\n" $E_SEC
