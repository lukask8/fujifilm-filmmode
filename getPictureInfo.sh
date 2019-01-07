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
# CustomRendered = 1 + Saturation = 770 => B&W Y
# CustomRendered = 1 + Saturation = 771 => B&W G
#
# FilmMode = 0 - Tag 0x1401 (2 bytes, int16u[1])
#
# 0 => Provia/Standard
# 512 => Velvia/Vivid
# 288 => Astia/Soft
# 1536 => Classic Chrome
# 1281 => Neg Hi
# 1280 => Neg Low



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
				if  [[ "$output" == *"= 768"* ]] ; then
					echo "$i" - "B&W"
    			    PROCESSED=$((PROCESSED+1))
				fi
				if  [[ "$output" == *"= 769"* ]] ; then
					echo "$i" - "B&W R"
    			    PROCESSED=$((PROCESSED+1))
				fi				
				if  [[ "$output" == *"= 770"* ]] ; then
					echo "$i" - "B&W Y"
    			    PROCESSED=$((PROCESSED+1))
				fi
				if  [[ "$output" == *"= 771"* ]] ; then
					echo "$i" - "B&W G"
    			    PROCESSED=$((PROCESSED+1))
				fi				
		else 
				# Color film
				output=`exiftool -v2 "$i" | grep  "FilmMode = "`
				if [[ "$output" == *"= 0"* ]]; then
				  	echo "$i" - "Provia/Standard"
				    PROCESSED=$((PROCESSED+1))				  	
				else 
					if [[ "$output" == *"= 512"* ]]; then
				  		echo "$i" - "Velvia/Vivid"	
					    PROCESSED=$((PROCESSED+1))
				  	else
						if [[ "$output" == *"= 288"* ]]; then
				  			echo "$i" - "Astia/Soft"
						    PROCESSED=$((PROCESSED+1))				  			
				  		else
				  			if [[ "$output" == *"= 1536"* ]]; then
				  				echo "$i" - "Classic Chrome"
  							    PROCESSED=$((PROCESSED+1))				  				
				  			else
				  				if [[ "$output" == *"= 1281"* ]]; then
				  					echo "$i" - "Neg Hi"
   	  							    PROCESSED=$((PROCESSED+1))
				  				else
				  					if [[ "$output" == *"= 1280"* ]]; then
				  						echo "$i" - "Neg Low"
    	  							    PROCESSED=$((PROCESSED+1))
				  					fi
				  				fi
							fi
						fi
				  	fi			
				fi
		fi

        COUNTER=$((COUNTER+1))
done
echo "Done!"
######################################################
echo ""
echo "Total worked :" $COUNTER
echo "Total processed :" $PROCESSED
