variable "project_id" {
  type        = string
  description = "GCP project to deploy into"
}

variable "region" {
  type        = string
  description = "Region for the Autopilot cluster"
  default     = "us-central1"
}

variable "db_name" {
  type        = string
  description = "Initial Postgres database name"
  default     = "mydb"
}

variable "db_password" {
  type        = string
  description = "Initial Postgres database password"
}

variable "db_user" {
  type        = string
  description = "Initial Postgres username"
  default     = "dbt"
}