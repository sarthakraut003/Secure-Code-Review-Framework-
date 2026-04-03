import os, json
from datetime import datetime

PROJECT_ROOT = os.path.expanduser("~/Internship_Project")
REPORT_DIR = os.path.join(PROJECT_ROOT, 'NodeGoat', 'security_reports')
OUTPUT_FILE = os.path.join(REPORT_DIR, 'grafana_metrics.json')

def process_data():
    sast, sca, secrets = 0, 0, 0
    high, med, low = 0, 0, 0

    # SCA Logic
    sca_path = os.path.join(REPORT_DIR, 'dependency-check-report.json')
    if os.path.exists(sca_path):
        with open(sca_path, 'r') as f:
            data = json.load(f)
            for dep in data.get('dependencies', []):
                vulns = dep.get('vulnerabilities', [])
                sca += len(vulns)
                for v in vulns:
                    sev = v.get('severity', 'LOW').upper()
                    if sev in ['HIGH', 'CRITICAL']: high += 1
                    elif sev == 'MEDIUM': med += 1
                    else: low += 1

    # SAST Logic
    sast_path = os.path.join(REPORT_DIR, 'semgrep-output.json')
    if os.path.exists(sast_path):
        with open(sast_path, 'r') as f:
            results = json.load(f).get('results', [])
            sast = len(results)
            for r in results:
                sev = r.get('extra', {}).get('severity', 'UNKNOWN').upper()
                if sev == "ERROR": high += 1
                elif sev == "WARNING": med += 1
                else: low += 1

    # Secrets Logic
    sec_path = os.path.join(REPORT_DIR, 'gitleaks_report.json')
    if os.path.exists(sec_path):
        with open(sec_path, 'r') as f:
            leaks = json.load(f)
            secrets = len(leaks)
            high += secrets

    metrics = {
        "timestamp": datetime.now().isoformat(),
        "total_risk": sast + sca + secrets,
        "sast_issues": sast, "sca_issues": sca, "secret_leaks": secrets,
        "high_severity": high, "medium_severity": med, "low_severity": low
    }
    with open(OUTPUT_FILE, 'w') as f:
        json.dump(metrics, f, indent=4)
    print(f"Metrics Updated! Total Risk: {metrics['total_risk']}")

if __name__ == "__main__":
    process_data()
