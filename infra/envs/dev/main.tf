terraform {
  required_version = ">= 1.5"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

module "storage" {
  source    = "../../modules/storage"
  project_id = var.project_id
  app_name   = var.app_name
  location     = var.location_bucket
}

module "secrets" {
  source     = "../../modules/secrets"
  project_id = var.project_id
  app_name   = var.app_name
  secrets = {
    db_password = var.db_password
    api_key     = var.api_key
    }
}

module "network" {
  source     = "../../modules/network"
  project_id = var.project_id
  region     = var.region
  app_name   = var.app_name
}


module "sql" {
    source = "../../modules/sql"
    project_id = var.project_id
    region = var.region
    app_name = var.app_name
    db_password = var.db_password
    network = module.network.network_self_link
    subnet  = module.network.subnet_self_link
}