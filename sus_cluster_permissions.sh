#!/bin/bash

# Colors
RED="\e[31m"
BLACK="\e[30m"
BG_RED="\e[41m"
BG_GREY="\e[107m"
UL_WHITE="\e[4;37m"
NO_COLOR="\e[0m"

# Make sure you have oc and updated yq commands
if ! which oc > /dev/null; then echo; echo -e "${RED}You must have 'oc' command installed${NO_COLOR}"; echo; exit 1; fi
if ! which yq > /dev/null; then echo; echo -e "${RED}You must have 'yq v4.18' or greater command installed${NO_COLOR}"; echo; exit 1; fi



function findRoleRef {
  echo "$YAML" | yq 'map(select(.roleRef.name == "'"$1"'")) | del(.[].roleRef)' | sed 's/^- kind:/\n- kind:/g'
  echo
}

YAML=`oc get rolebindings,clusterrolebindings -A -o yaml | yq 'del(.items[] ["apiVersion"]) | del(.items[].subjects[].apiGroup) | .items | .[] |= (.metadata |= with_entries(select(.key == "name" or .key == "namespace"))) | map(select(.subjects[].namespace | test("^openshift-") | not or .subjects[].namespace == null)) | map(select(.subjects[].name | test("^system:") | not))'`

for roleRef in cluster-admin `oc get scc -o name | cut -d / -f 2 | sed s/^/system:openshift:scc:/g`;
do
  customRoleRef=`echo "$roleRef" | tr '[:lower:]' '[:upper:]' | cut -d : -f 4`
  echo -n -e "${UL_WHITE}${BG_RED}"
  [ "$roleRef" == "cluster-admin" ] && echo -n -e "$customRoleRef": || echo -n -e "SCC $customRoleRef":
  echo -e "${NO_COLOR}"
  findRoleRef "$roleRef"
done

echo
echo
echo
echo -e "${BG_GREY}${BLACK}COMPLETED!${NO_COLOR}"
