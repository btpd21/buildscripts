#/bin/bash

START=$(date +%s)

DEVICE="$1"

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
	captivate)
		brunch=captivate
		;;
	galaxys)
		brunch=galaxys
		;;
	galaxysb)
		brunch=galaxysb
		;;
	vibrant)
		brunch=vibrant
		;;
	*)
		echo "Usage: $0 DEVICE"
		echo "Example: ./build.sh galaxys"
		echo "Supported Devices: captivate, galaxys, galaxysb, vibrant"
		exit 2
		;;
esac

. build/envsetup.sh
brunch ${brunch}

END=$(date +%s)
ELAPSED=$((END - START))
E_MIN=$((ELAPSED / 60))
E_SEC=$((ELAPSED - E_MIN * 60))
printf "Elapsed: "
[ $E_MIN != 0 ] && printf "%d min(s) " $E_MIN
printf "%d sec(s)\n" $E_SEC
