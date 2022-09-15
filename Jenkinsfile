pipeline {

	agent any

	parameters {
	string(name: 'VERSION', defaultValue: '1.0.0')
	string(name: 'NAME', defaultValue: 'RELEASE')
	booleanParam(name: "PUBLISH", defaultValue: false)
	}
	
	stages {
		stage("BUILD") {
			steps {
				echo "build stage"
				sh 'docker build . -f build.dockerfile -t nrbuild'
				sh 'docker volume create nrVolOut'
				sh 'docker run --mount type=volume,src="nrVolOut",dst=/nodered nrbuild:latest bash -c "cd .. && cp -r /node-red_fork /nodered"'
			}
		}
		
		stage("TEST") {
			steps {
				echo "test stage"
				sh 'docker build . -f test.dockerfile -t nrtest'
			}
		}
		
	}
		
	post {
		success {
			echo "PIPELINE SUCCEED"
			}
		failure {
			echo "PIPELINE FAILURE"
			}
		}
}