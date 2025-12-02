pipeline {
    agent { label "vinod" }

    environment {
        IMAGE_NAME = "notes-app"
        DOCKER_HUB_REPO = "notes-app"
    }

    stages {

        stage("Clone Code") {
            steps {
                git url: "https://github.com/sgajbhiye96/jenkins.git", branch: "main"
            }
        }

        stage("Build Docker Image") {
            steps {
                sh "docker build -t ${IMAGE_NAME}:latest ."
            }
        }

        stage("Push to Docker Hub") {
            steps {
                echo "Pushing image to Docker Hub..."

                withCredentials([
                    usernamePassword(
                        credentialsId: "dockerHubCred",
                        usernameVariable: "dockerHubUser",
                        passwordVariable: "dockerHubPass"
                    )
                ]) {
                    sh '''
                        echo "${dockerHubPass}" | docker login -u "${dockerHubUser}" --password-stdin
                        docker tag notes-app:latest ${dockerHubUser}/notes-app:latest
                        docker push ${dockerHubUser}/notes-app:latest
                    '''
                }
            }
        }

        stage("Deploy") {
            steps {
                echo "Deploying container..."

                // Stop & remove old container if running
                sh '''
                    docker stop notes-app || true
                    docker rm notes-app || true
                '''

                // Start new container using Docker Compose v2
                sh '''
                    docker compose down || true
                    docker compose up -d
                '''
            }
        }
    }
}
