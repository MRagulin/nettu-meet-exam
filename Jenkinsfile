pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                sh '''
                ls -lah
                '''
            }
        }

        stage('Semgrep-Scan') {
            agent { 
                label 'alpine' 
            } 
            steps {
                sh 'pip3 install semgrep'
            }
        }
    }
}
