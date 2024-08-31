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

        stage('SAST-Semgrep-Scan') {
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

        stage('DAST-Zap-Scan') {
            agent {label 'alpine'}
            steps {
		    /*
                sh '''
			apk add --no-cache openjdk11-jre-headless wget unzip
                        wget https://github.com/zaproxy/zaproxy/releases/download/w2024-08-27/ZAP_WEEKLY_D-2024-08-27.zip
                        unzip ZAP_WEEKLY_D-2024-08-27.zip -d zap
                        pwd
                        zap/ZAP_D-2024-08-27/zap.sh -nostdout -cmd -quickurl https://s410-exam.cyber-ed.space:8084 -quickout ../../zap-result.json
 		'''
   		*/
		    sh 'echo "DAST-Zap-Scan"'
		// archiveArtifacts artifacts: 'zap-result.json', allowEmptyArchive: true
            }
        }

	    stage('CS-Trivy') {
                    agent { label 'dind' }
                    steps {
                        sh '''
			    ls -la /etc/docker/
       			    sudo chmod a+w /etc/docker/daemon.json 2>/dev/null
       			    sudo echo '{' >> /etc/docker/daemon.json
  			    sudo echo '"registry-mirrors": [' >> /etc/docker/daemon.json
     			    sudo echo '"https://hub-mirror.c.163.com",' >> /etc/docker/daemon.json
    			    sudo echo '"https://mirror.baidubce.com"  ]}"' >> /etc/docker/daemon.json
	   		    sudo /etc/init.d/docker restart 2>/dev/null
                            docker run -v ./report:/report aquasec/trivy repo https://github.com/MRagulin/nettu-meet-exam -f json -o /report/trivy.json 
                            ls -l ./report
                            '''
                        archiveArtifacts allowEmptyArchive: true, artifacts: 'report/trivy.json'
                    }
                }

	    stage('SCA-DepTrack'){
            steps {
                script{
                    sh '''
                        curl -sSfL https://raw.githubusercontent.com/anchore/syft/main/install.sh | sh -s -- -b /usr/local/bin
                        syft dir:$(pwd) -o cyclonedx-json > sbom.json
                    '''
                    sh '''
                        curl -k -X 'PUT' 'https://s410-exam.cyber-ed.space:8081/api/v1/project' \
                             -H 'accept: application/json' \
                             -H 'X-API-Key: odt_SfCq7Csub3peq7Y6lSlQy5Ngp9sSYpJl' \
                             -H 'Content-Type: application/json' \
                             -d '{
                                   "name": "mragulin",
                                   "version": "1.0.0",
                                   "description": "exam-project"
                                 }'
                        '''
                    sh '''
                        curl -k -X 'POST' 'https://s410-exam.cyber-ed.space:8081/api/v1/bom' \
                        -H 'accept: application/json' \
                        -H 'Content-Type: multipart/form-data'\
                        -H 'X-API-Key: odt_SfCq7Csub3peq7Y6lSlQy5Ngp9sSYpJl' \
                        -F 'projectName=mragulin' \
                        -F 'projectVersion=1.0.0' \
                        -F 'bom=@sbom.json'
                        '''    
			archiveArtifacts artifacts: 'sbom.json', allowEmptyArchive: true			
                }
            }
		}


	   stage('Upload-Reports-To-DefectDojo') {
            steps {
                script {
                    sh '''
                    curl -k -X 'POST' 'https://s410-exam.cyber-ed.space:8083/api/v2/import-scan/' \
                      -H "accept: application/json" \
                      -H "Content-Type: multipart/form-data" \
                      -H "Authorization: Token c5b50032ffd2e0aa02e2ff56ac23f0e350af75b4"  \
                      -F "file=@semgrep-result.json" \
                      -F "minimum_severity=High" \
                      -F "product_name=mragulin" \
                      -F "product_type_name=mragulin" \
                      -F "auto_create_context=True" \
                      -F "scan_type=Semgrep JSON Report" \
                      -F "engagement_name=mragulin" \
                      -F "active=true" \
                      -F "verified=true" \
                      -F "test_title=mragulin" \
                      -F "close_old_findings=true" \
                      -F "close_old_findings_product_scope=true" \
                      -F "scan_date=$(date +%F)"
                    '''
                }
            }
        }

	 stage('Check Vulnerabilities') {
            steps {
                script {
                    def response = sh(
                        script: """
                            curl -s -H "Authorization: Token c5b50032ffd2e0aa02e2ff56ac23f0e350af75b4" \
                            "https://s410-exam.cyber-ed.space/api/v2/findings/?engagement_name=mragulin"
                        """,
                        returnStdout: true
                    ).trim()

                    def findings = readJSON(text: response.content).results

                    def hasHighOrCritical = findings.any { finding ->
                        finding.severity in ['High', 'Critical']
                    }

                    if (hasHighOrCritical) {
                        error "Pipeline failed due to High or Critical vulnerabilities."
                    } else {
                        echo "No High or Critical vulnerabilities found."
                    }
                }
            }
        }    
        
		

        
    }
}
