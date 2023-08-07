pipeline {
    agent {label 'linux'}

    environment {
        docker_image="petclinic:${env.BUILD_ID}"
    }
    
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

        stage('Build docker image') {
            steps {
                sh 'cd /var/lib/jenkins/.m2/repository/org/springframework/samples/spring-petclinic/3.1.0-SNAPSHOT/'
                sh 'cp ${workspace}/Dockerfile .'
                sh 'docker build -t ${docker_image} -p .'
            }
        }
    }
}
