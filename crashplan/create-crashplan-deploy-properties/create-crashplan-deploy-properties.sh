#!/bin/bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2026 libertymatters7 (https://github.com/libertymatters7)
#
# create-crashplan-deploy-properties.sh
# Creates the CrashPlan deploy.properties file with the deployment URL and
# policy token so the CrashPlan client registers automatically on install.
# Run as root before installing the CrashPlan client.

DEPLOYMENT_URL="https://your-crashplan-server.example.com"
DEPLOYMENT_POLICY_TOKEN="your-deployment-policy-token"
CP_SILENT="true"        # true = app does not open after install
DEVICE_CLOAKED="false"  # match the org Client Visibility setting (false = Visible, true = Hidden)

DEPLOY_DIR="/Library/Application Support/CrashPlan"
DEPLOY_FILE="${DEPLOY_DIR}/deploy.properties"

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

mkdir -p "$DEPLOY_DIR"

cat > "$DEPLOY_FILE" <<EOF
DEPLOYMENT_URL=${DEPLOYMENT_URL}
DEPLOYMENT_POLICY_TOKEN=${DEPLOYMENT_POLICY_TOKEN}
CP_SILENT=${CP_SILENT}
DEVICE_CLOAKED=${DEVICE_CLOAKED}
EOF

chown root:wheel "$DEPLOY_FILE"
chmod 644 "$DEPLOY_FILE"

echo "Created $DEPLOY_FILE"
exit 0
