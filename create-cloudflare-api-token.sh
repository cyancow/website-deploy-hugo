#!/usr/bin/env bash

yamlTemplate=$(cat cert-manager/api-token-secret.yaml.tmpl)
printf "cat << EOF\n${yamlTemplate}\nEOF" | bash | kubectl apply -f -