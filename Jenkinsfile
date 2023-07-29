@Library('shared_library') _

pipeline{

    agent any

    parameters{

        choice(name: 'action', choices: 'create\ndelete', description: 'Choose create/Destroy')
        string(name: 'ImageName', description: "name of the docker build", defaultValue: 'java_app')
        string(name: 'ImageTag', description: "tag of the docker build", defaultValue: 'v1')
        // string(name: 'DockerHubUser', description: "name of the Application", defaultValue: 'vsnondoh')
        string(name: 'DockerHubUser', description: "name of the Application", defaultValue: 'noel')
    }

    stages{
         
        stage('Git Checkout'){
            when { expression {  params.action == 'create' } }
            steps{
            gitCheckout(
                branch: "main",
                url: "https://github.com/noelnondoh/java_app.git"
            )
            }
        }
        stage('Unit Test maven'){
            when { expression {  params.action == 'create' } }
            steps{
               script{
                   mvnTest()
               }
            }
        }
        stage('Integration Test maven'){
            when { expression {  params.action == 'create' } }
            steps{
               script{    
                   mvnIntegrationTest()
               }
            }
        }
        stage('Static code analysis: Sonarqube'){
            when { expression {  params.action == 'create' } }
            steps{
               script{
                   def SonarQubecredentialsId = 'sonarqube-api'
                   statiCodeAnalysis(SonarQubecredentialsId)
               }
            }
        }
        // stage('Quality Gate Status Check : Sonarqube'){
        //     when { expression {  params.action == 'create' } }
        //     steps{
        //        script{
                   
        //            def SonarQubecredentialsId = 'sonarqube-api'
        //            QualityGateStatus(SonarQubecredentialsId)
        //        }
        //     }
        // }
        stage('Maven Build : maven'){
            when { expression {  params.action == 'create' } }
            steps{
               script{               
                   mvnBuild()
               }
            }
        }

        // Build the container and tag it with abuild tag of the job
        stage('Docker Image Build'){
            when { expression {  params.action == 'create' } }
            steps{
               sh 'docker build -t ${DockerHubUser}/${ImageName} .'
            }
        }

        // stage('Docker Image Scan: trivy '){
        //     when { expression {  params.action == 'create' } }
        //     steps{
        //        script{
        //            dockerImageScan("${params.ImageName}","${params.ImageTag}","${params.DockerHubUser}")
        //        }
        //     }
        // }
        // stage('Docker Image Push : DockerHub '){
        //     when { expression {  params.action == 'create' } }
        //     steps{
        //        script{
                   
        //            dockerImagePush("${params.ImageName}","${params.ImageTag}","${params.DockerHubUser}")
        //        }
        //     }
        // } 

        //Set dockerhub credentials and use them to push to dockerhub
        // stage ('Image Push to Dockerhub') {
        //     withCredentials([[$class: 'UsernamePasswordMultiBinding',
        //     // set the dockerhub credentials
        //     credentialsId: 'dockerhub',
        //     passwordVariable: 'DOCKER_PASSWORD',
        //     usernameVariable: 'DOCKER_USERNAME']]) {
        //         sh '''sudo docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD} -e isackaranja@gmail.com
        //                 sudo docker push mugithi/blog:${BUILD_TAG}'''
        //             }
        // }

        // stage('Docker Image Cleanup : DockerHub '){
        //     when { expression {  params.action == 'create' } }
        //     steps{
        //        script{             
        //            dockerImageCleanup("${params.ImageName}","${params.ImageTag}","${params.DockerHubUser}")
        //        }
        //     }
        // }      
    }
}