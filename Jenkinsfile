// pipeline {
//     agent any

//     environment {
//         DOCKER_ID = credentials('DOCKER_ID')
//         DOCKER_PASSWORD = credentials('DOCKER_PASSWORD')
//     }

//     stages {
//         stage('Init') {
//             steps {
//                 echo 'Initializing..'
//                 echo "Running ${env.BUILD_ID} on ${env.JENKINS_URL}"
//                 echo "Current branch: ${env.BRANCH_NAME}"
//                 sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_ID --password-stdin'
//             }
//         }
//         stage('Build') {
//             steps {
//                 echo 'Building image..'
//                 sh 'docker build -t $DOCKER_ID/cotu:latest .'
//             }
//         }
//         stage('Test') {
//             steps {
//                 echo 'Testing..'
//                 sh 'docker run --rm -e CI=true $DOCKER_ID/cotu pytest'
//             }
//         }
//         stage('Publish') {
//             steps {
//                 echo 'Publishing image to DockerHub..'
//                 sh 'docker push $DOCKER_ID/cotu:latest'
//             }
//         }
//         stage('Cleanup') {
//             steps {
//                 echo 'Removing unused docker containers and images..'
//                 sh 'docker ps -aq | xargs --no-run-if-empty docker rm'
//                 // keep intermediate images as cache, only delete the final image
//                 sh 'docker images -q | xargs --no-run-if-empty docker rmi'
//             }
//         }
//     }
// }


pipeline {
    agent none
    environment {
        dockerhub=credentials('dockerhub')
    }
    stages {

        stage('Cloning our Git') { 
10          agent { label 'container' }
            steps { 
                git 'https://github.com/mohab58977/simple-node-app.git' 
            }
13
        } 
        stage('Build Node App in container') {
            agent { label 'container' }
            steps {
               sh 'echo Building..'
               withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'DOCKER_REGISTRY_PWD', usernameVariable: 'DOCKER_REGISTRY_USER')]) {
               sh "docker login -u $dockerhub_USR -p $dockerhub_PSW"
               sh 'docker build -t app .'
               sh 'docker tag app mohab5897/iti-lab1:v1'
               sh 'docker push mohab5897/iti-lab1:v1'
            }
            }
        }
        stage('Build Node App in instance') {
            agent { label 'instance' }
            steps {
               sh 'echo Building..'
               sh 'echo $dockerhub_PSW | docker login -u $dockerhub_USR --password-stdin'
               sh 'docker build -t app .'
               sh 'docker tag app mohab5897/iti-lab1:v1'
               sh 'docker push mohab5897/iti-lab1:v1'
            }
        }
    }

    post {
        success {
            echo 'This will run only if successful'
        }
    }
}