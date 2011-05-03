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
		brunch=captivate
		;;
	galaxys)
		lunch=cyanogen_galaxys-eng
		brunch=galaxys
		;;
	galaxysb)
		lunch=cyanogen_galaxysb-eng
		brunch=galaxysb
		;;
	vibrant)
		lunch=cyanogen_vibrant-eng
		brunch=vibrant
		;;
	*)
		echo "Usage: $0 DEVICE ADDITIONAL"
		echo "Example: ./build.sh galaxys (full build)"
		echo "Example: ./build.sh galaxys kernel (kernel only)"
		echo "Supported Devices: captivate, galaxys, galaxysb, vibrant"
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


END=$(date +%s)
ELAPSED=$((END - START))
E_MIN=$((ELAPSED / 60))
E_SEC=$((ELAPSED - E_MIN * 60))
printf "Elapsed: "
[ $E_MIN != 0 ] && printf "%d min(s) " $E_MIN
printf "%d sec(s)\n" $E_SEC
