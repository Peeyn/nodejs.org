pipeline {
	agent any
	stages{
		stage('Build'){
			steps{
			echo 'Build'
			sh 'docker build . -f build.dockerfile -t nodebuild'
			sh 'docker volume create nodeVolumeOut'
			sh 'docker run --mount type=volume, src="nodeVolumeOut", dst=/nodejs.org nodebuild:latest bash -c "cd .. && cp -r /nodejs.org /nodejs"'
		}
	}
}	