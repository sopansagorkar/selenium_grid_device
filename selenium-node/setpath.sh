#!/bin/bash

echo "IN SHELL SCRIPT"

echo $PWD
ip=$(ifconfig eth0 | sed -n "s/.*inet [^ ]*:\([^ ]*\) .*/\1/p")
#cd /home/android && npm install appium

#appium &

echo no | /usr/local/android-sdk/tools/android create avd -n $DEVICE_NAME -t $TARGET --abi $ABI  && sleep 20

echo "-------------Created avd"

emulator -avd $DEVICE_NAME -no-window &

echo "----------avd started"
sleep 20
adb kill-server
adb start-server
sleep 20

echo "------------listing devices"
adb devices
adb devices
adb shell input keyevent 82
adb shell input keyevent 82
adb shell input keyevent 82

echo "**********************************starting appium************************************"

appium --nodeconfig /usr/local/nodeConfig.json
