pipeline {
    
    agent any
    
    tools {
      maven 'maven'
    }
        stages
        {
            stage('Git Checkout')
        {
            steps{
               checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/DevOpsSolutionss/bookstore.git']]])
            }
        }
        stage('Build')
        {
            steps
            {
                sh 'mvn clean install package'
            }
        }
        
        stage('Test')
        {
            steps
            {
                sh 'mvn test'
            }
       post
       {
           always
           {
                junit '**/target/surefire-reports/TEST-*.xml'
            }
       }
        }
        stage('Send Dockerfile')
        {
            steps
            {
                sshPublisher(publishers: [sshPublisherDesc(configName: 'ansible_server', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '//opt//k8s-lab', remoteDirectorySDF: false, removePrefix: '', sourceFiles: 'Dockerfile')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
            }
        }
        stage('Build Docker Image')
        {
            steps
            {
                sshPublisher(publishers: [sshPublisherDesc(configName: 'ansible_server', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: 'ansible-playbook /opt/k8s-lab/dockerimage.yml', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '//opt//k8s-lab', remoteDirectorySDF: false, removePrefix: 'target', sourceFiles: 'target/BookStore.war')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
            }
        }
        stage('Kubernetes Deployment')
        {
            steps
            {
                sshPublisher(publishers: [sshPublisherDesc(configName: 'ansible_server', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '''ansible-playbook  /opt/k8s-lab/k8s-deploy.yml
ansible-playbook /opt/k8s-lab/k8s-service.yml''', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
            }
        }
    }
}
