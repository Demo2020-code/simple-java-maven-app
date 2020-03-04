pipeline {
    agent {
        node {
            label 'master'
        }
    }
    
    environment {
       REPOSITORY = 'demo2020/simple-java-maven-app'
       HUB_CREDS_DEMO = credentials('HUB_CREDS_DEMO')
       DATE = sh (returnStdout: true, script: 'date +%y%m%d%H%M%S').trim()
       GITCOMMIT = sh (returnStdout: true, script: "echo ${GIT_COMMIT}|cut -c 1-8").trim()
       IMAGE_TAG = "${GIT_BRANCH}_${DATE}_${GITCOMMIT}"
    }
    
    stages {
        stage('Maven_Build') {
            agent {
                docker {
                    image 'maven:3-alpine'
                    args '-v /tmp/.m2:/root/.m2'
                }
            }
            steps {
                sh 'mvn -B -DskipTests clean package'
                stash includes: 'target/', name: 'saveBuild'
            }
        }
        stage('Test') {
            agent {
                docker {
                    image 'maven:3-alpine'
                    args '-v /tmp/.m2:/root/.m2'
                }
            }
            steps {
                sh 'mvn test'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage('Docker_Build') {
            steps {
                sh 'ls -l target/'
                sh 'docker login -u ${HUB_CREDS_DEMO_USR} -p ${HUB_CREDS_DEMO_PSW}'
                sh 'docker build -t ${REPOSITORY}:${IMAGE_TAG} -t ${REPOSITORY}:latest .'
                sh 'docker push ${REPOSITORY}:latest'
                sh 'docker push ${REPOSITORY}:${IMAGE_TAG}'
            }
        }
    }
}
