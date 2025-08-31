variable "project_id" {
  description = "Project ID where APIs should be enabled"
  type        = string
}

variable "enabled_apis" {
  description = "List of APIs to enable in the project"
  type        = list(string)
  default     = [
    "compute.googleapis.com",
    "sqladmin.googleapis.com",
    "secretmanager.googleapis.com",
    "run.googleapis.com",
    "vpcaccess.googleapis.com",
    "iam.googleapis.com",
    "servicenetworking.googleapis.com"
  ]
}
