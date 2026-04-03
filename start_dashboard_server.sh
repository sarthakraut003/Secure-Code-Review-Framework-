#!/bin/bash
PROJECT_ROOT="$HOME/Internship_Project"
cd "$PROJECT_ROOT/NodeGoat/security_reports" || exit 1
echo "Hosting metrics at: http://172.17.0.1:9999/"
# Binding to 172.17.0.1 ensures the Grafana container can reach the host
python3 -m http.server 9999 --bind 172.17.0.1
