pipeline {
    agent any
 
    parameters {
        choice(name: 'ACTION', choices: ['plan','apply','destroy'], description: 'Acción de Terraform')
    }
 
    environment {
        GCP_CREDENTIALS = credentials('gcp-sa-key')
        PROJECT_ID = "jenkins-terraform-demo-472920"
    }
 
    stages {
        stage('Init') {
            steps {
                sh 'terraform init -input=false'
            }
        }
        stage('Terraform Action') {
            steps {
                withEnv(["GOOGLE_APPLICATION_CREDENTIALS=${GCP_CREDENTIALS}"]) {
                    sh """
                    terraform ${params.ACTION} -auto-approve \
                      -var='project=${PROJECT_ID}' \
                      -var='credentials_file=${GCP_CREDENTIALS}'
                    """
                }
            }
        }
    }
 
    post {
        success {
            echo "SQL Server ${params.ACTION} completado correctamente"
        }
        failure {
            echo "Error en Terraform"
        }
    }
}
