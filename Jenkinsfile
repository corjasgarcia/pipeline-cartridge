
pipeline {
  agent any
  // ** agent { docker 'maven:3-alpine' }
  // ** environment{ 
  // ** }
  //** tools { 
  //**      maven 'apache-maven-3.5.0' 
		
  //  }
   // ** agent

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
				sh "./mvnw clean install -DskipTests"
				stash 'working-copy'
				archiveArtifacts artifacts: '**/target/*.war'
				
            }
        }
        stage('Deploy') {
            steps {
				echo env.WORKSPACE
                echo 'Deploying....'
            }
        }
		stage('UnitTestJob'){
			steps{
				unstash 'working-copy'
				
				sh "./mvnw clean test"
				
				stash 'working-copy'
		}
		}
		stage('SonarQube analysis 1'){
			
			// ** Coge las propiedades del pom
			//** La configuracion viene dada por maven
			
			steps{
				withSonarQubeEnv('sonarQube5.3') {
				// ** Para 
				sh './mvnw sonar:sonar'
		}
		}
	}
		stage('SonarQube analysis 2') {
			steps{
				script{
					scannerHome = tool 'SonarQube Scanner 2.8';
					}
				// requires SonarQube Scanner 2.8+
				withSonarQubeEnv('sonarQube5.3') {
				sh "${scannerHome}/bin/sonar-scanner"
		}
    }
  }
}
 }
 
