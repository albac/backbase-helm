#!groovy
import groovy.json.JsonOutput

// Global & Input Variables 
REGION = 'us-east-1'
REGISTRY_URL = '197398802565.dkr.ecr.us-east-1.amazonaws.com' //AWS-ECR Registry URL
IMAGE_NAME = 'backbase-tomcat' // Global Docker Image & App Name
REPO_URL = 'https://github.com/zerosinitiative/backbase-helm.git' // Repositroy URL of the JOB
TAG = 'latest'
TOPIC_ARN = 'arn:aws:sns:us-east-1:197398802565:backbase-build-notif'

// Pipeline Starts ------------------------------------------------------------------------------------------------------------------------
pipeline{
    agent any
    stages{
        stage("Docker Login To ECR"){
            steps{
                dockerLogin()
            }
        }
        stage("Docker Build Image") {
            steps {
                dockerBuildImage()
            }
        }
        stage("Docker Image Tag") {
            steps {
                dockerTag()
            }
        }
        stage("Docker Image Scanning") {
            steps {
                dockerImageScanning()
            }
        }
        stage("Docker Push To ECR") {
            steps {
                dockerImagePushToECR()
            }
        }
        stage("Deploy Helm App") {
            steps {
                deployHelmApp()
            }
        }
        stage("Cleanup") {
            steps { sh('docker image prune -af') }
        }
    }
}  
// Pipeline Ends ------------------------------------------------------------------------------------------------------------------------

// Docker Building and Pushing the Image to AWS-ECR 

def dockerLogin() {
    sh(script:"aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${REGISTRY_URL}")
}

def dockerBuildImage() {
    sh(script:"docker build -t ${IMAGE_NAME} .")
}

def dockerTag() {
    sh(script:"docker tag ${IMAGE_NAME}:${TAG} ${REGISTRY_URL}/${IMAGE_NAME}:${TAG}")
}

def dockerImageScanning() {
    sh(script:"trivy image ${REGISTRY_URL}/${IMAGE_NAME}:${TAG}")
}

def dockerImagePushToECR() {
    sh(script:"docker push ${REGISTRY_URL}/${IMAGE_NAME}:${TAG}")
}

def deployHelmApp(){
    sh(script:"helm upgrade --wait --atomic --install ${IMAGE_NAME} .")
}

def notifySNS(){
    sh(script: "aws sns publish --region ${REGION} --topic-arn ${TOPIC_ARN} --message '${env.STAGE_NAME} Successful'")
}
