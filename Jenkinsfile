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
            agent {label 'alpine'}
            steps {
                sh '''
			apk add --no-cache openjdk11-jre-headless wget unzip
                        wget https://github.com/zaproxy/zaproxy/releases/download/w2024-08-27/ZAP_WEEKLY_D-2024-08-27.zip
                        unzip ZAP_WEEKLY_D-2024-08-27.zip -d zap
                        pwd
                        zap/ZAP_D-2024-08-27/zap.sh -nostdout -cmd -quickurl https://s410-exam.cyber-ed.space:8084 -quickout ../../zap-result.json
			ls -la
   			ls -ls ../
      			ls -ls ../../
   
 		'''
		archiveArtifacts artifacts: '/root/zap-result.json', allowEmptyArchive: true
            }
        }
        
		

        
    }
}
