# terraform-google-gitlab-runner
Automatically build and register a Gitlab runner to your Gitlab instance.


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
| runner\_timezone | Time zone for stop and start of instance to save $$$ | `string` | n/a | yes |
| runner\_token | Name of secret that contains the Gitlab Runner registration token | `string` | `"RUNNER_REG_TOKEN"` | no |
| service\_account\_email | Name of the service account email, if not specified, 'gitlab-runner-sa' will be used | `string` | n/a | yes |
| set\_schedule | Enable stop/start schedule, SEE DOCUMENTATION! | `bool` | `"false"` | no |
| tags | Network tags, provided as a list | `list(string)` | `[]` | no |
| zone | The zone to deploy to | `string` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->