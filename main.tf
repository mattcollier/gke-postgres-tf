# Enable APIs we need
resource "google_project_service" "services" {
  for_each = toset([
    "container.googleapis.com",
    "cloudresourcemanager.googleapis.com"
  ])
  project            = var.project_id
  service            = each.key
  disable_on_destroy = false
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Autopilot cluster – single node pool managed by Google
resource "google_container_cluster" "autopilot" {
  name     = "demo-autopilot"
  location = var.region

  enable_autopilot = true

  # minimal logging/monitoring to save $$ but keep the basics
  logging_config {
    enable_components = ["SYSTEM_COMPONENTS", "WORKLOADS"]
  }
}

# Grant ourselves cluster access
data "google_client_config" "current" {}

provider "kubernetes" {
  host                   = google_container_cluster.autopilot.endpoint
  cluster_ca_certificate = base64decode(google_container_cluster.autopilot.master_auth[0].cluster_ca_certificate)
  token                  = data.google_client_config.current.access_token
}

provider "helm" {
  kubernetes = {
    host                   = google_container_cluster.autopilot.endpoint
    cluster_ca_certificate = base64decode(google_container_cluster.autopilot.master_auth[0].cluster_ca_certificate)
    token                  = data.google_client_config.current.access_token
  }
}