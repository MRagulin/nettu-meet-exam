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
            				sh '''docker pull returntocorp/semgrep && \ 
                docker run \
                -v "$(pwd):$(pwd)" --workdir $(pwd) \
              returntocorp/semgrep semgrep ci '''
            }
        }
    }
}
