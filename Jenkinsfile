pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'akayti/finance'
        DOCKERHUB = credentials('dockerhub-credentials')
        GITHUB_CREDENTIALS = credentials('github-credentials')
    }

    triggers {
        // Trigger only on Git tag push
        githubPush()
    }

    stages {

        stage('Checkout') {
            steps {
                // Checkout all tags and branches
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: "refs/tags/*"]], // Important for tag builds
                    userRemoteConfigs: [[
                        url: 'https://github.com/ritz-dev/tsb_mini.git',
                        credentialsId: 'github-credentials'
                    ]],
                    extensions: [
                        [$class: 'CloneOption', noTags: false, shallow: false]
                    ]
                ])
            }
        }

        stage('Dependencies') {
            steps {
                sh 'flutter pub get'
            }
        }

        stage('Analyze') {
            steps {
                sh 'flutter analyze'
            }
        }

        stage('Test') {
            steps {
                sh 'flutter test'
            }
        }

        stage('Build APK') {
            steps {
                sh 'flutter build apk --release'
            }
        }

        stage('Archive') {
            steps {
                archiveArtifacts artifacts: 'build/app/outputs/flutter-apk/app-release.apk'
            }
        }
    }

    post {
        success {
            echo "✅ Deployment from tag ${env.GIT_TAG} completed successfully!"
        }
        failure {
            echo "❌ Pipeline failed for tag ${env.GIT_TAG}. Check logs."
        }
    }
}



