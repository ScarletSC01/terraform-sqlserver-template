terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0"
    }
  }
}
 
provider "google" {
  credentials = file(var.credentials_file)
  project     = var.project
  region      = var.region
}
 
resource "google_sql_database_instance" "sqlserver_instance" {
  name             = "sqlserver-instance"
  region           = var.region
  database_version = "SQLSERVER_2022_STANDARD"
 
  settings {
    tier = "db-custom-2-5120"
    ip_configuration {
      ipv4_enabled = true
      authorized_networks {
        name  = "allow-all"
        value = "0.0.0.0/0"
      }
    }
  }
 
  root_password = "Strong!Passw0rd"
}
 
resource "google_sql_database" "empresa_db" {
  name     = "empresa"
  instance = google_sql_database_instance.sqlserver_instance.name
}
 
output "sqlserver_ip" {
  value = google_sql_database_instance.sqlserver_instance.ip_address[0].ip_address
}
