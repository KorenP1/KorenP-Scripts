#!/bin/bash

# Need jq

# Colors
RED="\e[31m"
CYAN="\e[36m"
NC="\e[0m"

# Exit if crq not declared
[[ -z "$1" ]] && echo -e "${RED}Must declare a CRQ${NC}" && exit 0

# Get Namespaces and parse
namespaces=`oc get clusterresourcequota "$1" -o json | jq -r '.status[][].namespace' | grep | sed '/null/d'`

# Loop through namespaces and get pvc's
for ns in $namespaces
do
  echo -e "${CYAN}Namespace -> $ns${NC}"
  oc get pvc --no-headers -n "$ns"
  echo
done
