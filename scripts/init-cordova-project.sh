#!/bin/sh

CORDOVA_ANDROID_ROOT=~/work/downloads/cordova-2.3.0/cordova-android/
CORDOVA_IOS_ROOT=~/work/downloads/cordova-2.3.0/cordova-ios/

if [ ! -d $CORDOVA_IOS_ROOT -o ! -d $CORDOVA_ANDROID_ROOT ]; then
    echo "You must set CORDOVA_IOS_ROOT and CORDOVA_ANDROID_ROOT vars"
    exit 1
fi

if [ x"$2" == x ]; then
    echo "Usage: $0 <package_name> <project_name>"
    echo "Example: $0 org.biais.awesomeproject AwesomeProject"
    exit 2
fi

package_name=$1
project_name=$2

$CORDOVA_IOS_ROOT/bin/create ios $package_name $project_name
$CORDOVA_ANDROID_ROOT/bin/create android $package_name $project_name


# Update cordova js lib
mv android/assets/www/cordova*.js common/www/js/lib/cordova-android.js
mv ios/www/cordova*.js common/www/js/lib/cordova-ios.js

rm -rf android/assets/www/
rm -rf ios/www/
cd android/assets/
ln -s ../../common/www www
cd ../../ios/
ln -s ../../common/www www
cd ..

