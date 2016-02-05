#!/bin/sh

cd /opt
ls
ant -version

echo "\n**********************Running ${CONT} Test  cases using ANT inside test:local container*************************"

#echo "**************************** Value for ant taget to run is --- ${CONT} *****************************************"

ant $CONT

echo "\n**********************************************************************************************************"
