# shskript
Script for manual analyzing

* Prepare directory with following items:
  * sonarqube dir
  * sonarscanner dir
  * project dir to analyze
  * starshunt.sh script

* run this command: `./starshunt.sh project_name_to_analyze`. The script:
  * adds properties file to the project
  * start sonarqube server
  * launch sonarscanner

* When an analysis is done, go to http://localhost:9000 to see its results
* When you are done with analyzing, turn the sonarqube server off by running commnad: 
  * kill `ps | grep /usr/bin/java | grep sonar | cut -d" " -f1`

