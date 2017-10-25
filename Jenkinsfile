
pipeline {
  agent {
	  label 'docker'}
	  
  
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
		/*
        stage('Deploy') {
			//agent { label 'master' }
            steps {
				echo env.WORKSPACE
                echo 'Deploying....'
            }
        }
		stage('UnitTestJob'){
			//agent { label 'master' }
			steps{
				unstash 'working-copy'
				
				sh "./mvnw clean test"
				
				stash 'working-copy'
		}
		}
		stage('SonarQube analysis 1'){
			//agent { label 'master' }
			
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
			//agent { label 'master' }
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
  */
		stage('agent Docker'){
		
			
			steps{
				unstash includes: '**/target/*.war', name: 'working-copy'
				sh "echo imprimir la variable env.WORKSPACE"
				//"docker cp ${env.WORKSPACE}/target/petclinic.war  ${SERVICE_NAME}:/usr/local/tomcat/webapps/"
				sh "docker cp petclinic.war  tomcat:/usr/local/tomcat/webapps/"
				//"docker restart ${SERVICE_NAME}"
				sh "docker restart ${SERVICE_NAME}"
                //sh "COUNT=1"
				//sh "while ! curl -q http://${SERVICE_NAME}:8080/petclinic -o /dev/null"
                //|do
            /*
			|  if [ ${COUNT} -gt 10 ]; then
            |    echo "Docker build failed even after ${COUNT}. Please investigate."
            |    exit 1
            |  fi
            |  echo "Application is not up yet. Retrying ..Attempt (${COUNT})"
            |  sleep 5
            |  COUNT=$((COUNT+1))
            |done
				sh "${scannerHome}/bin/sonar-scanner"
			*/		
				
				
			}
			
		}
  
  
  }
  }
 
 
