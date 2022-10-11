resource "google_service_account" "component" {
  account_id   = "component-access-sa"
  display_name = "Component Access Service Account"
}

resource "google_service_account_key" "key" {
  service_account_id = google_service_account.component.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}

resource "local_file" "key" {
  content  = base64decode(google_service_account_key.key.private_key)
  filename = "${path.module}/component-access-key.json"
}

locals {
  roles = [
    "roles/serviceusage.serviceUsageViewer",
    "roles/iam.roleViewer",
    "roles/iam.serviceAccountViewer",
  ]
}

resource "google_project_iam_member" "bindings" {
  for_each = toset(local.roles)
  project  = var.project
  role     = each.value
  member   = "serviceAccount:${google_service_account.component.email}"
}
