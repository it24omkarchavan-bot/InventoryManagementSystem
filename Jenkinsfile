pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                bat 'mvn clean package'
            }
        }

        stage('Archive WAR') {
            steps {
                archiveArtifacts artifacts: 'target/*.war', fingerprint: true
            }
        }

        stage('Docker Build') {
            steps {
                bat 'docker build -t inventory-management-system:latest .'
            }
        }
    }

    post {
        success {
            echo 'Inventory Management System pipeline completed successfully.'
        }
        failure {
            echo 'Pipeline failed. Check the console log.'
        }
    }
}
