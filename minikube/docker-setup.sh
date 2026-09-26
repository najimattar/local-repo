#!/bin/bash

# ============================================================
# Docker Installation Script for Jenkins Agent
# Ubuntu Linux
# ============================================================
#
# This script:
# 1. Updates Ubuntu packages
# 2. Installs prerequisites
# 3. Adds Docker's official GPG key
# 4. Adds Docker's official APT repository
# 5. Installs Docker Engine and related plugins
# 6. Enables and starts Docker
# 7. Adds the Jenkins user to the Docker group
# 8. Verifies the Docker installation
#
# IMPORTANT:
# After adding Jenkins to the docker group, the Jenkins agent
# session/service must be restarted for the permission change
# to take effect.
#
# ============================================================


# ------------------------------------------------------------
# Step 1: Update Ubuntu package information
# ------------------------------------------------------------
# Refreshes the list of available packages from Ubuntu
# repositories.
# ------------------------------------------------------------

sudo apt update


# ------------------------------------------------------------
# Step 2: Install required packages
# ------------------------------------------------------------
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
# Docker's GPG key will be stored here.
# ------------------------------------------------------------

sudo install -m 0755 -d /etc/apt/keyrings


# ------------------------------------------------------------
# Step 4: Download Docker's official GPG key
# ------------------------------------------------------------
# The GPG key allows Ubuntu's APT package manager to verify
# that Docker packages come from the official Docker repository.
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
# This tells Ubuntu to download Docker packages from Docker's
# official repository instead of relying on Ubuntu's potentially
# older Docker packages.
#
# The Ubuntu codename is detected automatically.
# Examples:
#   jammy  -> Ubuntu 22.04
#   noble  -> Ubuntu 24.04
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
# Step 7: Update APT again
# ------------------------------------------------------------
# This time Ubuntu will also read packages from Docker's
# official repository that we just added.
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
#   Container runtime used by Docker
#
# docker-buildx-plugin:
#   Enables modern Docker Buildx builds
#
# docker-compose-plugin:
#   Provides Docker Compose v2 using:
#       docker compose
# ------------------------------------------------------------

sudo apt install docker-ce docker-ce-cli containerd.io \
    docker-buildx-plugin docker-compose-plugin -y


# ------------------------------------------------------------
# Step 9: Enable Docker at system boot
# ------------------------------------------------------------
# Ensures Docker starts automatically when the Jenkins agent
# machine is rebooted.
# ------------------------------------------------------------

sudo systemctl enable docker.service
sudo systemctl enable containerd.service


# ------------------------------------------------------------
# Step 10: Start Docker
# ------------------------------------------------------------
# Starts Docker immediately without requiring a server reboot.
# ------------------------------------------------------------

sudo systemctl start docker


# ------------------------------------------------------------
# Step 11: Check Docker service status
# ------------------------------------------------------------
# This is mainly for verification.
# ------------------------------------------------------------

sudo systemctl --no-pager status docker


# ------------------------------------------------------------
# Step 12: Add Jenkins user to Docker group
# ------------------------------------------------------------
# By default, Docker commands may require sudo.
#
# Jenkins jobs normally run as the "jenkins" Linux user.
# Adding Jenkins to the docker group allows Jenkins to run:
#
#     docker ps
#     docker build
#     docker run
#     docker push
#     docker compose
#
# without sudo.
#
# IMPORTANT:
# The Jenkins agent/service must be restarted after this.
# ------------------------------------------------------------

sudo usermod -aG docker jenkins


# ------------------------------------------------------------
# Step 13: Display Docker version
# ------------------------------------------------------------
# Confirms that the Docker CLI is installed.
# ------------------------------------------------------------

docker --version


# ------------------------------------------------------------
# Step 14: Verify Docker daemon
# ------------------------------------------------------------
# This checks whether Docker can communicate with the daemon.
#
# NOTE:
# If this command gives a permission error immediately after
# usermod, restart the Jenkins session/service first.
# ------------------------------------------------------------

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
echo "Jenkins Docker group:"
groups jenkins

echo ""
echo "============================================================"
echo "IMPORTANT NEXT STEP"
echo "============================================================"
echo "Restart your Jenkins agent/service so the docker group"
echo "membership becomes active for the Jenkins process."
echo ""
echo "Then test Docker as the Jenkins user with:"
echo ""
echo "    sudo -u jenkins docker ps"
echo ""
echo "============================================================"