#!/usr/bin/env bash
set -euo pipefail

# Build Jenkins image (includes helm, kubectl, opentofu)
docker build -t local/jenkins:latest jenkins/

# Start Jenkins container (exposes 8080)
docker run -d --name jenkins -p 8080:8080 -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  -v ~/.kube:/root/.kube \
  -v /var/run/docker.sock:/var/run/docker.sock \
  local/jenkins:latest

echo "Jenkins started on http://localhost:8080"