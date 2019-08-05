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

	  
	  stage('Deploy on K8s'){
		steps {
		 echo 'Deploy on K8s'
		 withKubeConfig(caCertificate: 'LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUMwekNDQWJ1Z0F3SUJBZ0lNRmJSRzhHaXdveHUwSVJaZE1BMEdDU3FHU0liM0RRRUJDd1VBTUJVeEV6QVIKQmdOVkJBTVRDbXQxWW1WeWJtVjBaWE13SGhjTk1Ua3dOekl5TURjeU1qUTRXaGNOTWprd056SXhNRGN5TWpRNApXakFWTVJNd0VRWURWUVFERXdwcmRXSmxjbTVsZEdWek1JSUJJakFOQmdrcWhraUc5dzBCQVFFRkFBT0NBUThBCk1JSUJDZ0tDQVFFQTN6WWpxY0VySTlXTVprSFhHaDBxNENJZm85MGV0a1B5anQ1U3NTRmFIeVduRXdMd2Zyb3oKZld5NDJQeDRIWm95cTZrZmxZQ0MxYUZyWEpYdlBSUXlYbFdpVVJjSjhwSEZNK05VOE52N3dsOHRhd0tiZi9ybQpNOHBlK2Y5czFlV1RFUHBqWUErNnBTeVFXVitnVlJMcGFHMWtaYlI4VDhJalc1Z2VaK2NnY0RncXJtTndmZTlrCmlENDN5MDgyUXlIWXFreVExRmZmTWV2QVJWY2ovb3o0NTRrNkRoTXJnTW44WWhrRTJXQzNycDlXZ0tzN2QvRlEKMDVscVlITTI4NTdyQWh5YkJtR2xRWFk1VGUwN0ZCM2FrZ0RYbUdJVnFJVEZqNFAyTjhES3cwYjRRZE9HVnF4UApFRGVxWGVqMUgxamlhWG1sTk9xOGdEMG5GeU9QdDFFYW93SURBUUFCb3lNd0lUQU9CZ05WSFE4QkFmOEVCQU1DCkFRWXdEd1lEVlIwVEFRSC9CQVV3QXdFQi96QU5CZ2txaGtpRzl3MEJBUXNGQUFPQ0FRRUFVazYyQkJHWkszRXQKVTN4N2M5RDFjVmV0Wkd4NHhMR2dlYWlOR2pBNHZlOUtaR2trMk9EaTB6aWJ0SFlydUhDbWhSV0Y2TURoYXhoMApOOFZqZFVQdlJaanJYcmxyYlo3bTdvK0FFdityYVkwTmo4a2dDQmRud042MzVWWEJuRGZnRzJPdTd2V2FsMjAyCkh0L0JyOUo0OUhoaUVQUmNmaEtqTlYyVmFWV1lGTlRQbmltRHdhNWN4eHZCK3BjdGVHdjRLbUF6Ymh5ZTNGeDcKa3ZhSEFrUHAyN0RFMFo4WUtTTjNYbm9mS3RmV1VkSGNRWldqVHNjWTV3YVU0S04zOGxvTTNqQ2UxcS8vdnJNYQo4RFhoTmNUbHNnQXpFS3prZkFJTGRGYXVvNkhOZFBxVWYwT1VsOGRYOWpKN1FUMnoyNERhY1J6R2hVdUNjRnpVCm82MEdIYWVvK1E9PQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==', clusterName: 'dev.axway-aus.de', contextName: 'dev.axway-aus.de', credentialsId: '', namespace: 'axway-aus', serverUrl: 'https://api.dev.axway-aus.de') {
				sh 'kubectl get pods'
			}
		}
	  }
  }
  
}