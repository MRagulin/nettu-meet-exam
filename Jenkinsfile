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
            agent { label 'alpine' } 
            steps {
                sh '''
                apk add --no-cache python3 py3-pip
                pip install semgrep
                semgrep --config=auto . --json > semgrep-result.json
                ls -la
                '''
            }
        }
    }
}
