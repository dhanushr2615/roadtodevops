def call(Map config = [:]) {
	echo "Starting the Build ${config.imageName}.."
	sh "docker build -t ${config.imageName}:${env.BUILD_ID} ."
	echo "Build Completed...!!"
}

