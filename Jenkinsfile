pipeline {
	agent any
	parameters {
	string(name: 'VERSION', defaultValue: '1.0.0')
	string(name: 'NAME', defaultValue: 'RELEASE')
	booleanParam(name: "PUBLISH", defaultValue: false)
	}	
	stages {
		stage("Build") {
			steps {
				echo "Stage: Build"
				sh 'docker build . -f build.dockerfile -t njsbuild'
				sh 'docker volume create njsVolOut'
				sh 'docker run --mount type=volume,src="njsVolOut",dst=/nodejs njsbuild:latest bash -c "cd .. && cp -r /nodejs.org /nodejs"'
			}
		}
		
		stage("Test") {
			steps {
				echo "Stage: Test"
				sh 'docker build . -f test.dockerfile -t njstest'
			}
		}
		stage("Deploy") {
			steps {
				echo "Stage: Deploy"
				sh 'docker rm -f njsdeploy || true'
				sh 'docker run --name njsdeploy --mount type=volume,src="njsVolOut",dst=/nodejs node bash -c "cd nodejs && cd nodejs.org && npm run"'
				sh 'exit $(docker inspect njsdeploy --format="{{.State.ExitCode}}")'
			}
		}	
		stage("Publish") {
			steps {
				script {
					if(params.PUBLISH) {
					sh "mkdir nodejsOrg"
					sh 'docker rm -f njspublish || true'
					sh 'docker run --name njspublish njsbuild:latest'
					sh"docker cp njspublish:/nodejs.org ./nodejs"
					sh"tar -zcvf nr_${params.NAME}_${params.VERSION}.tar.xz nodejs/nodejs.org"
					sh "rm -r nodejs"
					archiveArtifacts artifacts: "nr_${params.NAME}_${params.VERSION}.tar.xz"
						}
					}
				}
			}
	}		
	post {
		success {
			echo "Pipeline success"
			}
		failure {
			echo "Pipeline fail"
			}
		}
}