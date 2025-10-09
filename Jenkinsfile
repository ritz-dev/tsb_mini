pipeline {
    agent {
        // Use official Flutter Docker image with Android SDK built-in
        docker {
            image 'cirrusci/flutter:3.19.0'
            args '-u root' // Run as root to allow installing tools if needed
        }
    }

    environment {
        APP_NAME       = 'tsb-mini'
        DOCKER_IMAGE   = 'akayti/finance'
        DOCKERHUB      = credentials('dockerhub-credentials')
        GITHUB_CREDENTIALS = credentials('github-credentials')
        BUILD_OUTPUT   = 'build/app/outputs/flutter-apk/app-release.apk'
    }

    triggers {
        // Auto-trigger on tag push
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

                // Capture tag name for later use
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
                echo '📦 Archiving release APK...'
                archiveArtifacts artifacts: "${BUILD_OUTPUT}", fingerprint: true
                echo "✅ Archived ${BUILD_OUTPUT}"
            }
        }

        stage('Optional: Docker Push') {
            when {
                expression { env.GIT_TAG != 'untagged' }
            }
            steps {
                echo "🐳 Building and pushing Docker image for ${env.GIT_TAG}..."
                sh '''
                    docker build -t ${DOCKER_IMAGE}:${GIT_TAG} .
                    echo "${DOCKERHUB_PSW}" | docker login -u "${DOCKERHUB_USR}" --password-stdin
                    docker push ${DOCKER_IMAGE}:${GIT_TAG}
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Build and deployment succeeded for tag: ${env.GIT_TAG}"
        }
        failure {
            echo "❌ Pipeline failed for tag: ${env.GIT_TAG}. Check logs above."
        }
        always {
            cleanWs() // Clean workspace to save disk space
        }
    }
}
