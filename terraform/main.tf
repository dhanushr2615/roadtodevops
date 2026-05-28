# Configure kubernetes provider to use Minikube's Kubeconfig 
provider "kubernetes" {
  config_path = "~/.kube/config"
}

# Create a namespace
resource "kubernetes_namespace" "app_ns" {
  metadata {
	name         = var.namespace
   }
}

# ConfigMap
resource "kubernetes_config_map" "app_config" {
  metadata {
	name        = "${var.appname}-config"
	namespace   = var.namespace
      }

	data = {
	   APP_ENV  = "dev"
	   APP_MODE = "debug"
	}
    }

# Secret
resource "kubernetes_secret" "app_secret" {
   metadata {
	name       = "${var.appname}-secret"
	namespace  = var.namespace
      }
     
    data = {
	DB_USER = base64encode("admin")
	DB_PASS = base64encode("Passw0rd")
	}
     }

# Deploy Nginx app
resource "kubernetes_deployment" "app" {
  metadata {
	name      = "${var.appname}-deployment"
	namespace = var.namespace
}

spec {
   replicas = var.replicas
   selector {
      match_labels = {
	 app = var.appname
	}
      }
     template {
	metadata {
	  labels = {
	     app = var.appname
	    }
	}
       spec {
	container {
	  name  = var.appname  
	  image = var.image

	   env_from {
		config_map_ref {
			name = kubernetes_config_map.app_config.metadata[0].name
			}
		}
	    env_from {
   	       secret_ref {
			name = kubernetes_secret.app_secret.metadata[0].name
			}
		}

	  port {
		container_port = 80
		}
	      }
	    }
	  }
      }
}

# Expose the app via nodeport
resource "kubernetes_service" "app_service" {
   metadata {
	name       = "${var.appname}-service"
	namespace  = var.namespace
      }
   spec {
	selector = {
	   app = var.appname
	}
	port {
	  port	      = 80
	  target_port = 80
	}
	type = var.service_type
	}
} 
