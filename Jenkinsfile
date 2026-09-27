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
