#!/bin/bash
PROJECT_ROOT="$HOME/Internship_Project"
TARGET_DIR="$PROJECT_ROOT/NodeGoat"
REPORT_DIR="$TARGET_DIR/security_reports"
TOOL_DIR="$PROJECT_ROOT/dependency-check/bin"

LOG_FILE="$REPORT_DIR/pipeline_$(date +%Y%m%d_%H%M%S).log"
exec > >(tee -a "$LOG_FILE") 2>&1 

echo "PHASE 1: Secret Detection (Gitleaks)..."
docker run --rm -v "$TARGET_DIR:/path" zricethezav/gitleaks:latest detect \
    --source="/path" --report-path="/path/security_reports/gitleaks_report.json" --no-git

echo "PHASE 2: Supply Chain Analysis (SCA)..."
"$TOOL_DIR/dependency-check.sh" \
    --project "NodeGoat" --scan "$TARGET_DIR" \
    --exclude "$TARGET_DIR/node_modules" \
    --format "JSON" --out "$REPORT_DIR" --noupdate --disableAssembly

echo "PHASE 3: Static Code Analysis (Semgrep)..."
docker run --rm -v "$TARGET_DIR:/src" returntocorp/semgrep semgrep \
    --config="p/security-audit" --json --output=semgrep-output.json /src > /dev/null 2>&1
mv "$TARGET_DIR/semgrep-output.json" "$REPORT_DIR/"

echo "PHASE 4: Data Transformation (ETL)..."
python3 "$PROJECT_ROOT/glue.py"

echo "PIPELINE SUCCESSFUL!"
