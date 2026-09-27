pipeline {
    agent { label 'ansible' }

    parameters {
        string(name: 'LIMIT', defaultValue: 'web', description: '대상 호스트/그룹 (필수)')
        string(name: 'TARGET_VERSION', defaultValue: '', description: '배포할 버전 (비우면 레포 값 사용)')
        string(name: 'TAGS', defaultValue: '', description: '실행할 태그 (비우면 전체)')
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

        stage('Lint') {
            steps {
                sh 'ansible-lint site.yml deploy.yml roles/'
            }
        }

    }
}
