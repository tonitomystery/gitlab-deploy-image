#!/bin/bash
set -e

# Validaciones básicas
if [[ -z "$SSH_PRIVATE_KEY" ]]; then
  echo "ERROR: SSH_PRIVATE_KEY no está definido"
  exit 1
fi

echo "Setting up SSH key..."

# Setup SSH directory y permisos
mkdir -p ~/.ssh
chmod 700 ~/.ssh
eval "$(ssh-agent -s)"
echo "$SSH_PRIVATE_KEY" | tr -d '\r' > ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa

# Disable strict host key checking
printf "Host *\n\tStrictHostKeyChecking no\n" > ~/.ssh/config
chmod 600 ~/.ssh/config

# Add key to SSH agent
ssh-add ~/.ssh/id_rsa

 
