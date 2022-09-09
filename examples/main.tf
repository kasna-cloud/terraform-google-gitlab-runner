module "runner" {
  source                = "./runner"
  project_id            = var.project_id
  region                = var.region
  zone                  = var.zone
  network               = "default"
  name                  = "gitlab-runner"
  service_account_email = google_service_account.gitlab_runner_sa.email
  runner_token          = "RUNNER_REG_TOKEN"
  set_schedule          = "true"
  runner_timezone       = "Australia/Sydney"
  runner_start          = "0 6 * * 1-5"
  runner_stop           = "0 18 * * 1-5"
  runner_tags           = "docker,gcp,squid"
  reg_url               = "https://gitlab.mantelgroup.com.au/"
}