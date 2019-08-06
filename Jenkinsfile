def packageName = "${env.JOB_NAME}"
def buildNumber = "${env.BUILD_NUMBER}"
def namespace = "axway-aus"
def artifactoryURL = "http://jfrog.dev.axway-aus.de:80/artifactory/axway-aus/apibuilder/"
def zippedContents = "api-sample.tar.gz"

pipeline {
  agent any
  
  stages {
      stage('Checkout') {
        steps {
            checkout scm
            sh """
				ls -al
				pwd
				
				chmod +x ./scripts/upload2dockerhub.sh
                ./scripts/upload2dockerhub.sh ${namespace} ${packageName} ${buildNumber} ${zippedContents} ${artifactoryURL}
				
				ls -al /tmp/
            """            
          }        
      }
	  stage('RUN Unit Tests'){
		steps {
		 echo 'RUN Unit Tests'
		}
	  }
	  stage('Docker Build, Push'){
		steps {
		 echo 'Docker Build, Push'
		 
			// This step should not normally be used in your script. Consult the inline help for details.
			//withDockerRegistry(credentialsId: 'dockerhub-axway', url: 'https://index.docker.io/v1/') {
				//dockerImage.push()
			//}
		 
		}
		
	  }

	  stage('Remove Unused docker image') {
		  steps{
			echo 'Remove Unused docker image'
		  }
		}
	  
	  stage('Deploy on K8s'){
		steps {
		 echo 'Deploy on K8s'
		 sshagent (credentials: ['k8s-ssh-login']) {
                sh """
				  ssh -o StrictHostKeyChecking=no -l admin api.dev.axway-aus.de << EOF
					kubectl get po

                    exit
                  EOF
                  """
              }
		}
	  }
	  
	  stage('Cleanup') {
		  steps{
		    echo 'Cleanup temp folder'
			
		  }
		}

  }
  
}