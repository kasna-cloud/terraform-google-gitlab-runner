# terraform-google-gitlab-runner
Automatically build and register a Gitlab runner to your Gitlab instance.

## Introduction
Use this module of you need to set up a git lab runner for you GitLab project. The runner can be within your GCP project or you can create a separate project just for your runner.

## GitLab Registration Token
Unless you define otherwise, place the GitLab registration token in secrets manager in a secret called `RUNNER_REG_TOKEN`

## Assumptions
The runner will need access to the internet so that it can reach your GitLab instance, currently the assumption is that Cloud NAT will be in place in your project. This module will not create the Cloud NAT nor will it create a public IP on the runner instance (In fact for security sake it is not recommend to!)

The runner uses DOCKER executor - that is all.

## Instance Schedule
You can choose whether to have an instance schedule on the runner or not. This will stop the runner outside of hours to save you some money. Enable the schedule by setting the `set_schedule` boolean to `true`. If this is set it then becomes necessary to set `runner_timezone`, `runner_start` and `runner_stop` although there are default values for these.

## Service Account
You will need to create a service account for the runner, the email address can be passed to the module using `service_account_email`, you will also need to assign appropriate permissions for the runner service account so that is can execute your CI/CD, usually `OWNER`.


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| labels | Key-value map of labels to assign to the runner | `map(any)` | `{}` | no |
| name | Name of the runner instance. | `string` | `"gitlab-runner"` | no |
| network | The network to deploy to. | `string` | `"default"` | no |
| project\_id | The project to deploy to | `string` | n/a | yes |
| reg\_url | URL for gitlab instance | `string` | n/a | yes |
| region | The region to deploy to | `string` | n/a | yes |
| runner\_start | Time for runner to start | `string` | `"0 6 * * 1-5"` | no |
| runner\_stop | Time for runner to stop | `string` | `"0 18 * * 1-5"` | no |
| runner\_tags | Tags that will be assigned to the runner | `string` | `""` | no |
| runner\_timezone | Time zone for stop and start of instance to save $$$ | `string` | `"GMT"` | no |
| runner\_token | Name of secret that contains the Gitlab Runner registration token | `string` | `"RUNNER_REG_TOKEN"` | no |
| service\_account\_email | Name of the service account email, if not specified, 'gitlab-runner-sa' will be used | `string` | n/a | yes |
| set\_schedule | Enable stop/start schedule, SEE DOCUMENTATION! | `bool` | `"false"` | no |
| tags | Network tags, provided as a list | `list(string)` | `[]` | no |
| zone | The zone to deploy to | `string` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->