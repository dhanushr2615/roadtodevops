pipeline{
    agent { label 'Slave-VM-01' }

	environment {
		SSH_CRED_ID = 'Github_PAT'
		REPO_URL = 'git@github.com:dhanushr2615/roadtodevops.git'
}

	stages{
	   stage('Checkout'){
			
			checkout scm
		}
	}

	stage('Modify & Push'){
		steps {
		
			sshagent([SSH_CRED_ID]){
				sh '''
				#1. Setup git identity (required for committing)
				git config user.email "dhanushr335@gmail.com"
				git config user.name "dhanushr2615"
				
				#2. Make a small change
				echo "Build performed on $(date)" >> build_history.log

				#3. Commit and Push
				git add build_history.log
				git commit -m"docs: update build history [skip ci]"
				git push origin main
				
				'''
			}
		}
}
