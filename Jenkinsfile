pipeline {
    agent { label 'ansible' }

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

        stage('Lint') {
            steps {
                sh 'ansible-lint site.yml deploy.yml roles/'
            }
        }

        stage('A. sh 방식') {
            steps {
                withCredentials([
                    sshUserPrivateKey(credentialsId: 'ansible-ssh', keyFileVariable: 'SSH_KEY'),
                    file(credentialsId: 'ansible-vault-dev', variable: 'VAULT_PASS')
                ]) {
                    sh '''
                        ansible-playbook -i "$INV" deploy.yml \
                            --private-key "$SSH_KEY" --vault-id dev@"$VAULT_PASS" \
                            --limit green -e dry_run=false
                    '''
                }
            }
        }

        stage('B. ansiblePlaybook step 방식') {
            steps {
                withCredentials([
                    file(credentialsId: 'ansible-vault-dev', variable: 'VAULT_PASS')
                ]) {
                    ansiblePlaybook(
                        playbook: 'deploy.yml',
                        inventory: "${INV}",
                        credentialsId: 'ansible-ssh',
                        limit: 'green',
                        extraVars: [dry_run: 'false'],
                        extras: "--vault-id dev@${VAULT_PASS}",
                        colorized: true
                    )
                }
            }
        }
    }
}
