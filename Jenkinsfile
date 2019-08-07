def packageName = "${env.JOB_NAME}"
def buildNumber = "${env.BUILD_NUMBER}"
def namespace = "axway-aus"
def artifactoryURL = "http://jfrog.dev.axway-aus.de:80/artifactory"
def zippedContents = "api-sample.tar.gz"
def extractDir = "api-sample"
def apiname="apibuilder-sample"
def imageName="apibuilder-sample:latest"
def yamllocation="yaml"
def artifactorylogin="admin:AP8xVGFtnJQM6LBvivkyGvVGAyi"

pipeline {
  agent any
  
  stages {
      stage('Checkout') {
        steps {
            checkout scm
            sh """
				pwd
				chmod +x ./scripts/upload2artifactory.sh
                ./scripts/upload2artifactory.sh ${namespace} ${apiname} ${imageName} ${yamllocation} ${artifactorylogin} ${buildNumber}
				
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
					  ssh -o StrictHostKeyChecking=no -l admin api.dev.axway-aus.de << EOF
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
				  
					echo 'curl -o /tmp/api-sample.tar.gz ${artifactoryURL}/axway-aus/apibuilder/${zippedContents}'
					curl -o /tmp/api-sample.tar.gz ${artifactoryURL}/axway-aus/apibuilder/${zippedContents}
					curl -o /tmp/apibuilder-deploy.yaml http://jfrog.dev.axway-aus.de:80/artifactory/axway-aus/apibuilder/yaml/${buildNumber}/apibuilder-deploy.yaml
					curl -o /tmp/apibuilder-gw.yaml http://jfrog.dev.axway-aus.de:80/artifactory/axway-aus/apibuilder/yaml/${buildNumber}/apibuilder-gw.yaml
					curl -o /tmp/apibuilder-vs.yaml http://jfrog.dev.axway-aus.de:80/artifactory/axway-aus/apibuilder/yaml/${buildNumber}/apibuilder-vs.yaml
					
					tar -zxf /tmp/${zippedContents}
					ls -al /tmp
					
					cd /tmp/${extractDir}
					sudo docker build -t ${imageName} .
					
					kubectl delete deploy ${apiname} -n axway-aus
					kubectl delete svc ${apiname} -n axway-aus
					
					kubectl apply -f /tmp/apibuilder-deploy.yaml -n axway-aus
					kubectl apply -f /tmp/apibuilder-gw.yaml -n axway-aus
					kubectl apply -f /tmp/apibuilder-vs.yaml -n axway-aus
					ls -al /tmp
					kubectl get po -n axway-aus

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