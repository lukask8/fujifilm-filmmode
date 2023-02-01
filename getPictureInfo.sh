#!/bin/bash
# Print Film mode from Fujifim JPG
# Usage :
# $ ./getPictureInfo.sh *.JPG
#
# Thanks to "exiftool -v2 option" you get useful info from tags:
#
# - CustomRendered = 1 - Tag 0xa401 (2 bytes, int16u[1])
# - Saturation = 771 - Tag 0x1003 (2 bytes, int16u[1])
#
# CustomRendered = 1 + Saturation = 768 => B&W
# CustomRendered = 1 + Saturation = 769 => B&W R
# CustomRendered = 1 + Saturation = 770 => B&W Ye
# CustomRendered = 1 + Saturation = 771 => B&W G
# CustomRendered = 1 + Saturation = 784 => Sepia
# CustomRendered = 1 + Saturation = 1280 => Acros
# CustomRendered = 1 + Saturation = 1281 => Acros R
# CustomRendered = 1 + Saturation = 1282 => Acros Ye
# CustomRendered = 1 + Saturation = 1283 => Acros G
#
# FilmMode = 0 - Tag 0x1401 (2 bytes, int16u[1])
#
# 0 => Provia/Standard
# 512 => Velvia/Vivid
# 288 => Astia/Soft
# 1536 => Classic Chrome
# 1281 => Pro Neg Hi
# 1280 => Pro Neg Std
# 1792 => Eterna/Cinema
# 2048 => Classic Neg
# 2304 => Eterna Bleach Bypass
# 2560 => Nostalgic Neg



if [ -z "$1" ]
  then
    echo ""
    echo "	Print Film mode from Fujifim JPG file"
    echo ""
    echo "	Usage:"
    echo "	$ ./getPictureInfo.sh *.JPG"
    echo ""
    exit 0
fi

COUNTER=0
PROCESSED=0

######################################################
for i in "$@"
do
		output=`exiftool -v2 "$i" | grep  "CustomRendered = 1"`
		if   [  -n "$output"  ] ; then
				# B&W
				output=`exiftool -v2 "$i" | grep  "Saturation ="`
				echo "$output"
				if  [[ "$output" == *"= 768"* ]] ; then
					echo "$i" - "B&W"
    			    PROCESSED=$((PROCESSED+1))
				fi
				if  [[ "$output" == *"= 769"* ]] ; then
					echo "$i" - "B&W R"
    			    PROCESSED=$((PROCESSED+1))
				fi				
				if  [[ "$output" == *"= 770"* ]] ; then
					echo "$i" - "B&W Ye"
    			    PROCESSED=$((PROCESSED+1))
				fi
				if  [[ "$output" == *"= 771"* ]] ; then
					echo "$i" - "B&W G"
    			    PROCESSED=$((PROCESSED+1))
				fi
				if  [[ "$output" == *"= 784"* ]] ; then
					echo "$i" - "Sepia"
				    PROCESSED=$((PROCESSED+1))
				fi
				if  [[ "$output" == *"= 1280"* ]] ; then
					echo "$i" - "Acros"
				    PROCESSED=$((PROCESSED+1))
				fi
				if  [[ "$output" == *"= 1281"* ]] ; then
					echo "$i" - "Acros R"
				    PROCESSED=$((PROCESSED+1))
				fi
				if  [[ "$output" == *"= 1282"* ]] ; then
					echo "$i" - "Acros Ye"
				    PROCESSED=$((PROCESSED+1))
				fi
				if  [[ "$output" == *"= 1283"* ]] ; then
					echo "$i" - "Acros G"
				    PROCESSED=$((PROCESSED+1))
				fi
		else 
				# Color film
				output=`exiftool -v2 "$i" | grep  "FilmMode = "`
				echo "$output"
				if [[ "$output" == *"= 0"* ]]; then
				  	echo "$i" - "Provia/Standard"
				    PROCESSED=$((PROCESSED+1))				  	
				fi
				if [[ "$output" == *"= 512"* ]]; then
				  		echo "$i" - "Velvia/Vivid"	
					    PROCESSED=$((PROCESSED+1))
				fi
				if [[ "$output" == *"= 288"* ]]; then
				  	echo "$i" - "Astia/Soft"
					PROCESSED=$((PROCESSED+1))
				fi
				if [[ "$output" == *"= 1536"* ]]; then
				  	echo "$i" - "Classic Chrome"
  					PROCESSED=$((PROCESSED+1))
				fi
				if [[ "$output" == *"= 1281"* ]]; then
				  	echo "$i" - "PRO Neg.Hi"
   	  				PROCESSED=$((PROCESSED+1))
				fi
				if [[ "$output" == *"= 1280"* ]]; then
				  	echo "$i" - "PRO Neg.Std"
    	  			PROCESSED=$((PROCESSED+1))
				fi
				if [[ "$output" == *"= 1792"* ]]; then
				  	echo "$i" - "Eterna/Cinema"
					PROCESSED=$((PROCESSED+1))
				fi
				if [[ "$output" == *"= 2048"* ]]; then
					echo "$i" - "Classic Neg"
					PROCESSED=$((PROCESSED+1))
				fi
				if [[ "$output" == *"= 2304"* ]]; then
					echo "$i" - "Eterna Bleach Bypass"
					PROCESSED=$((PROCESSED+1))
				fi
				if [[ "$output" == *"= 2560"* ]]; then
					echo "$i" - "Nostalgic Neg"
					PROCESSED=$((PROCESSED+1))
				fi
		fi

        COUNTER=$((COUNTER+1))
done
echo "Done!"
######################################################
echo ""
echo "Total worked :" $COUNTER
echo "Total processed :" $PROCESSED
