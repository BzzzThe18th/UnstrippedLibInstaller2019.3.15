#!/bin/sh

inPath () {
	type "$1" >/dev/null 2> /dev/null
}
if [ ! inPath "unzip"]; then
	print "unzip must be on path. Perhaps it's not installed?"
	exit 127

fi
if [ ! inPath "curl"]; then
	print "curl must be on path. Perhaps it's not installed?"
	exit 127
fi
if [ ! -d "UnstrippedLibs" ]; then
	mkdir "UnstrippedLibs"
fi
curl -k -L -o "temp1.zip" https://unity.bepinex.dev/libraries/2019.3.15.zip
curl -k -L -o "temp2.zip" https://unity.bepinex.dev/corlibs/2019.3.15.zip

unzip -o "temp1.zip" -d "UnstrippedLibs"
unzip -o "temp2.zip" -d "UnstrippedLibs"

chmod -R +rw UnstrippedLibs
sed -itemp 's/dllSearchPathOverride=\(.*\)/dllSearchPathOverride=UnstrippedLibs/' doorstop_config.ini

rm "temp1.zip"
rm "temp2.zip"
cp "UnstrippedLibs/UnityEngine.TextCoreModule.dll" "Gorilla Tag_Data/Managed"
