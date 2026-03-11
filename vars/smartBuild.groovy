def call(Map config) {
	echo "Starting the Build ${config.imageName}.."
	sh "docker build -t ${condif.imageName}:${env.BUILD_ID} ."
	echo "Build Completed...!!"
}

