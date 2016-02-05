export workspace=$1
export baseURL=$2

echo Building test container image

#docker pull www.cybage-docker-registry.com:9080/selenium_test


echo '\n\n*****Starting Selenium Hub Container...*****\n'
HUB=$(docker run -d selenium/hub)
HubURL=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $HUB )


HUB_NAME=$(docker inspect -f '{{ .Name  }}' $HUB | sed s:/::)
echo '\n\n*****Waiting for Hub to come online...*****\n'
docker logs -f $HUB &
sleep 2


echo '\n*****Starting Selenium device node...*****\n'
NODE_DEVICE01=$(docker run -d --link $HUB_NAME:hub  sopansagorkar/appium-android:1.3)
ip_NODE01=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $NODE_DEVICE01 )

echo $NODE_DEVICE01

echo $ip_NODE01

echo 'hi sopan'
