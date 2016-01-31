
# Prepare the project
PROJECT_NAME=$1
echo "Setuping project $PROJECT_NAME"
PROP_FILE=./"$PROJECT_NAME"/sonar-project.properties

if [ ! -f $PROP_FILE ]
then
	echo "Creating properties file"
	touch $PROP_FILE
	echo "sonar.projectKey=org.sonarqube:java-simple-sq-scanner" >> $PROP_FILE
	echo "sonar.projectName=$PROJECT_NAME" >> $PROP_FILE
	echo "sonar.projectVersion=1.0" >> $PROP_FILE
	echo "sonar.sources=src" >> $PROP_FILE
fi
echo "Project is ready"

SERVER_ON=`curl --output /dev/null --silent --head --fail http://localhost:9000; echo $?`
if [ $SERVER_ON -ne 0 ]
then
	# Start up the server
	echo "Launching sonarqube server"
	sonarqube-5.3/bin/macosx-universal-64/sonar.sh console > /dev/null &

	# Wait till server is up
	until $(curl --output /dev/null --silent --head --fail http://localhost:9000); do
    		printf '.'
    		sleep 1
	done
fi
echo "Server is up"

# Start analyzing
echo "Launching analysis"
cd ./"$PROJECT_NAME"
../sonar-scanner-2.5/bin/sonar-runner > /dev/null
echo "Analysis is done. Go to http://localhost:9000"
#echo "Shuting down the server"
#PID=`ps | grep /usr/bin/java | grep sonar | cut -d" " -f1`
#kill $PID
#echo "Done"






