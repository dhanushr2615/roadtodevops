pipeline{
    agent { label 'Slave-VM-01' }

	stages{
	   stage('Fetch Code'){
		steps{
		   echo 'Successfully Fetched code from Github!!' 
		}         
   }
	   stage('Test'){
		steps{
		 sh 'sh_scripts/health.sh'
                }
	}

        }
	post {
	 always {
		sh 'chmod 755 /tmp/health.log'
		sh 'cat /tmp/health.log'
		
 		archiveArtifacts artifacts: '~/tmp/health.log' , fingerprint: true
}
}
}

