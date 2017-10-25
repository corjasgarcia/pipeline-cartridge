buildAppJob.with {
    description("This job builds Java Spring reference application")
    wrappers {
        preBuildCleanup()
        injectPasswords()
        maskPasswords()
        sshAgent("adop-jenkins-master")
    }
    scm {
        git {
            remote {
                url(referenceAppGitUrl)
                credentials("adop-jenkins-master")
            }
            branch("*/master")
        }
    }
    environmentVariables {
        env('WORKSPACE_NAME', workspaceFolderName)
        env('PROJECT_NAME', projectFolderName)
    }
    label("java8")
    triggers {
        gerrit {
            events {
                refUpdated()
            }
            project(projectFolderName + '/' + referenceAppgitRepo, 'plain:master')
            configure { node ->
                node / serverName("ADOP Gerrit")
            }
        }
    }
    steps {
        maven {
            goals('clean install -DskipTests')
            mavenInstallation("ADOP Maven")
        }
    }
    publishers {
        archiveArtifacts("**/*")
        downstreamParameterized {
            trigger(projectFolderName + "/Reference_Application_Unit_Tests") {
                condition("UNSTABLE_OR_BETTER")
                parameters {
                    predefinedProp("B", '${BUILD_NUMBER}')
                    predefinedProp("PARENT_BUILD", '${JOB_NAME}')
                }
            }
        }
    }
}