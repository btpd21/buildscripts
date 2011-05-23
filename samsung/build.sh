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
	galaxysmtd)
		lunch=cyanogen_galaxysmtd-eng
		brunch=galaxysmtd
		;;
	galaxysbmtd)
		lunch=cyanogen_galaxysbmtd-eng
		brunch=galaxysbmtd
		;;
	vibrantmtd)
		lunch=cyanogen_vibrantmtd-eng
		brunch=vibrantmtd
		;;
	*)
		echo "Usage: $0 DEVICE ADDITIONAL"
		echo "Example: ./build.sh galaxysmtd (prebuilt kernel + android)"
		echo "Example: ./build.sh galaxysmtd kernel (kernel + android)"
		echo "Supported Devices: captivatemtd, epic, fascinate, galaxysmtd, galaxysbmtd, vibrantmtd"
		exit 2
		;;
esac


. build/envsetup.sh


case "$ADDITIONAL" in
	kernel)
		lunch ${lunch}
		cd kernel/samsung/aries
		./build.sh "$DEVICE"
		cd ../../..
		brunch ${brunch}
		;;
	*)
		brunch ${brunch}
		;;
esac

END=$(date +%s)
ELAPSED=$((END - START))
E_MIN=$((ELAPSED / 60))
E_SEC=$((ELAPSED - E_MIN * 60))
printf "Elapsed: "
[ $E_MIN != 0 ] && printf "%d min(s) " $E_MIN
printf "%d sec(s)\n" $E_SEC
