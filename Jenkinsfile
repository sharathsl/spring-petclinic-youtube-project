pipeline {
    agent {label 'linux'}
    
    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'main',
                credentialsId: 'github-creds',
                url: 'https://github.com/sharathsl/spring-petclinic-youtube-project.git'
            }
        }
        
        stage('Build Maven package') {
            steps {
                sh '/usr/local/src/apache-maven/bin/mvn clean install'
            }
        }
    }
}
