#!/bin/bash

# ============================================================
# Minikube + kubectl Installation Script
# For Ubuntu Jenkins Agent
# ============================================================
#
# This script installs:
#
#   1. kubectl
#      Kubernetes command-line tool
#
#   2. Minikube
#      Local Kubernetes cluster
#
#   3. Configures Minikube to use Docker as the container driver
#
# IMPORTANT:
# This script assumes Docker is already installed.
#
# The Jenkins user will be added to the Docker group so that
# Jenkins can run Minikube/Docker commands without sudo.
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
# curl:
#   Downloads kubectl and Minikube packages.
#
# ca-certificates:
#   Allows HTTPS certificate verification.
#
# conntrack:
#   Required by Kubernetes/Minikube networking components.
#
# ------------------------------------------------------------

sudo apt install -y curl ca-certificates conntrack


# ============================================================
#                    INSTALL kubectl
# ============================================================


# ------------------------------------------------------------
# Step 3: Download the latest stable kubectl version
# ------------------------------------------------------------
#
# kubectl is the Kubernetes command-line client.
#
# Example commands:
#
#   kubectl get nodes
#   kubectl get pods
#   kubectl get services
#   kubectl apply -f deployment.yaml
#
# ------------------------------------------------------------

KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)

echo "Installing kubectl version: ${KUBECTL_VERSION}"


# ------------------------------------------------------------
# Step 4: Download kubectl
# ------------------------------------------------------------

curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"


# ------------------------------------------------------------
# Step 5: Install kubectl
# ------------------------------------------------------------

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl


# ------------------------------------------------------------
# Step 6: Remove downloaded kubectl file
# ------------------------------------------------------------

rm -f kubectl


# ------------------------------------------------------------
# Step 7: Verify kubectl installation
# ------------------------------------------------------------

echo ""
echo "kubectl version:"
kubectl version --client


# ============================================================
#                    INSTALL MINIKUBE
# ============================================================


# ------------------------------------------------------------
# Step 8: Download Minikube
# ------------------------------------------------------------
#
# Minikube creates and manages a Kubernetes cluster on a
# single machine.
#
# We will use Docker as the Minikube driver.
#
# ------------------------------------------------------------

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64


# ------------------------------------------------------------
# Step 9: Install Minikube
# ------------------------------------------------------------

sudo install minikube-linux-amd64 /usr/local/bin/minikube


# ------------------------------------------------------------
# Step 10: Remove downloaded Minikube file
# ------------------------------------------------------------

rm -f minikube-linux-amd64


# ------------------------------------------------------------
# Step 11: Verify Minikube installation
# ------------------------------------------------------------

echo ""
echo "Minikube version:"
minikube version


# ============================================================
#              CONFIGURE DOCKER FOR JENKINS
# ============================================================


# ------------------------------------------------------------
# Step 12: Add Jenkins user to Docker group
# ------------------------------------------------------------
#
# Minikube will use Docker as its driver.
#
# Jenkins therefore needs permission to communicate with the
# Docker daemon without sudo.
#
# ------------------------------------------------------------

sudo usermod -aG docker jenkins


# ------------------------------------------------------------
# Step 13: Set Docker as Minikube's default driver
# ------------------------------------------------------------
#
# This means:
#
#     minikube start
#
# will use Docker instead of VirtualBox, KVM, etc.
#
# ------------------------------------------------------------

sudo -u jenkins minikube config set driver docker


# ============================================================
#                    VERIFICATION
# ============================================================


echo ""
echo "============================================================"
echo "Installation completed."
echo "============================================================"

echo ""
echo "kubectl:"
kubectl version --client

echo ""
echo "Minikube:"
minikube version

echo ""
echo "Docker:"
docker --version

echo ""
echo "============================================================"
echo "IMPORTANT"
echo "============================================================"
echo ""
echo "Restart the Jenkins agent/service before starting Minikube."
echo ""
echo "After restarting Jenkins, run:"
echo ""
echo "    minikube start --driver=docker"
echo ""
echo "Then verify:"
echo ""
echo "    kubectl get nodes"
echo "    kubectl get pods -A"
echo ""
echo "============================================================"