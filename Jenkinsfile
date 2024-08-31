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
                 docker { image 'python:3'}
                }
            steps {
                sh 'pip3 install semgrep'
            }
        }
    }
}
