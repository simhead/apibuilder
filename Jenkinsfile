def packageName = "${env.JOB_NAME}"
def buildNumber = "${env.BUILD_NUMBER}"
def namespace = "axway-aus"

pipeline {
  agent any
  
  stages {
      stage('Checkout') {
        steps {
            checkout scm
            sh """
				ls -al
				pwd
				
				chmod +x ./scripts/getallpods.sh
                #./scripts/getallpods.sh ${namespace}
				
				
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
				// some block
			//}
		 
		}
		
	  }
	  
	  stage('Run kubectl') {
		steps {
		  container('kubectl') {
			sh "kubectl get pods"
		  }
		}
	  }
	  
	  stage('Deploy on K8s'){
		steps {
		 echo 'Deploy on K8s'
		}
	  }
  }
  
}