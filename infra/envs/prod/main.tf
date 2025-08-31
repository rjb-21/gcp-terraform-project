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

module "apis" {
  source     = "../../modules/apis"
  project_id = var.project_id
}

module "storage" {
  source     = "../../modules/storage"
  project_id = var.project_id
  app_name   = var.app_name
  location   = var.location_bucket
  environment = var.environment
}

module "secrets" {
  source     = "../../modules/secrets"
  project_id = var.project_id
  app_name   = var.app_name
  secrets = {
    db_password = var.db_password
    api_key     = var.api_key
  }
  environment = var.environment
}

module "network" {
  source     = "../../modules/network"
  project_id = var.project_id
  region     = var.region
  app_name   = var.app_name
  environment = var.environment
}


module "sql" {
  source      = "../../modules/sql"
  project_id  = var.project_id
  region      = var.region
  app_name    = var.app_name
  db_password = var.db_password
  network     = module.network.network_self_link
  subnet      = module.network.subnet_self_link
  environment                 = var.environment
}

module "iam" {
  source     = "../../modules/iam"
  project_id = var.project_id
  app_name   = var.app_name
  environment = var.environment
}

module "vm" {
  source                = "../../modules/vm"
  project_id            = var.project_id
  region                = var.region
  zone                  = "europe-central2-a"
  app_name              = var.app_name
  network               = module.network.network_self_link
  subnet                = module.network.subnet_self_link
  service_account_email = module.iam.app_sa_email
  environment                 = var.environment
}

module "vpc_connector" {
  source        = "../../modules/vpc_connector"
  project_id    = var.project_id
  region        = var.region
  name          = "cloud-run-connector"
  network       = module.network.network_self_link
  ip_cidr_range = "10.8.0.0/28"
  environment                 = var.environment
}

module "cloud_run" {
  source                      = "../../modules/cloud_run"
  project_id                  = var.project_id
  region                      = var.region
  image                       = "gcr.io/cloudrun/hello"
  db_instance_connection_name = module.sql.db_instance_connection_name
  db_user                     = "appuser"
  db_password_secret_name     = "terraform-helloworld-app-db-password-prod"
  vpc_connector               = module.vpc_connector.name
  service_account_email       = module.iam.app_sa_email
  environment                 = var.environment
}

module "monitoring" {
  source      = "../../modules/monitoring"
  alert_email = "radek0101@gmail.com"
}


