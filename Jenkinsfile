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
                apk add --no-cache python3 py3-pip py3-virtualenv
                python3 -m venv semgrepenv
                . semgrepenv/bin/activate
                pip  install semgrep
                semgrep --config=auto . --json > semgrep-result.json
                ls -la
                '''
                archiveArtifacts artifacts: 'semgrep-result.json', allowEmptyArchive: true
            }
        }
    }
}
