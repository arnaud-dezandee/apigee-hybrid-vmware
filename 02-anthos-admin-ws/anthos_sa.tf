######################################
# component-access-sa
######################################

resource "google_service_account" "component" {
  account_id   = "component-access-sa"
  display_name = "Component Access Service Account"
}

resource "google_service_account_key" "key" {
  service_account_id = google_service_account.component.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}

resource "local_file" "key" {
  content         = base64decode(google_service_account_key.key.private_key)
  filename        = "${path.module}/${var.project}-component-access-key.json"
  file_permission = "0644"
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

######################################
# connect-register-sa
######################################

resource "google_service_account" "connect" {
  account_id = "connect-register-sa"
}

resource "google_service_account_key" "connect_key" {
  service_account_id = google_service_account.connect.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}

resource "local_file" "connect_key" {
  content         = base64decode(google_service_account_key.connect_key.private_key)
  filename        = "${path.module}/${var.project}-connect-register-sa.json"
  file_permission = "0644"
}

locals {
  connect_roles = [
    "roles/serviceusage.serviceUsageViewer",
    "roles/gkehub.editor",
    "roles/gkehub.admin",
  ]
}

resource "google_project_iam_member" "connect_bindings" {
  for_each = toset(local.connect_roles)
  project  = var.project
  role     = each.value
  member   = "serviceAccount:${google_service_account.connect.email}"
}

######################################
# log-mon-sa
######################################

resource "google_service_account" "log_mon" {
  account_id = "log-mon-sa"
}

resource "google_service_account_key" "log_mon_key" {
  service_account_id = google_service_account.log_mon.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}

resource "local_file" "log_mon_key" {
  content         = base64decode(google_service_account_key.log_mon_key.private_key)
  filename        = "${path.module}/${var.project}-log-mon-sa.json"
  file_permission = "0644"
}

locals {
  log_mon_roles = [
    "roles/stackdriver.resourceMetadata.writer",
    "roles/opsconfigmonitoring.resourceMetadata.writer",
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.dashboardEditor",
  ]
}

resource "google_project_iam_member" "log_mon_bindings" {
  for_each = toset(local.log_mon_roles)
  project  = var.project
  role     = each.value
  member   = "serviceAccount:${google_service_account.log_mon.email}"
}
