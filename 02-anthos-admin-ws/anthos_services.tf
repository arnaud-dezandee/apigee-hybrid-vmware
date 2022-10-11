locals {
  services = [
    "anthos.googleapis.com",
    "anthosgke.googleapis.com",
    "anthosaudit.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "container.googleapis.com",
    "gkeconnect.googleapis.com",
    "gkehub.googleapis.com",
    "serviceusage.googleapis.com",
    "stackdriver.googleapis.com",
    "opsconfigmonitoring.googleapis.com",
    "monitoring.googleapis.com",
    "logging.googleapis.com",
  ]
}

resource "google_project_service" "services" {
  for_each           = toset(local.services)
  project            = var.project
  service            = each.value
  disable_on_destroy = false
}
