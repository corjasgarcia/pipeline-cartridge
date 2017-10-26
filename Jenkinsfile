
pipeline {
  agent {
	  label 'docker'}
	  
  
  // ** agent { docker 'maven:3-alpine' }
	/* environment
	environmentVariables {
        env('WORKSPACE_NAME', workspaceFolderName)
        env('PROJECT_NAME', projectFolderName)
    }
	*/
	/*
	parameters {
        string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')
    }
	*/
    
  
  /*
  tools { 
	maven 'apache-maven-3.5.0' 
	}agent
  */
	environment {
				SERVICE_NAME = "tomcat"
				APP_URL = "http://52.16.226.150:8888/petclinic"
			}
    stages {
        stage('Clone') {
			
            steps {
                echo 'Cloning repository'
				
				dir('RepoOne') {
					git url: 'https://github.com/Accenture/spring-petclinic.git'
					}
				dir('RepoTwo') {
					git url:  'https://github.com/Accenture/adop-cartridge-java-regression-tests.git'
					}
				
			
            }
        }
        stage('Build') {
			
            steps {
				dir('RepoOne'){
				//sh "ls"
                echo 'Building with Maven'
				// ** def mvnHome = 'apache-maven-3.5.0'
				sh "./mvnw clean install -DskipTests"
				//stash 'working-copy'
				// archiveArtifacts artifacts: '**/target/*.war'
				//stash includes: '**/target/*.war', name: 'war-file'
				}
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
  /*
		stage('agent Docker'){
			
			
			steps{
				
				//unstash 'war-file'
				 
				
				//"docker cp ${env.WORKSPACE}/target/petclinic.war  ${SERVICE_NAME}:/usr/local/tomcat/webapps/"
				sh '''docker cp ./RepoOne/target/petclinic.war ${SERVICE_NAME}:/usr/local/tomcat/webapps/
				      docker restart ${SERVICE_NAME}
                      COUNT=1
				      while ! curl -q http://52.16.226.150:8888/petclinic -o /dev/null
                      do
					  if [ ${COUNT} -gt 10 ]; then
                      echo "Docker build failed even after ${COUNT}. Please investigate."
                      exit 1
                      fi
                      echo "Application is not up yet. Retrying ..Attempt (${COUNT})"
                      sleep 5
                      COUNT=$((COUNT+1))
                      done'''
						
					
				
				
			}
			
		}
		
	*/
		/*
		stage('regression Test no ZAP'){
		
			
			steps{
				
				sh "./mvn -f ./RepoTwo/pom.xml clean -B test -DPETCLINIC_URL=${APP_URL}" 
				
				
			}
		}
		*/
		/*
		stage('regression Test with ZAP'){
		
			
			steps{
			
				
				
				sh "./mvn -f ./RepoTwo/pom.xml clean -B test -DPETCLINIC_URL=${APP_URL}" 
				
				
			}
		}
		*/
		stage(performanceTestJob){
		
			script{
			def JMETER_TESTDIR = "jmeter_dir"
			}
			steps{
				
				
				sh '''
				if [ -e ../apache-jmeter-2.13.tgz ]; then
            	cp ../apache-jmeter-2.13.tgz ${JMETER_TESTDIR}
				else
            	wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-2.13.tgz
                cp apache-jmeter-2.13.tgz ../
                mv apache-jmeter-2.13.tgz ${JMETER_TESTDIR}
				fi
				mkdir ${JMETER_TESTDIR}
				cd ${JMETER_TESTDIR}
				tar -xf apache-jmeter-2.13.tgz
				echo 'Changing user defined parameters for jmx file'
				sed -i 's/PETCLINIC_HOST_VALUE/'"52.16.226.150"'/g' src/test/jmeter/petclinic_test_plan.jmx
				sed -i 's/PETCLINIC_PORT_VALUE/8888/g' src/test/jmeter/petclinic_test_plan.jmx
				sed -i 's/CONTEXT_WEB_VALUE/petclinic/g' src/test/jmeter/petclinic_test_plan.jmx
				sed -i 's/HTTPSampler.path"></HTTPSampler.path">petclinic</g' src/test/jmeter/petclinic_test_plan.jm'''			
				
		}
		}
		}
		
		
		}
  
  
  
  