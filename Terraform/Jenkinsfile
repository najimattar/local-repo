pipeline{
     agent{
         label "jenkins-agent1"
     }
    
    stages{
        stage("Checkout"){
            steps{
		
                echo "checkout complete"
            }
        }
        stage("terraform init"){
            steps{
                echo "terraform initializing.."
		sh 'terraform init'
            }
        }
        stage("terraform validate"){
            steps{
		sh 'terraform validate'
                echo "validation process running"
            }
        }
        stage("terraform workspace select agent2"){
            steps{
		sh 'terraform workspace select agent2 || terraform workspace new agent2'
                echo "you are in agent2 workspace"
            }
        }
        stage("terraform plan"){
            steps{
                sh "terraform plan"
            }
        }
        stage("apply"){
            steps{
                sh "terraform applying"
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
