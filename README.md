# fujifilm-filmmode
Print and Write fujifilm film mode simulation tag.
Print Film mode from Fujifim JPG.

## Usage :

1. Download bash script
1. execute ```$ chmod +x getPictureInfo.sh```
1. execute ```$ chmod +x writePictureInfo.sh```

Run as:

```
$ ./getPictureInfo.sh *.JPG
$ ./writePictureInfo.sh *.JPG
```

## Example

```
$ ./getPictureInfo.sh *.JPG
DSCF1089.JPG - Provia/Standard
DSCF1091.JPG - Velvia/Vivid
DSCF1092.JPG - Provia/Standard
DSCF1093.JPG - Provia/Standard
DSCF1094.JPG - Velvia/Vivid
DSCF1095.JPG - Astia/Soft
DSCF1096.JPG - Classic Chrome
DSCF1097.JPG - Neg Hi
DSCF1098.JPG - Neg Low
DSCF1099.JPG - B&W
DSCF1100.JPG - B&W Y
DSCF1110.JPG - B&W G
DSCF1181.JPG - Neg Hi
DSCF1182.JPG - Neg Low
DSCF1183.JPG - B&W
DSCF1185.JPG - B&W G
DSCF1186.JPG - Provia/Standard
DSCF1187.JPG - Velvia/Vivid
DSCF1189.JPG - Classic Chrome
DSCF1190.JPG - Neg Hi
DSCF1191.JPG - Neg Low
DSCF1193.JPG - B&W Y
Done!

Total worked : 28
Total processed : 28
```

## Notes
Thanks to "exiftool -v2 option" you get useful info from "Maker" tags.

## Tags for black and white

- CustomRendered - Tag 0xa401 (2 bytes, int16u[1])
- Saturation - Tag 0x1003 (2 bytes, int16u[1])

X-T100 Format

```
CustomRendered = 1 + Saturation = 768 = 0x300 => B&W
CustomRendered = 1 + Saturation = 770 = 0x301 => B&W Y
CustomRendered = 1 + Saturation = 771 = 0x303 => B&W G
```

## Tags for colors

- FilmMode - Tag 0x1401 (2 bytes, int16u[1])

X-T100 Format

```
0 => Provia/Standard
512 = 0x200 => Velvia/Vivid
288 = 0x120 => Astia/Soft
1536 = 0x600 => Classic Chrome
1281 = 0x501=> Neg Hi
1280 = 0x500 => Neg Low
```


## Need help

Please send me feedback if you test this script on your own jpeg files.
If you own other fuji please send me results or send me some JPG or ```exiftool -v2``` output with your additional notes.
