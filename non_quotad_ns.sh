QUOTAD=`oc get ClusterResourceQuota -A -o yaml | grep "namespace:" | awk '{print $NF}' | sort`
NS=`oc get namespaces --no-headers | awk '{print $1}' | sort`

diff <(echo "$QUOTAD") <(echo "$NS") | grep ">" | awk '{print $NF}' grep -E -v "openshift-*|open-*|kube-*"
