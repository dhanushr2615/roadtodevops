def call () {
    parallel(
	"Unit tests": {
		stage('Unit Tests') {
			steps {
			    sh 'mvn test -Dtest=*UnitTest'
			   }
		}
	},
        "Integration Tests": {
		stage('Integration Test') {
			 steps {
			     sh 'mvn verify -Dtest=*IntegrationTest'
				}
			}
		}
	}
}
