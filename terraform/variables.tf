variable "namespace" {
  description   =  "Namespace for application"
  type          =  string
  default       =  "demo"
}

variable "appname" {
  description   = "Application Name"
  type          = string
  default       = "demo-app"
}

variable "replicas" {
  description   = "Number of replicas"
  type          = number
  default       = 2
}

variable "image" {
 description    = "Image of application"
 type           = string
 default        = "nginx:latest"
}

variable "service_type" {
 description    = "Type of kubernetes services"
 type           = string
 default        = "NodePort"
}

