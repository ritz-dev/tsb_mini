pipeline {
    agent any

    environment {
        // Docker image for Flutter build (use a valid, maintained image)
        FLUTTER_IMAGE = 'ghcr.io/cirruslabs/flutter:3.24.0'
        DOCKERHUB = credentials('dockerhub-credentials') // optional
        GIT_CREDENTIALS = credentials('github-credentials')
        PROJECT_NAME = 'tsb_mini'
    }

    triggers {
        // Trigger pipeline only when a new Git tag is pushed
        githubPush()
    }

    options {
        timestamps()
        ansiColor('xterm')
        buildDiscarder(logRotator(numToKeepStr: '10'))
    }

    stages {

        stage('Checkout') {
            steps {
                script {
                    // Fetch full history (including tags)
                    checkout([
                        $class: 'GitSCM',
                        branches: [[name: '**']],
                        doGenerateSubmoduleConfigurations: false,
                        extensions: [[$class: 'CloneOption', noTags: false, shallow: false]],
                        userRemoteConfigs: [[
                            url: 'https://github.com/ritz-dev/tsb_mini.git',
                            credentialsId: "${GIT_CREDENTIALS}"
                        ]]
                    ])

                    // Detect if triggered by a tag
                    def tagName = sh(script: "git describe --tags --exact-match 2>/dev/null || echo ''", returnStdout: true).trim()
                    if (!tagName) {
                        error("This pipeline only runs on tag push events. No tag found.")
                    }

                    env.TAG_NAME = tagName
                    echo "Triggered by tag: ${TAG_NAME}"
                }
            }
        }

        stage('Flutter Setup') {
            steps {
                script {
                    sh """
                    docker pull ${FLUTTER_IMAGE}
                    docker run --rm -v \$(pwd):/app -w /app ${FLUTTER_IMAGE} flutter --version
                    """
                }
            }
        }

        stage('Dependencies') {
            steps {
                script {
                    sh """
                    docker run --rm -v \$(pwd):/app -w /app ${FLUTTER_IMAGE} flutter pub get
                    """
                }
            }
        }

        stage('Build APK') {
            steps {
                script {
                    sh """
                    docker run --rm -v \$(pwd):/app -w /app ${FLUTTER_IMAGE} flutter build apk --release
                    """
                }
            }
        }

        stage('Build Web (optional)') {
            when {
                expression { fileExists('web/index.html') }
            }
            steps {
                script {
                    sh """
                    docker run --rm -v \$(pwd):/app -w /app ${FLUTTER_IMAGE} flutter build web --release
                    """
                }
            }
        }

        stage('Archive Artifacts') {
            steps {
                archiveArtifacts artifacts: 'build/app/outputs/flutter-apk/*.apk', fingerprint: true
                archiveArtifacts artifacts: 'build/web/**', fingerprint: true, allowEmptyArchive: true
            }
        }

        stage('Tag Deployment (optional)') {
            when {
                expression { env.TAG_NAME }
            }
            steps {
                echo "Deploying build for tag ${TAG_NAME}..."
                // Example: upload to Firebase, Play Store, or custom API
                // sh "firebase appdistribution:distribute build/app/outputs/flutter-apk/app-release.apk ..."
            }
        }
    }

    post {
        success {
            echo "✅ Build successful for tag ${TAG_NAME}"
        }
        failure {
            echo "❌ Build failed for tag ${TAG_NAME}"
        }
    }
}
