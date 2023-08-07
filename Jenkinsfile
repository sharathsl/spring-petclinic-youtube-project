pipeline {
    agent {label 'linux'}

    environment {
        docker_image="petclinic"
        docker_tag="${env.BUILD_ID}"
        source="${WORKSPACE}/Dockerfile"
        destination="/var/lib/jenkins/.m2/repository/org/springframework/samples/spring-petclinic/3.1.0-SNAPSHOT/"
        DOCKER_PASSWORD=credentials('DOCKERHUB_CREDS')
        dockerhub_repo="sharath2787"
        DOCKER_USERNAME="sharath2787"
    }
    
    stages {
        stage('Build Maven package') {
            steps {
                sh '/usr/local/src/apache-maven/bin/mvn clean install'
            }
        }

        stage('Build docker image') {
            steps {
                sh 'cp -p ${source} ${destination}'
                sh 'cd ${destination}; sudo docker build -t ${docker_image}:${docker_tag} .'
            }
        }
        
        stage('Dockerhub login') {
            steps {
                sh 'echo $DOCKER_PASSWORD |sudo docker login -u $DOCKER_USERNAME --password-stdin'
            }
        }

        stage('Push docker image') {
            steps {
                sh 'sudo docker tag ${docker_image}:${docker_tag} ${dockerhub_repo}/${docker_image}:${docker_tag}'
                sh 'sudo docker push ${dockerhub_repo}/${docker_image}:${docker_tag}'
            }
        }
    }
}
