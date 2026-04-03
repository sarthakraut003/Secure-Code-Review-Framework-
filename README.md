# Secure-Code-Review-Framework-
Automated pipeline that integrates SAST, SCA, and Secret Scanning into the SDLC. Built a custom Python ETL layer to aggregate raw JSON reports from Gitleaks, Semgrep, and OWASP Dependency-Check into a real-time Grafana dashboard, reducing security audit overhead and enabling immediate vulnerability remediation

# Automated DevSecOps Orchestration Framework

![DevSecOps Pipeline](https://img.shields.io/badge/Security-Shift--Left-green)
![Python ETL](https://img.shields.io/badge/Data-Python%20ETL-blue)
![Docker](https://img.shields.io/badge/Infra-Docker-blue)

## 🚀 Overview
This repository contains a hardened, "Shift-Left" security framework designed to automate vulnerability detection within the SDLC. It orchestrates SAST, SCA, and Secret Scanning into a unified workflow, normalizing disparate data into a real-time Grafana dashboard.



## 🛠️ Tech Stack
- **Languages:** Bash, Python 3 (ETL).
- **Security Tools:** Semgrep (SAST), Gitleaks (Secrets), OWASP Dependency-Check (SCA).
- **Visualization:** Grafana with Infinity Datasource.
- **Infrastructure:** Docker, Python HTTP Bridge (172.17.0.1).

## 🛡️ Key Features
- **Automated Orchestration:** Single-command execution for full-stack security audits.
- **Resilient ETL:** Custom Python logic to aggregate nested JSON reports into a unified metrics schema.
- **Recursive Scan Protection:** Dynamic `.gitleaksignore` generation to eliminate false positives in logs.
- **Enterprise Portability:** Network-agnostic bridge binding to the Docker gateway for seamless dashboard connectivity.

## 📖 Getting Started

### 🛠️ Installation & Usage Guide

To ensure a seamless deployment, follow these instructions in sequence. This framework is designed to run on a clean **Kali Linux** or **Ubuntu** environment.

### **1. Prerequisites**
Before beginning, ensure you have `git` installed on your host machine.
```bash
sudo apt-get update && sudo apt-get install -y git
```

### **2. Clone the Repository**
Clone the framework and navigate into the project root.
```bash
git clone https://github.com/your-username/your-repo-name.git
cd your-repo-name
```

### **3. Provision the Environment**
Run the master installation script. This will provision Docker, install Node.js dependencies for NodeGoat, pull the necessary security tool images, and sync the National Vulnerability Database (NVD).
```bash
# Grant execution permissions
chmod +x setup_framework.sh

# Execute the setup
./setup_framework.sh
```
> **Note:** This step may take several minutes depending on your internet speed as it downloads the full NVD local cache.

---

## 🚀 Running the Pipeline

Once the environment is provisioned, you can execute the security orchestration sequence.

### **Step 1: Start the Data Bridge**
In a **new terminal**, start the portable HTTP server. This binds the security artifacts to the Docker gateway (`172.17.0.1`), allowing Grafana to pull real-time data.
```bash
chmod +x start_dashboard_server.sh
./start_dashboard_server.sh
```

### **Step 2: Execute the Security Scan**
In your primary terminal, run the orchestrator. This script chains **Gitleaks**, **OWASP Dependency-Check**, and **Semgrep**, followed by the **Python ETL** normalization.
```bash
chmod +x demo_mode.sh
./demo_mode.sh
```



---

## 📊 Dashboard Visualization

1.  **Launch Grafana:** Access your local Grafana instance (typically `http://localhost:3000`).
2.  **Install Plugin:** Ensure the **Yesoreyeram Infinity Datasource** is installed.
3.  **Import Dashboard:** * Navigate to **Dashboards** > **New** > **Import**.
    * Upload the `grafana/dashboard.json` file from this repository.
4.  **Data Source URL:** Ensure the Infinity datasource is pointing to `http://172.17.0.1:9999/grafana_metrics.json`.

---

## 📂 File Manifest & Descriptions

| File | Description |
| :--- | :--- |
| `setup_framework.sh` | **Infrastructure Engine:** Provisions Docker, Node.js, and scanner binaries. |
| `demo_mode.sh` | **Pipeline Orchestrator:** Manages tool sequencing and generates immutable audit logs. |
| `glue.py` | **ETL Middleware:** Normalizes raw JSON artifacts into a unified metrics schema. |
| `start_dashboard_server.sh` | **Network Bridge:** Serves metrics on port 9999 bound to the 172-series Docker gateway. |

---
