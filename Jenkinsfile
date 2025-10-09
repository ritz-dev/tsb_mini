pipeline {
    agent any

    environment {
        FLUTTER_IMAGE = 'ghcr.io/cirruslabs/flutter:3.24.0'
        GIT_CREDENTIALS = credentials('github-credentials')
        PROJECT_NAME = 'my_flutter_app'
    }

    triggers {
        githubPush()
    }

    options {
        timestamps()
        buildDiscarder(logRotator(numToKeepStr: '10'))
    }

    stages {

        stage('Checkout') {
            steps {
                // Wrap inside ansiColor step here
                ansiColor('xterm') {
                    script {
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

                        def tagName = sh(script: "git describe --tags --exact-match 2>/dev/null || echo ''", returnStdout: true).trim()
                        if (!tagName) {
                            error("This pipeline only runs on tag push events. No tag found.")
                        }

                        env.TAG_NAME = tagName
                        echo "Triggered by tag: ${TAG_NAME}"
                    }
                }
            }
        }

        stage('Flutter Build') {
            steps {
                ansiColor('xterm') {
                    sh """
                    docker pull ${FLUTTER_IMAGE}
                    docker run --rm -v \$(pwd):/app -w /app ${FLUTTER_IMAGE} flutter pub get
                    docker run --rm -v \$(pwd):/app -w /app ${FLUTTER_IMAGE} flutter build apk --release
                    """
                }
            }
        }

        stage('Archive') {
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
