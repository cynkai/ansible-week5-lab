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

        stage('Syntax check') {
            steps {
                sh 'ansible-playbook -i "$INV" site.yml --syntax-check'
            }
        }

        stage('Diagnose key') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'ansible-ssh', keyFileVariable: 'SSH_KEY')]) {
                    sh '''
                        ls -l "$SSH_KEY"
                        head -1 "$SSH_KEY"
                        tail -1 "$SSH_KEY"
                        printf 'last byte: '; tail -c 1 "$SSH_KEY" | od -An -c
                        printf 'CR count: '; tr -cd '\\r' < "$SSH_KEY" | wc -c
                        wc -l < "$SSH_KEY"
                        ssh-keygen -l -f "$SSH_KEY" || true
                    '''
                }
            }
        }

        stage('Ping') {
            steps {
                withCredentials([
                    sshUserPrivateKey(credentialsId: 'ansible-ssh', keyFileVariable: 'SSH_KEY'),
                    file(credentialsId: 'ansible-vault-dev', variable: 'VAULT_PASS')
                ]) {
                    sh 'ansible all -i "$INV" -m ping --private-key "$SSH_KEY" --vault-id dev@"$VAULT_PASS"'
                }
            }
        }

        stage('Converge') {
            steps {
                withCredentials([
                    sshUserPrivateKey(credentialsId: 'ansible-ssh', keyFileVariable: 'SSH_KEY'),
                    file(credentialsId: 'ansible-vault-dev', variable: 'VAULT_PASS')
                ]) {
                    sh 'ansible-playbook -i "$INV" site.yml --private-key "$SSH_KEY" --vault-id dev@"$VAULT_PASS"'
                }
            }
        }
    }
}
