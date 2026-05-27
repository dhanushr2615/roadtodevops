# Configure kubernetes provider to use Minikube's Kubeconfig 
provider "kubernetes" {
  config_path = "~/.kube/config"
}

# Create a namespace
resource "kubernetes_namespace" "demo" {
  metadata {
	name         = "demo"
   }
}

# Deploy Nginx app
resource "kubernetes_deployment" "nginx" {
  metadata {
	name      = "nginx-deployment"
	namespace = kubernetes_namespace.demo.metadata[0].name
}

spec {
   replicas = 2
   selector {
      match_labels = {
	 app = "nginx"
	}
      }
     template {
	metadata {
	  labels = {
	     app = "nginx"
	    }
	}
       spec {
	container {
	  name  = "nginx"  
	  image = "nginx:latest"
	  port {
		container_port = 80
		}
	      }
	    }
	  }
      }
}

# Expose the app via nodeport
resource "kubernetes_service" "nginx" {
   metadata {
	name       = "nginx-service"
	namespace  = kubernetes_namespace.demo.metadata[0].name
      }
   spec {
	selector = {
	   app = "nginx"
	}
	port {
	  port	      = 80
	  target_port = 80
	}
	type = "NodePort"
	}
} 
