def call(String envName) {
	stage("Deploy to ${envName}") {
	   steps {
		script {
			if (envName == 'staging') {
			  sh 'echo Deploying Staging...'
		} else if (envName == 'production') {
			 sh 'echo deploying Production....'
		} else {
			sh 'echo Unknown environment..'
			}
		  }
	     }
	}	
}
