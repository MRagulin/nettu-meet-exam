curl -s --insecure -XPOST "https://s410-exam.cyber-ed.space:8083/api/v2/product_types/" \
          -H "Content-Type: application/json" \
          -H "Authorization: Token <token>" \
		      -d '{"name":"mragulin"}'

  stage('Upload Semgrep Report to DefectDojo') {
            steps {
                script {
                    sh '''
                    curl -k -X 'POST' 'https://s410-exam.cyber-ed.space:8083/api/v2/import-scan/' \
                      -H "accept: application/json" \
                      -H "Content-Type: multipart/form-data" \
                      -H "Authorization: Token <token>"  \
                      -F "file=@semgrep-report.json" \
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
