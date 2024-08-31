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
            steps {
                sh 'pip3 install semgrep'
            }
        }
    }
}
