
locals {
  runner_startup_script = <<EOF
#!/bin/bash
export FLAG=/var/runner.flg
apt update
apt -yq upgrade
apt -y install curl docker.io
curl -LJO "https://gitlab-runner-downloads.s3.amazonaws.com/latest/deb/gitlab-runner_amd64.deb"
dpkg -i gitlab-runner_amd64.deb
[ -f "$FLAG" ] || gitlab-runner register \
  --non-interactive \
  --url "${var.reg_url}" \
  --registration-token "${data.google_secret_manager_secret_version.runner_reg_token.secret_data}" \
  --executor "docker" \
  --docker-image alpine:latest \
  --description "docker-runner" \
  --maintenance-note "Gitlab runner for ${var.project_id}" \
  --tag-list "${var.runner_tags}" \
  --run-untagged="true" \
  --locked="false" \
  --access-level="not_protected" && touch $FLAG
  EOF
}

#-------------------------------------------------------
# gitlab runner VM Instance
#-------------------------------------------------------
resource "google_compute_instance" "github_runner" {
  project      = var.project_id
  name         = var.name
  zone         = var.zone
  machine_type = var.machine_type

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  labels = var.labels

  tags = var.tags

  metadata_startup_script = local.runner_startup_script

  network_interface {
    network = var.network
  }

  resource_policies = var.set_schedule ? [google_compute_resource_policy.runner-hours[0].self_link] : null

  service_account {
    email  = var.service_account_email
    scopes = ["cloud-platform"]
  }
  depends_on = [module.custom-roles-compute]
}

#----------------------------------------------------------------------------
# Runner Hours Schedule
#----------------------------------------------------------------------------
resource "google_compute_resource_policy" "runner-hours" {
  count       = var.set_schedule == true ? 1 : 0
  project     = var.project_id
  name        = "runner-hours"
  region      = var.region
  description = "Start and stop GitLab runner"
  instance_schedule_policy {
    vm_start_schedule {
      schedule = var.runner_start
    }
    vm_stop_schedule {
      schedule = var.runner_stop
    }
    time_zone = var.runner_timezone
  }
}

module "custom-roles-compute" {
  count        = var.set_schedule ? 1 : 0
  source       = "terraform-google-modules/iam/google//modules/custom_role_iam"
  target_level = "project"
  target_id    = var.project_id
  role_id      = "compute.power"
  title        = "Compute Power"
  description  = "Stop and Start Compute"
  permissions  = ["compute.instances.start", "compute.instances.stop"]
  members      = ["serviceAccount:service-${data.google_project.project.number}@compute-system.iam.gserviceaccount.com", "serviceAccount:${var.service_account_email}"]
}

data "google_secret_manager_secret_version" "runner_reg_token" {
  project = var.project_id
  secret  = var.runner_token
}

data "google_project" "project" {
  project_id = var.project_id
}