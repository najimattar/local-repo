pipeline{
     agent{
         label "jenkins-agent1"
     }
    
    stages{
        
        stage("terraform init"){
            steps{
				dir ('Terraform'){
               		 echo "terraform initializing.."
						sh 'terraform init'
				}
            }
        }
        stage("terraform validate"){
            steps{
				dir ('Terraform'){
					sh 'terraform validate'
                	echo "validation process running"
				}
            }
        }
        stage("terraform workspace select agent2"){
            steps{
				dir ('Terraform'){
					sh 'terraform workspace select agent2 || terraform workspace new agent2'
                	echo "you are in agent2 workspace"
				}
			}
        }
        stage("terraform plan"){
            steps{
				dir ('Terraform'){
                	sh "terraform plan"
            	}
			}
        }
        stage("apply"){
            steps{
				dir ('Terraform'){
                	sh "terraform apply --auto-approve"
				}
            }
		
        }
		stage('destroy'){
		steps{
			dir('Terraform'){
				sh 'bash destroy-agent2.sh'
			}	
		}	
	}
    }
    
    post {
        success {
            echo "successfully build"
        }
        failure {
            echo "deployment failed"
        }
    }
    
    
}
