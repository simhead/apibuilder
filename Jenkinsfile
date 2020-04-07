def packageName = "${env.JOB_NAME}"
def buildNumber = "${env.BUILD_NUMBER}"
def namespace = "${IstioApicNamespace}"
def artifactoryURL = "${ArtifactoryURL}"
def zippedContents = "api-sample.tar.gz"
def extractDir = "api-sample"
def apiname="${APIname}"
def imageName="${DockerImageName}"
def yamllocation="yaml"
def artifactorylogin="${ArtifactoryLogin}"

pipeline {
  agent any
  
  stages {
      stage('Checkout') {
        steps {
            checkout scm
            sh """
				pwd
				chmod +x ./scripts/upload2artifactory.sh
                ./scripts/upload2artifactory.sh ${namespace} ${apiname} ${imageName} ${yamllocation} ${artifactorylogin} ${buildNumber} ${artifactoryURL}
				
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
			 sshagent (credentials: ['k8s-ssh-login']) {
					sh """
					  ssh -o StrictHostKeyChecking=no -l admin api.dev.axway-aus.de -p 10022 << EOF
						sudo docker images
						
						
						ls /tmp
						exit
					  EOF
					  """
				  
			}
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
				  
					curl -o /tmp/apibuilder-deploy.yaml ${artifactoryURL}/yaml/${buildNumber}/apibuilder-deploy.yaml
					
					ls -al /tmp
					
					kubectl delete deploy ${apiname} -n axway-aus
					kubectl delete svc ${apiname} -n axway-aus
					
					kubectl apply -f /tmp/apibuilder-deploy.yaml -n axway-aus
					
					ls -al /tmp
					kubectl get po -n axway-aus
					
					rm -rf /tmp/${extractDir}
					rm -f /tmp/${zippedContents}

                    exit
                  EOF
                  """
              }
		}
	  }
	  
	  stage('Cleanup') {
		  steps{
		    echo 'Cleanup temp folder'
			//rm -rf /tmp/*
		  }
		}

  }
  
}
