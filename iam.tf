# Definirea furnizorului Google
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.68.0"
    }
  }
}

# Variabilele de intrare
variable "project_id" {
  description = "ID-ul proiectului"
  type        = string
  default     = "terraform-386709"
}

variable "service_account_id" {
  description = "ID-ul contului de serviciu"
  type        = string
  default     = "my-service-account"
}

variable "service_account_display_name" {
  description = "Numele de afișare al contului de serviciu"
  type        = string
  default     = "My Service Account"
}

variable "service_account_role" {
  description = "Rolul pentru contul de serviciu"
  type        = string
  default     = "roles/editor"
}

variable "credentials_file" {
  description = "Calea către fișierul de credențiale"
  type        = string
  default     = "./forterraform.json"
}
variable "key_created_date" {
  description = "Key Created Date"
  type        = string
}


provider "google" {
  project     = var.project_id
  credentials = var.credentials_file
}

# Crearea serviciului
resource "google_service_account" "service_account" {
  account_id   = var.service_account_id
  display_name = var.service_account_display_name
}

# Atribuirea rolului pentru serviciu
resource "google_project_iam_member" "service_account_role" {
  project = var.project_id
  role    = var.service_account_role
  member  = "serviceAccount:${google_service_account.service_account.email}"
}

# Crearea cheii pentru serviciul de cont
resource "google_service_account_key" "service_account_key" {
  service_account_id = google_service_account.service_account.id
}

# Data creării cheii
output "service_account_key_created_time" {
  description = "Service Account Key Created Time"
  value       = google_service_account_key.service_account_key.valid_after
}

