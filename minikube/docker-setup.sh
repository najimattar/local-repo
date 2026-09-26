#!/bin/bash

# ============================================================
# Docker Installation Script for Jenkins Agent
# Ubuntu Linux
# ============================================================
#
# This script:
#
# 1. Updates Ubuntu packages
# 2. Installs Docker prerequisites
# 3. Adds Docker's official GPG key
# 4. Adds Docker's official APT repository
# 5. Installs Docker Engine
# 6. Enables and starts Docker
# 7. Adds the "ubuntu" user to the Docker group
# 8. Verifies the Docker installation
#
# IMPORTANT:
# Jenkins connects to this agent using the "ubuntu" user.
#
# Therefore, we add:
#
#       ubuntu -> docker group
#
# This allows the Jenkins agent process running as "ubuntu"
# to execute Docker commands without sudo.
#
# ============================================================


# ------------------------------------------------------------
# Step 1: Update Ubuntu package information
# ------------------------------------------------------------

sudo apt update


# ------------------------------------------------------------
# Step 2: Install required packages
# ------------------------------------------------------------
#
# ca-certificates:
#   Allows the system to verify HTTPS certificates.
#
# curl:
#   Used to download Docker's official GPG signing key.
# ------------------------------------------------------------

sudo apt install ca-certificates curl -y


# ------------------------------------------------------------
# Step 3: Create APT keyrings directory
# ------------------------------------------------------------
#
# Docker's GPG key will be stored here.
# ------------------------------------------------------------

sudo install -m 0755 -d /etc/apt/keyrings


# ------------------------------------------------------------
# Step 4: Download Docker's official GPG key
# ------------------------------------------------------------
#
# The GPG key allows APT to verify Docker packages.
# ------------------------------------------------------------

sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
    -o /etc/apt/keyrings/docker.asc


# ------------------------------------------------------------
# Step 5: Make Docker's GPG key readable
# ------------------------------------------------------------

sudo chmod a+r /etc/apt/keyrings/docker.asc


# ------------------------------------------------------------
# Step 6: Add Docker's official APT repository
# ------------------------------------------------------------
#
# The Ubuntu version/codename is detected automatically.
#
# Examples:
#   Ubuntu 22.04 -> jammy
#   Ubuntu 24.04 -> noble
# ------------------------------------------------------------

sudo tee /etc/apt/sources.list.d/docker.sources > /dev/null <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF


# ------------------------------------------------------------
# Step 7: Update APT
# ------------------------------------------------------------
#
# Ubuntu will now read packages from Docker's official
# repository.
# ------------------------------------------------------------

sudo apt update


# ------------------------------------------------------------
# Step 8: Install Docker
# ------------------------------------------------------------
#
# docker-ce:
#   Docker Engine
#
# docker-ce-cli:
#   Docker command-line interface
#
# containerd.io:
#   Container runtime
#
# docker-buildx-plugin:
#   Modern Docker build functionality
#
# docker-compose-plugin:
#   Docker Compose v2
# ------------------------------------------------------------

sudo apt install docker-ce docker-ce-cli containerd.io \
    docker-buildx-plugin docker-compose-plugin -y


# ------------------------------------------------------------
# Step 9: Enable Docker at system boot
# ------------------------------------------------------------
#
# Docker will automatically start after an Ubuntu reboot.
# ------------------------------------------------------------

sudo systemctl enable docker.service
sudo systemctl enable containerd.service


# ------------------------------------------------------------
# Step 10: Start Docker
# ------------------------------------------------------------

sudo systemctl start docker


# ------------------------------------------------------------
# Step 11: Check Docker service
# ------------------------------------------------------------

sudo systemctl --no-pager status docker


# ============================================================
#                 DOCKER PERMISSION FOR UBUNTU
# ============================================================


# ------------------------------------------------------------
# Step 12: Add ubuntu user to Docker group
# ------------------------------------------------------------
#
# Jenkins connects to this machine using:
#
#       Username: ubuntu
#
# Jenkins therefore runs the agent process as the "ubuntu"
# Linux user.
#
# Adding ubuntu to the Docker group allows commands such as:
#
#       docker ps
#       docker images
#       docker build
#       docker run
#       docker push
#       docker compose
#
# to work WITHOUT sudo.
#
# ------------------------------------------------------------

sudo usermod -aG docker ubuntu


# ------------------------------------------------------------
# Step 13: Verify Docker group membership
# ------------------------------------------------------------

echo ""
echo "Docker group information:"
getent group docker


echo ""
echo "Ubuntu user groups:"
groups ubuntu


# ============================================================
#                    VERIFICATION
# ============================================================


echo ""
echo "============================================================"
echo "Docker installation completed."
echo "============================================================"

echo ""
echo "Docker version:"
docker --version

echo ""
echo "Docker service:"
sudo systemctl is-active docker

echo ""
echo "Docker socket:"
ls -l /var/run/docker.sock

echo ""
echo "============================================================"
echo "IMPORTANT NEXT STEP"
echo "============================================================"
echo ""
echo "The ubuntu user was added to the docker group."
echo ""
echo "You MUST log out and log back in, or restart the Jenkins"
echo "agent, before Docker works without sudo."
echo ""
echo "After reconnecting, test:"
echo ""
echo "    groups"
echo "    docker ps"
echo "    docker images"
echo "    docker run hello-world"
echo ""
echo "============================================================"
