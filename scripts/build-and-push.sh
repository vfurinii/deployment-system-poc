  #!/usr/bin/env bash
  set -euo pipefail

  IMAGE_NAME=localhost:5000/myapp:latest

  # Build docker image (from app/Dockerfile)
  docker build -t ${IMAGE_NAME} app/

  # Push to local registry
  docker push ${IMAGE_NAME}

  # Optionally, tag to minikube internal registry
  # minikube image load ${IMAGE_NAME}

  echo "Image pushed: ${IMAGE_NAME}"