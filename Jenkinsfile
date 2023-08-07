pipeline {
    agent {label 'linux'}

    environment {
        docker_image="petclinic:${env.BUILD_ID}"
        source="${WORKSPACE}/Dockerfile"
        destination="/var/lib/jenkins/.m2/repository/org/springframework/samples/spring-petclinic/3.1.0-SNAPSHOT/"
        DOCKER_PASSWORD=credentials('DOCKERHUB_CREDS')
        dockerhub_repo="sharath2787"
        DOCKER_USERNAME="sharath2787"
    }
    
    stages {
        /*stage('Git Checkout') {
            steps {
                git branch: 'main',
                credentialsId: 'github-creds',
                url: 'https://github.com/sharathsl/spring-petclinic-youtube-project.git'
            }
        }*/
        
        stage('Build Maven package') {
            steps {
                sh '/usr/local/src/apache-maven/bin/mvn clean install'
            }
        }

        stage('Build docker image') {
            steps {
                sh 'cp -p ${source} ${destination}'
                sh 'cd ${destination}; sudo docker build -t ${docker_image} .'
            }
        }
        
        stage('Dockerhub login') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | sudo docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }

        stage('Push docker image') {
            steps {
                sh 'sudo docker tag ${image_name}:${env.BUILD_ID} ${dockerhub_repo}/${image_name}:${docker_tag}'
                sh 'sudo docker push ${dockerhub_repo}/${image_name}:${docker_tag}'
            }
        }
    }
}
