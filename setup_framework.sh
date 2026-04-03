#!/bin/bash
# ============================================================
#  SECURE CODE REVIEW FRAMEWORK - MASTER INSTALLER
# ============================================================
set -e 

PROJECT_ROOT="$HOME/Internship_Project"
mkdir -p "$PROJECT_ROOT/grafana_data"
cd "$PROJECT_ROOT"

echo "Installing System Dependencies..."
sudo apt-get update -q
sudo apt-get install -y docker.io git python3 npm nodejs unzip wget > /dev/null
sudo systemctl enable docker --now

echo "Setting up NodeGoat Environment..."
if [ ! -d "NodeGoat" ]; then
    git clone https://github.com/OWASP/NodeGoat.git
fi
cd NodeGoat && npm install --silent && mkdir -p security_reports && cd ..

echo "Downloading Security Tools..."
docker pull zricethezav/gitleaks:latest
docker pull returntocorp/semgrep:latest

if [ ! -d "dependency-check" ]; then
    wget -q https://github.com/jeremylong/DependencyCheck/releases/download/v12.0.2/dependency-check-12.0.2-release.zip
    unzip -q dependency-check-12.0.2-release.zip
    chmod +x dependency-check/bin/dependency-check.sh
fi

echo "Syncing NVD Database..."
./dependency-check/bin/dependency-check.sh --updateonly --nvdApiKey fc01f457-abc6-41c5-9b9c-498182d65693

echo "INSTALLATION COMPLETE."
