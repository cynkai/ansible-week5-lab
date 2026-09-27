pipeline {
    agent { label 'ansible' }

    parameters {
        string(name: 'LIMIT', defaultValue: 'web', description: '대상 호스트/그룹')
        string(name: 'TARGET_VERSION', defaultValue: '', description: '배포할 버전 (비우면 레포 값 사용)')
        booleanParam(name: 'DRY_RUN', defaultValue: true, description: '체크 시 배포 안 함')
    }

    options {
        timestamps()
        disableConcurrentBuilds()
    }

    environment {
        INV = 'inventory_ci.ini'
    }

    stages {
        stage('Install dependencies') {
            steps {
                sh 'ansible-galaxy collection install -r requirements.yml -p ./collections'
            }
        }

        stage('Deploy') {
            steps {
                withCredentials([
                    sshUserPrivateKey(credentialsId: 'ansible-ssh', keyFileVariable: 'SSH_KEY'),
                    file(credentialsId: 'ansible-vault-dev', variable: 'VAULT_PASS')
                ]) {
                    sh '''
                        EXTRA=""
                        if [ -n "$TARGET_VERSION" ]; then
                            EXTRA="-e app_version=$TARGET_VERSION"
                        fi
                        ansible-playbook -i "$INV" deploy.yml \
                            --private-key "$SSH_KEY" --vault-id dev@"$VAULT_PASS" \
                            --limit "$LIMIT" \
                            -e dry_run=$DRY_RUN \
                            $EXTRA
                    '''
                }
            }
        }
    }
}
