pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                sh '''
                echo "Checking everythings - ok --> Start exam"
                ls -lah
                '''
            }
        }

        stage('Semgrep-Scan') {
            agent { label 'alpine' } 
            steps {
				sh 'echo "SAST as semgrep"'
         /*       sh '''
                apk add --no-cache python3 py3-pip py3-virtualenv
                python3 -m venv semgrepenv
                . semgrepenv/bin/activate
                pip  install semgrep
                semgrep --config=auto . --json > semgrep-result.json
                ls -la
                '''
                archiveArtifacts artifacts: 'semgrep-result.json', allowEmptyArchive: true
                 */
			}
        }

        stage('Zap-Scan') {
            agent {label 'dind'}
            steps {
                sh 'docker run -v \$(pwd)/:/zap/wrk/:rw -t zaproxy/zap-stable zap-baseline.py -I -t https://s410-exam.cyber-ed.space:8084 -J zap-result.json'
		archiveArtifacts artifacts: 'zap-result.json', allowEmptyArchive: true
            }
        }
        
		

        
    }
}
