pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/MRagulin/nettu-meet-exam.git'
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
