# Strong random password
# resource "random_password" "postgres" {
#   length  = 16
#   special = true
# }

# Namespace for DB
resource "kubernetes_namespace" "db" {
  metadata {
    name = "postgres"
  }
}

# Bitnami PostgreSQL Helm chart
resource "helm_release" "postgres" {
  name       = "pgdemo"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  namespace  = kubernetes_namespace.db.metadata[0].name
  version    = "15.2.5"

  values = [
    yamlencode({
      primary = {
        persistence = { enabled = false } # ephemeral, cheaper
        resources = {
          requests = { cpu = "200m", memory = "256Mi" }
        }
        service = {
          type = "LoadBalancer"
          port = 5432
        }
      }
      auth = {
        database = var.db_name
        username = var.db_user
        # use a user supplied password for now
        password = var.db_password
        # password = random_password.postgres.result
      }
    })
  ]

  depends_on = [google_container_cluster.default]
}