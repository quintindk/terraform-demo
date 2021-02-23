# Terraform 

This demo serves as means to test an applicant's `terraform`, `git` and `github actions` skills. The following are a set of instructions to complete the deployment of a Azure Kubernetes Landing Zone in Azure.

## Instructions

Please follow the set of instructions set out as follows:

1. Fork this repository.
2. Make the code changes.
3. Create a PR to this repo.

The PR will be reviewed as part of the application. Please ensure that the terraform plan output is included in the PR for review.

## Expected Architecture

You will need to complete the `main.tf` with the infrastructure as laid out in the following diagram. This shows the Azure Kubernetes landing zone with all components as it should be deployed for a customer.

![hybrid-network-hub-spoke](hybrid-network-hub-spoke.png)

> There is no need to configure the VPN Gateway for on-prem connectivity as part of this exercise.

### Modules

The following modules are included:

| Module            | Description                              | Available | Level |
|-------------------|------------------------------------------|-----------|-------|
| `acr`             | Azure Container Registry                 | Yes       | 200   |
| `aks\azure`       | Azure Kubernetes Services with Azure CNI | Yes       | 300   |
| `apim\apim`       | Azure API Management                     | Yes       | 400   |
| `kv`              | Azure Key Vault                          | Yes       | 200   |
| `nsg`             | Network Security Group                   | No        | 200   |
| `rg`              | Resource Group                           | Yes       | 200   |
| `vnet\vnet`       | Virtual Network                          | Yes       | 200   |
| `vnet\subnet_nsg` | Subnet with NSG                          | Yes       | 200   |

> You will need to add modules for some of the components listed above as missing.

### State

The terraform state does not need to be remote for this exercise.

## Expected Pipelines

Please configure Github actions pipeline to deploy the infrastructure on a PR to an environment. The Secrets for this environment are configured as:

* ARM_CLIENT_ID
* ARM_CLIENT_SECRET
* ARM_TENANT_ID
* ARM_CLIENT_ID

## Commit

Please commit as regularly as possible so that your progress can be checked at each step.
