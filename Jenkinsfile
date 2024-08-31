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
            sh '''
               docker run --rm -v "${PWD}:/src" returntocorp/semgrep semgrep --config=auto .
               '''
            }
        }
    }
}
