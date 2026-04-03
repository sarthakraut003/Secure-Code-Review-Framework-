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
```bash
### 1. Provision Environment
chmod +x setup_framework.sh
./setup_framework.sh 

### 2. Start Data Bridge
chmod +x start_dashboard_server.sh
./start_dashboard_server.sh

###3. Run Security Pipeline
chmod +x demo_mode.sh
./demo_mode.sh
