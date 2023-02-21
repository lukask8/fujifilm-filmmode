#!/bin/bash
# Print and write film mode from Fujifim JPG to IPTC and XMP keywords format
#
# Usage :
# $ ./writePictureInfo.sh *.JPG
#
# Thanks to "exiftool -v2 option" you get useful info from tags:
#
# - CustomRendered = 1 - Tag 0xa401 (2 bytes, int16u[1])
# - Saturation = 771 - Tag 0x1003 (2 bytes, int16u[1])
#
# CustomRendered = 1 + Saturation = 768 => B&W
# CustomRendered = 1 + Saturation = 769 => B&W R
# CustomRendered = 1 + Saturation = 770 => B&W Y
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
# 512 = 0x200 => Velvia/Vivid
# 288 = 0x120 => Astia/Soft
# 1536 = 0x600 => Classic Chrome
# 1281 = 0x501=> Pro Neg Hi
# 1280 = 0x500 => Pro Neg Std
# 1792 = 0x700 => Eterna/Cinema
# 2048 = 0x800 => Classic Neg
# 2304 = 0x900 => Eterna Bleach Bypass
# 2560 = 0xa00 => Nostalgic Neg


if [ -z "$1" ]
  then
    echo ""
    echo "	Print Film mode from Fujifim JPG file and write result to IPTC and XMP keywords format"
    echo ""
    echo "	Usage:"
    echo "	$ ./writePictureInfo.sh *.JPG"
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
				if  [[ "$output" == *"= 768"* ]] ; then
					keys="B&W"
					exiftool -IPTC:keywords-=$keys -IPTC:keywords+=$keys "$i"
					echo "$i" - "B&W"
    			    PROCESSED=$((PROCESSED+1))
				fi
				if  [[ "$output" == *"= 769"* ]] ; then
					keys="B&W-R"
					exiftool -IPTC:keywords-=$keys -IPTC:keywords+=$keys "$i"
					echo "$i" - "B&W R"
    			    PROCESSED=$((PROCESSED+1))
				fi				
				if  [[ "$output" == *"= 770"* ]] ; then
					keys="B&W-Ye"
					exiftool -IPTC:keywords-=$keys -IPTC:keywords+=$keys "$i"
					echo "$i" - "B&W Ye"
    			    PROCESSED=$((PROCESSED+1))
				fi
				if  [[ "$output" == *"= 771"* ]] ; then
					keys="B&W-G"
					exiftool -IPTC:keywords-=$keys -IPTC:keywords+=$keys "$i"
					echo "$i" - "B&W G"
    			    PROCESSED=$((PROCESSED+1))
				fi
				if [[ "$output" == *"= 784"* ]] ; then
					keys="Sepia"
					exiftool -IPTC:keywords-=$keys -IPTC:keywords+=$keys "$i"
					echo "$i" - "Sepia"
				    PROCESSED=$((PROCESSED+1))
				fi
				if [[ "$output" == *"= 1280"* ]] ; then
					keys="Acros"
					exiftool -IPTC:keywords-=$keys -IPTC:keywords+=$keys "$i"
					echo "$i" - "Acros"
				    PROCESSED=$((PROCESSED+1))
				fi
				if [[ "$output" == *"= 1281"* ]] ; then
					keys="Acros-R"
					exiftool -IPTC:keywords-=$keys -IPTC:keywords+=$keys "$i"
					echo "$i" - "Acros R"
				    PROCESSED=$((PROCESSED+1))
				fi
				if [[ "$output" == *"= 1282"* ]] ; then
					keys="Acros-Ye"
					exiftool -IPTC:keywords-=$keys -IPTC:keywords+=$keys "$i"
					echo "$i" - "Acros Ye"
				    PROCESSED=$((PROCESSED+1))
				fi
				if [[ "$output" == *"= 1283"* ]] ; then
					keys="Acros-G"
					exiftool -IPTC:keywords-=$keys -IPTC:keywords+=$keys "$i"
					echo "$i" - "Acros G"
				    PROCESSED=$((PROCESSED+1))
				fi
		else 
				# Color film
				output=`exiftool -v2 "$i" | grep  "FilmMode = "`
				if [[ "$output" == *"= 0"* ]]; then
					keys="Provia"
					exiftool -IPTC:keywords-=$keys -IPTC:keywords+=$keys "$i"				
				  	echo "$i" - "Provia/Standard"
				    PROCESSED=$((PROCESSED+1))				  	
				fi 
				if [[ "$output" == *"= 512"* ]]; then
					keys="Velvia"
					exiftool  -IPTC:keywords-=$keys -IPTC:keywords+=$keys "$i"							
				  	echo "$i" - "Velvia/Vivid"	
					PROCESSED=$((PROCESSED+1))
				fi
				if [[ "$output" == *"= 288"* ]]; then
					keys="Astia"
					exiftool  -IPTC:keywords-=$keys   -IPTC:keywords+=$keys "$i"										
				  	echo "$i" - "Astia/Soft"
					PROCESSED=$((PROCESSED+1))				  			
				fi
				if [[ "$output" == *"= 1536"* ]]; then
					keys="ClassicChrome"
					exiftool -IPTC:keywords-=$keys   -IPTC:keywords+=$keys "$i"						  			
				  	echo "$i" - "Classic Chrome"
  					PROCESSED=$((PROCESSED+1))				  				
				fi
				if [[ "$output" == *"= 1281"* ]]; then
					keys="ProNegHi"
					exiftool -IPTC:keywords-=$keys   -IPTC:keywords+=$keys "$i"			
					echo "$i" - "Pro Neg Hi"
   	  				PROCESSED=$((PROCESSED+1))
				fi
				if [[ "$output" == *"= 1280"* ]]; then
					keys="ProNegStd"
					exiftool -IPTC:keywords-=$keys -IPTC:keywords+=$keys "$i"							  					
				  	echo "$i" - "Pro Neg Std"
    	  			PROCESSED=$((PROCESSED+1))
				fi
				if [[ "$output" == *"= 1792"* ]]; then
					keys="Eterna"
					exiftool -IPTC:keywords-=$keys -IPTC:keywords+=$keys "$i"							  					
				  	echo "$i" - "Eterna/Cinema"
		  			PROCESSED=$((PROCESSED+1))
				fi
				if [[ "$output" == *"= 2048"* ]]; then
					keys="ClassicNeg"
					exiftool -IPTC:keywords-=$keys -IPTC:keywords+=$keys "$i"							  					
				  	echo "$i" - "Classic Neg"
		  			PROCESSED=$((PROCESSED+1))
				fi
				if [[ "$output" == *"= 2304"* ]]; then
					keys="EternaBleachBypass"
					exiftool -IPTC:keywords-=$keys -IPTC:keywords+=$keys "$i"							  					
				  	echo "$i" - "Eterna Bleach Bypass"
		  			PROCESSED=$((PROCESSED+1))
				fi
				if [[ "$output" == *"= 2560"* ]]; then
					keys="NostalgicNeg"
					exiftool -IPTC:keywords-=$keys -IPTC:keywords+=$keys "$i"							  					
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
