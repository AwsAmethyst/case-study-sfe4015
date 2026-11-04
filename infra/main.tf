terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

# Pull the official NGINX image
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

# Run the container named scm-staging on port 8080:80
resource "docker_container" "staging" {
  name  = "scm-staging"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = 8080
  }
}

output "app_url" {
  value = "http://localhost:8080"
}