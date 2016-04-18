#!/bin/sh
export workspace=$1
export baseURL=$2
export Device=$3
export target=$4
export abi=$5

echo Building test container image
#docker pull www.cybage-docker-registry.com:9080/selenium_test
echo '\n\n*****Starting Selenium Hub Container...*****\n'
HUB=$(docker run -d selenium/hub:2.47.1)
echo $HUB


HubURL=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $HUB)
#HubURL=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $(docker ps -q))
echo $HubURL
HUB_NAME=$(docker inspect -f '{{ .Name  }}' $HUB | sed s:/::)
echo '\n\n*****Waiting for Hub to come online...*****\n'
docker logs -f $HUB &
sleep 2
#echo '\n*****Starting Selenium chrome node...*****\n'

echo '\n*****Starting Selenium  node...*****\n'
NODE1=$(docker run -d --link $HUB_NAME:hub -e DEVICE_NAME=device1 -e TARGET=7 -e ABI=default/armeabi-v7a -e Hub=$HubURL sopansagorkar/android_final)
ip_NODE1=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $NODE1 )


#echo '\n\n*****Starting Selenium Firefox node...*****\n'
#NODE_FIREFOX=$(docker run -d --link $HUB_NAME:hub selenium/node-firefox$DEBUG:2.47.1)
#ipFIREFOX_NODE=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $NODE_FIREFOX )

echo '\n******Waiting for nodes to register and come online...******'
sleep 3s

echo "\n\n\n*************************************calling function firefox*****************************************\n"
echo 'Calling function test_node_firefox'

 test_node_firefox
 {
 # BROWSER=firefox
 # echo Running $BROWSER test...
pwd
SEARCH1="localhost"
REPLACE1="$HubURL"
sed -i "s%${SEARCH1}%${REPLACE1}%g"  selenium-docker/src/com/test/WebAndroid.java
#sed -i "s%${SEARCH1}%${REPLACE1}%g"  ../GridSelenium/src/test/java/com/selenium/test/TestClass2.java

#SEARCH2="172.27.59.35"
#REPLACE2="$baseURL"
#sed -i "s%${SEARCH2}%${REPLACE2}%g"  ../GridSelenium/src/test/java/com/selenium/test/*
#sed -i "s%${SEARCH2}%${REPLACE2}%g"  ../GridSelenium/src/test/java/com/selenium/test/TestClass2.java

#cd ./../GridSelenium/
pwd
echo "***********************************************"


echo $workspace
docker run  -d --link $HUB_NAME:hub -v $workspace:/opt selenium/test

STATUS=$?
  TEST_CONTAINER_firefox=$(docker ps -aq | head -1)

  if [ ! $STATUS = 0 ]; then

   echo Failed
    exit 1
  fi


    echo "\n\n**************logs of TEST_CONTAINER_FIREFOX**************"
    docker logs -f $TEST_CONTAINER_firefox | tee test_local_firefox.log
    echo "**********************************************************"


     echo Removing the test container firefox
    docker stop $TEST_CONTAINER_firefox
     docker rm $TEST_CONTAINER_firefox

}

echo '**************************************end of function Firefox****************************************'


echo '\n\n\n***********************************calling function Chrome*****************************************\n'
echo 'calling function test_node_chrome'



#test_node_chrome
# {
# BROWSER=chrome
#  echo Running $BROWSER test...



#docker run -d --link $HUB_NAME:hub -v $workspace/selenium_grid/GridSelenium:/opt sopansagorkar/selenium-test

 # STATUS=$?
   # TEST_CONTAINER_chrome=$(docker ps -aq | head -1)

  #  if [ ! $STATUS = 0 ]; then
     # echo Failed
    #  echo '*****************'
     # exit 1
   # fi


     # echo "\n\n**************logs of TEST_CONTAINER_CHROME**************"
     # docker logs -f $TEST_CONTAINER_chrome | tee test_local_chrome.log
     # echo "**********************************************************"

      echo Removing the test container chrome
      docker stop $TEST_CONTAINER_chrome
      docker rm $TEST_CONTAINER_chrome

    #      }
  echo "*******************************end of function Chrome*******************************************\n"



echo '*************************************** Stopping and removing  node containers *******************************************'


  echo '\n\n*************************************** logs of CHROME node container *******************************************'
    docker logs $NODE_CHROME | tee node_chrome.log
    echo '\nTearing down Selenium Chrome Node container *** Chrome node down ***\n'
#   docker stop $NODE_CHROME
 #  docker rm $NODE_CHROME


  echo '\n\n*************************************** logs of FIREFOX node container *******************************************'
    docker logs $NODE_FIREFOX | tee node_firefox.log
   echo '\nTearing down Selenium Firefox Node container *** FireFox node down ***\n'
  #  docker stop $NODE_FIREFOX
   # docker rm $NODE_FIREFOX


  echo '\n\n*************************************** logs of HUB container *******************************************'
    docker logs $HUB | tee hub.log
    echo '\n***  At last removing hub  ***'
   docker stop $HUB
    docker rm $HUB


  echo '\nDone'
  echo '\n\n\n*******************************************end of script******************************************'




