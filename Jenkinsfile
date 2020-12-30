#!groovy
import groovy.json.JsonOutput

// Global & Input Variables 
REGION = 'us-east-1'
REGISTRY_URL = '197398802565.dkr.ecr.us-east-1.amazonaws.com' //AWS-ECR Registry URL
IMAGE_NAME = 'backbase-tomcat' // Global Docker Image Name
REPO_URL = 'https://github.com/zerosinitiative/backbase-helm.git' // Repositroy URL of the JOB

// Pipeline Starts ------------------------------------------------------------------------------------------------------------------------
pipeline{
    agent any
    stages{
        stage("Docker Build and Push"){
            steps{
                script{ FAILED_STAGE=env.STAGE_NAME }
                dockerBuildAndPush()
            }
        }
        // stage("DEV_DEPLOY") {
        //     options { skipDefaultCheckout() }
        //     steps {
        //         script{ FAILED_STAGE=env.STAGE_NAME }
        //         deployApplication()
        //     }
        // }
        // stage("Cleanup") {
        //     steps { sh('docker image prune -af') }
        // }
    }
// Pipeline Ends ------------------------------------------------------------------------------------------------------------------------

// Docker Building and Pushing the Image to AWS-ECR 

def dockerLogin() {
    sh(script:"aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${REGISTRY_URL}")
}
// def dockerBuildAndPush() {
//     docker.build("${IMAGE_NAME}")
//     docker.withRegistry("https://${REGISTRY_URL}", "${ECR_CREDENTIALS}") {
//         docker.image('springbootapp').push('myapp-v.${BUILD_NUMBER}')
//     }
//     notifySlack("Scanning Image for Vulnerabilities...","#springboot-app",[],[])
//     def scanReport = sh(script:"trivy image ${REGISTRY_URL}:myapp-v.${BUILD_NUMBER} | grep Total",returnStdout: true).trim()
//     notifySlack("*${scanReport}*","#springboot-app",[],[])
//     def isCritical = ("${scanReport}" =~ /CRITICA\w\D\s[^0]/).findAll().size() > 0
//     script{
//         if (isCritical) {
//             currentBuild.result = 'ABORTED'
//             notifySlack("${ERROR_MSG}","#springboot-app",[],[])
//             error("${ERROR_MSG}")
//         }
//     }
// }

// // Deploying the Input-TAG image to DEV_DEPLOY agent in ec2
// def deployApplication() {
//     notifySlack("*Waiting for Approval...${env.STAGE_NAME}*", "#springboot-app",[],[])
//     input message: 'Do you want to Deploy in Dev_Environment?', ok: 'Yes'
//     docker.withRegistry("https://${REGISTRY_URL}", "${ECR_CREDENTIALS}")  {
//         docker.image("${REGISTRY_URL}:${TAG}").pull() 
//     }
//     sh("docker run -d -p 8081:8081 --name JenkinsSpringApp ${REGISTRY_URL}:${TAG}")
// }

// // Testing the Input-TAG image in the QA_DEPLOY ec2 instance 
// def testApplication() {
//     notifySlack("*Waiting for Approval...${env.STAGE_NAME}*", "#springboot-app",[], [])
//     input message: 'Do you want to test in QA_Environment?', ok: 'Yes'
//     echo 'Testing...'
// }

// // Slack Notification service
// def notifySlack(text, channel, attachments, blocks) {
//     echo 'Sending Notification...'
//     def payload = JsonOutput.toJson([
//         text: text,
//         channel: channel,
//         username: "Jenkins",
//         icon_url: 'https://wiki.jenkins-ci.org/download/attachments/2916393/logo.png',
//         attachments: attachments,
//         blocks: blocks
//     ])
//     sh "curl -X POST --data-urlencode \'payload=${payload}\' '${WEB_HOOK_URL}'"
// }

// // Getting the Current Github username
// def getGitAuthor() {
//     def commit = sh(returnStdout: true, script: 'git rev-parse HEAD')
//     author = sh(returnStdout: true, script: "git --no-pager show -s --format='%an' ${commit}").trim()
// }
}