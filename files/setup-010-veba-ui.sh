#!/bin/bash
# Copyright 2021 VMware, Inc. All rights reserved.
# SPDX-License-Identifier: BSD-2

# Setup Knative UI

set -euo pipefail

echo -e "\e[92mSetting up VEBA UI RBAC ..." > /dev/console
kubectl apply -f /root/config/veba-ui/veba-ui-rbac.yaml

echo -e "\e[92mSetting up VEBA UI Secret ..." > /dev/console
eval "kubectl -n vmware-system create secret generic veba-ui-secret \
    --from-literal=VCENTER_FQDN=${ESCAPED_VCENTER_SERVER} \
    --from-literal=VCENTER_PORT=443 \
    --from-literal=VCENTER_USER=${ESCAPED_VCENTER_USERNAME_FOR_VEBA_UI} \
    --from-literal=VCENTER_PASS=${ESCAPED_VCENTER_PASSWORD_FOR_VEBA_UI} \
    --from-literal=VEBA_FQDN=${HOSTNAME}"

VEBA_BOM_FILE=/root/config/veba-bom.json

# VEBA UI Config Files
VEBA_UI_TEMPLATE=/root/config/veba-ui/templates/veba-ui-template.yaml
VEBA_UI_CONFIG=/root/config/veba-ui/veba-ui.yaml

# Apply YTT overlay
ytt --data-value-file bom=${VEBA_BOM_FILE} -f ${VEBA_UI_TEMPLATE} > ${VEBA_UI_CONFIG}

echo -e "\e[92mSetting up VEBA UI ..." > /dev/console
kubectl apply -f ${VEBA_UI_CONFIG}