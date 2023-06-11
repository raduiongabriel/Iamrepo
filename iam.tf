terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.68.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "4.68.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

#############################VARIABILE #################################
variable "project_id" {
  description = "ID-ul proiectului"
  type        = string
  default     = "terraform-386709"
}

variable "credentials_file" {
  description = "Calea către fișierul de credențiale"
  type        = string
  default     = "./forterraform.json"
}

variable "service_role" {
  description = "The role for the service account"
  type        = string
  default     = "roles/storage.objectAdmin"
}


variable "group_email" {
  description = "Adresa de email a grupului"
  type        = string
  default     = "null"
}

variable "user_email" {
  description = "Adresa de email a utilizatorului"
  type        = string
  default     = "null"
}
variable "user_role" {
  description = "Rolul utilizatorului"
  type        = string
  default     = "null"
}

variable "service_account_email" {
  description = "Adresa de email a contului de serviciu"
  type        = string
  default     = "null"
}
#############################VARIABILE #################################

provider "google" {
  project     = var.project_id
  credentials = var.credentials_file
}

# Definirea politicii IAM pentru un utilizator
resource "google_project_iam_binding" "user_policy" {
  project = var.project_id
  role    = var.user_role

  members = [
    "user:${var.user_email}",
  ]
}

# Definirea politicii IAM pentru un serviciu
resource "google_project_iam_binding" "service_policy" {
  project = var.project_id
  role    = var.service_role

  members = [
    "serviceAccount:${var.service_account_email}",
  ]
}

