
pipeline {
  agent any
  // ** agent { docker 'maven:3-alpine' }
  // ** environment{ 
  // ** }
  tools { 
        maven 'apache-maven-3.5.0'  
    }
	environment {
	 WORKSPACE_DIR = ${env.WORKSPACE}
	}

    stages {
        stage('Clone') {
            steps {
                echo 'Cloning repository'
				git url: 'https://github.com/Accenture/spring-petclinic.git'
            }
        }
        stage('Build') {
            steps {
				
                echo 'Building with Maven'
				// ** def mvnHome = 'apache-maven-3.5.0'
				sh "mvn clean install -DskipTests"
				stash 'working-copy'
				
            }
        }
        stage('Deploy') {
            steps {
				echo 'print variable ${WORKSPACE_DIR} '
				
                echo 'Deploying....'
            }
        }
    }
 }
