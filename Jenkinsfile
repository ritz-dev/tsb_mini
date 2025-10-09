pipeline {
    agent any

    environment {
        FLUTTER_IMAGE = 'ghcr.io/cirruslabs/flutter:3.24.0'
        GIT_CREDENTIALS = credentials('github-credentials')
        PROJECT_NAME = 'tsb_mini'
    }

    triggers {
        githubPush()
    }

    options {
        timestamps()
        buildDiscarder(logRotator(numToKeepStr: '10'))
        // Removed ansiColor here — it causes compilation errors if plugin not installed
    }

    stages {

        stage('Checkout') {
            steps {
                script {
                    // Fetch all branches and tags
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

                    // Ensure pipeline is triggered by a tag
                    def tagName = sh(script: "git describe --tags --exact-match 2>/dev/null || echo ''", returnStdout: true).trim()
                    if (!tagName) {
                        error("This pipeline only runs on tag push events. No tag found.")
                    }

                    env.TAG_NAME = tagName
                    echo "Triggered by tag: ${TAG_NAME}"
                }
            }
        }

        stage('Flutter Setup & Dependencies') {
            steps {
                sh """
                docker pull ${FLUTTER_IMAGE}
                docker run --rm -v \$(pwd):/app -w /app ${FLUTTER_IMAGE} flutter --version
                docker run --rm -v \$(pwd):/app -w /app ${FLUTTER_IMAGE} flutter pub get
                """
            }
        }

        stage('Build APK') {
            steps {
                sh """
                docker run --rm -v \$(pwd):/app -w /app ${FLUTTER_IMAGE} flutter build apk --release
                """
            }
        }

        stage('Archive Artifacts') {
            steps {
                archiveArtifacts artifacts: 'build/app/outputs/flutter-apk/*.apk', fingerprint: true
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
