# Fișier: iam.tf
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.68.0"
    }
    google-beta = {
      source = "hashicorp/google-beta"
      version = "4.68.0"
    }
  
   random = {
      source = "hashicorp/random"
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
  default     = "/home/kali/Disertatie/Disertatie/forterraform.json"
}

variable "group_email" {
  description = "Adresa de email a grupului"
}

variable "user_email" {
  description = "Adresa de email a utilizatorului"
}

variable "service_account_email" {
  description = "Adresa de email a contului de serviciu"
}
#############################VARIABILE #################################

provider "google-beta" {
  project     = var.project_id
  credentials = var.credentials_file
}



# Definirea politicii IAM pentru un grup
data "google_iam_policy" "group_policy" {
    provider = google-beta
  binding {
    role    = "roles/editor"
    members = [
      "group:${var.group_email}",
    ]
  }
}

# Definirea politicii IAM pentru un utilizator
data "google_iam_policy" "user_policy" {
    provider = google-beta
  binding {
    role    = "roles/compute.instanceAdmin"
    members = [
      "user:${var.user_email}",
    ]
  }
}

# Definirea politicii IAM pentru un serviciu
data "google_iam_policy" "service_policy" {
    provider = google-beta
  binding {
    role    = "roles/storage.objectAdmin"
    members = [
      "serviceAccount:${var.service_account_email}",
    ]
  }
}
