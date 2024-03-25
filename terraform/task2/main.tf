terraform {
  required_providers {
    docker = {
         source = "kreuzwerker/docker"
        version = "~> 3.0.1"
    }
  }
}


provider "docker" {
  
}


resource "docker_image" "ubuntu" {
  name = "ubuntu"
}

resource "docker_image" "nginx" {
  name         = "nginx"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "task2"

  ports {
    internal = 80
    external = 8000
  }
}



