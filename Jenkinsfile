def packageName = "${env.JOB_NAME}"
def buildNumber = "${env.BUILD_NUMBER}"
def dirname = "${packageName}_${buildNumber}".split('/')[2]
def fulldirname = "/tmp/${dirname}"
def ENV_VAR = ""

pipeline {
  agent any
  
  stages {
      stage('Checkout') {
        steps {
            checkout scm
            sh """
				ls -al
				pwd
				
                
				
            """            
          }        
      }
	  stage('RUN Unit Tests'){
	  }
	  stage('Docker Build, Push'){
		// This step should not normally be used in your script. Consult the inline help for details.
		withDockerRegistry(credentialsId: 'dockerhub-axway', url: 'https://index.docker.io/v1/') {
			// some block
		}
	  }
	  stage('Deploy on K8s'){
	  }
  }
  
}