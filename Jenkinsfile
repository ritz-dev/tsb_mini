pipeline {
    agent {
        // Use official Flutter Docker image with Android SDK preinstalled
        docker {
            image 'cirrusci/flutter:3.19.0'
            args '-u root'
        }
    }

    environment {
        APP_NAME       = 'tsb-mini'
        BUILD_OUTPUT   = 'build/app/outputs/flutter-apk/app-release.apk'
        GITHUB_CREDENTIALS = credentials('github-credentials')
    }

    triggers {
        // Trigger only when a tag is pushed to GitHub
        githubPush()
    }

    options {
        timestamps()
        disableConcurrentBuilds()
    }

    stages {

        stage('Checkout') {
            steps {
                echo '📥 Checking out source code...'
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: "refs/tags/*"]],
                    userRemoteConfigs: [[
                        url: 'https://github.com/ritz-dev/tsb_mini.git',
                        credentialsId: 'github-credentials'
                    ]],
                    extensions: [
                        [$class: 'CloneOption', noTags: false, shallow: false]
                    ]
                ])

                // Detect current tag
                script {
                    env.GIT_TAG = sh(script: "git describe --tags --abbrev=0 || echo 'untagged'", returnStdout: true).trim()
                }
                echo "✅ Checked out tag: ${env.GIT_TAG}"
            }
        }

        stage('Dependencies') {
            steps {
                echo '📦 Installing Flutter dependencies...'
                sh '''
                    flutter --version
                    flutter pub get
                '''
            }
        }

        stage('Analyze') {
            steps {
                echo '🔍 Running static code analysis...'
                sh 'flutter analyze'
            }
        }

        stage('Test') {
            steps {
                echo '🧪 Running unit tests...'
                sh 'flutter test'
            }
        }

        stage('Build APK') {
            steps {
                echo '🏗️ Building Flutter release APK...'
                sh '''
                    flutter clean
                    flutter build apk --release
                    ls -lh build/app/outputs/flutter-apk/
                '''
            }
        }

        stage('Archive') {
            steps {
                echo '📦 Archiving built APK...'
                archiveArtifacts artifacts: "${BUILD_OUTPUT}", fingerprint: true
                echo "✅ APK archived successfully: ${BUILD_OUTPUT}"
            }
        }
    }

    post {
        success {
            echo "✅ Build completed successfully for tag: ${env.GIT_TAG}"
        }
        failure {
            echo "❌ Pipeline failed for tag: ${env.GIT_TAG}. Check logs above for details."
        }
        always {
            cleanWs() // Clean up workspace after each build
        }
    }
}