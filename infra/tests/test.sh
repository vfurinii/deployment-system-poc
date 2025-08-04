#!/bin/bash
terraform init
terraform validate || exit 1
terraform plan || exit 1
