##TEST
pipeline {
 node{
 
  environment{
  ##Se declaran las environment_variables
  }
  // **tools { 
  // **      maven 'apache-maven-3.5.0'  
  // **    }

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
				def mvnHome = tool 'apache-maven-3.5.0'
				sh "${mvnHome}/bin/mvn clean install -DskipTests"
				stash 'working-copy'
				
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
 }
}