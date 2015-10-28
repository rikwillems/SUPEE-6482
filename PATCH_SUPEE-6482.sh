#!/bin/bash


# What is the version number?
version=`php -r "require 'app/Mage.php'; echo Mage::getVersion();"`
echo "Magento version:" $version
naked_version="${version//\./}"


# Which patch file do we need?
if [ $naked_version -ge 1400 -a $naked_version -lt 1420 ]; then
	filename="1.4.1.1"
elif [ $naked_version -ge 1420 -a $naked_version -lt 1610 ]; then
	filename="1.6.0.0"
elif [ $naked_version -ge 1610 -a $naked_version -lt 1700 ]; then
	filename="1.6.2.0"
elif [ $naked_version -ge 1700 -a $naked_version -lt 1810 ]; then
	filename="1.8.0.0"
elif [ $naked_version -ge 1810 -a $naked_version -lt 1921 ]; then
	filename="1.9.2.0"
else
	filename="no-version"
fi;


# Download the right patch.
if [ $filename != "no-version" ]; then
	patch_file="PATCH_SUPEE-6482_CE_"$filename"_v1.sh"
	echo "Download patch: $patch_file"
	wget --no-check-certificate --quiet - https://raw.githubusercontent.com/rikwillems/SUPEE-6482/master/$patch_file
else 
	echo "Version not supported for patch."
	exit;
fi;


# Disable and clear compiler for ease of use.
echo "Disable compiler:"
php -f shell/compiler.php disable

echo "Clear compiler:"
php -f shell/compiler.php clear
