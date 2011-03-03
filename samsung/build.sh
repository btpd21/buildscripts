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
	captivate)
		lunch=cyanogen_captivate-eng
		;;
	galaxys)
		lunch=cyanogen_galaxys-eng
		;;
	galaxysb)
		lunch=cyanogen_galaxysb-eng
		;;
	vibrant)
		lunch=cyanogen_vibrant-eng
		;;
	*)
		echo "Usage: $0 DEVICE ADDITIONAL"
		echo "Example: ./build.sh galaxys"
		echo "Example: ./build.sh galaxys otapackage"
		echo "Supported Devices: captivate, galaxys, galaxysb, vibrant"
		exit 2
		;;
esac

. build/envsetup.sh
lunch ${lunch}
make -j`grep 'processor' /proc/cpuinfo | wc -l` $ADDITIONAL

END=$(date +%s)
ELAPSED=$((END - START))
E_MIN=$((ELAPSED / 60))
E_SEC=$((ELAPSED - E_MIN * 60))
printf "Elapsed: "
[ $E_MIN != 0 ] && printf "%d min(s) " $E_MIN
printf "%d sec(s)\n" $E_SEC
