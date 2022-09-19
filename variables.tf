variable "project_id" {
  description = "The project to deploy to"
  type        = string
}
variable "region" {
  description = "The region to deploy to"
  type        = string
}
variable "zone" {
  description = "The zone to deploy to"
  type        = string
}
variable "network" {
  description = "The network to deploy to."
  type        = string
  default     = "default"
}
variable "name" {
  description = "Name of the runner instance."
  type        = string
  default     = "gitlab-runner"
}
variable "service_account_email" {
  description = "Name of the service account email, if not specified, 'gitlab-runner-sa' will be used"
  type        = string
}
variable "runner_token" {
  description = "Name of secret that contains the Gitlab Runner registration token"
  type        = string
  default     = "RUNNER_REG_TOKEN"
}
variable "runner_timezone" {
  description = "Time zone for stop and start of instance to save $$$"
  type        = string
  default     = "GMT"
}
variable "runner_start" {
  description = "Time for runner to start"
  type        = string
  default     = "0 6 * * 1-5"
}
variable "runner_stop" {
  description = "Time for runner to stop"
  type        = string
  default     = "0 18 * * 1-5"
}
variable "runner_tags" {
  description = "Tags that will be assigned to the runner"
  type        = string
  default     = ""
}
variable "reg_url" {
  description = "URL for gitlab instance"
  type        = string
}
variable "set_schedule" {
  description = "Enable stop/start schedule, SEE DOCUMENTATION!"
  type        = bool
  default     = "false"
}
variable "tags" {
  type        = list(string)
  description = "Network tags, provided as a list"
  default     = []
}
variable "labels" {
  type        = map(any)
  description = "Key-value map of labels to assign to the runner"
  default     = {}
}
variable "machine_type" {
  description = "Define the instance type"
  type        = string
  default     = "e2-micro"
}
variable "disk_size" {
  description = "Define the boot disk size"
  type        = number
  default     = 50
}
