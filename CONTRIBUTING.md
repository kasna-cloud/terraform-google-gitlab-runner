# Contributing

This document provides guidelines for contributing to the module.

## Dependencies

The following dependencies must be installed on the development system:

- [Docker Engine][docker-engine]
- [Google Cloud SDK][google-cloud-sdk]
- [make]

## Generating Modules

Run `make build` to generate new module code.

### Submodules

The main module Terraform code is stored in the [./autogen](./autogen) folder. Changes should be made there and then reflected into the submodules via `make build`.

### Generating Documentation for Inputs and Outputs

The Inputs and Outputs tables in the READMEs of the root module,
submodules, and example modules are automatically generated based on
the `variables` and `outputs` of the respective modules. These tables
must be refreshed if the module interfaces are changed.
