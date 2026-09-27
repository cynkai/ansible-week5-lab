pipeline {
    agent { label 'ansible' }
    parameters {
        string(name: 'VERSION', defaultValue: '1.0', description: '배포 버전')
    }
    stages {
        stage('A. Vulnerable (Groovy 큰따옴표 보간)') {
            steps {
                sh """
                    echo "받은 버전: ${params.VERSION}"
                """
            }
        }
        stage('B. Safe (셸 작은따옴표 + env)') {
            steps {
                withEnv(["VERSION=${params.VERSION}"]) {
                    sh '''
                        echo "받은 버전: $VERSION"
                    '''
                }
            }
        }
    }
}
