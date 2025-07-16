terraform {
  # terraform v1.5 ships on google cloud shell
  required_version = ">= 1.5"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 6.43.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 3.0.2"
    }
    # random = {
    #   source  = "hashicorp/random"
    #   version = ">= 3.6.0"
    # }
  }
}