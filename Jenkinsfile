
pipeline {
  agent none
  
  // ** agent { docker 'maven:3-alpine' }
  /* environment{ 
	environmentVariables {
        env('WORKSPACE_NAME', workspaceFolderName)
        env('PROJECT_NAME', projectFolderName)
    }
  */  
  /*
  tools { 
	maven 'apache-maven-3.5.0' 
	}agent
  */

    stages {
        stage('Clone') {
			agent { label 'master' }
            steps {
                echo 'Cloning repository'
				git url: 'https://github.com/Accenture/spring-petclinic.git'
            }
        }
        stage('Build') {
			agent { label 'master' }
            steps {
				
                echo 'Building with Maven'
				// ** def mvnHome = 'apache-maven-3.5.0'
				sh "./mvnw clean install -DskipTests"
				stash 'working-copy'
				archiveArtifacts artifacts: '**/target/*.war'
				
            }
        }
        stage('Deploy') {
			agent { label 'master' }
            steps {
				echo env.WORKSPACE
                echo 'Deploying....'
            }
        }
		stage('UnitTestJob'){
			agent { label 'master' }
			steps{
				unstash 'working-copy'
				
				sh "./mvnw clean test"
				
				stash 'working-copy'
		}
		}
		stage('SonarQube analysis 1'){
			agent { label 'master' }
			
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
			agent { label 'master' }
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
		stage('agent Docker'){
			agent{
			
				docker{
					image 'tomcat:8.0'
					args '-v $HOME/.m2:/root/.m2'
					
			}
			}
			steps{
				echo 'imprimir la variable env.WORKSPACE'
			}
			}
			
		}
  
  
  }
 
 
