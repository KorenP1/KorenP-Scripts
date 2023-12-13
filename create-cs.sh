OPERATORS=`curl -s REGISTRY_IP/v2/_catalog | jq -r .repositories[] | grep ^catalogsource/ | cut -d / -f 2`
OPERATOR_COUNT=`echo "$OPERATORS" | wc -l`
SEQ_WITH_OPERATORS=`paste <(seq 1 $OPERATOR_COUNT) <(echo "$OPERATORS")`

CHOSEN_OPERATOR=$(dialog --clear --title "Catalog Source Creation" --menu "Select Operator" 20 50 $OPERATOR_COUNT $SEQ_WITH_OPERATORS 2>&1 >/dev/tty)
OPERATOR_NAME=`echo $OPERATORS | cut -d ' ' -f $CHOSEN_OPERATOR`
CHOSEN_OPERATOR="catalogsource/$OPERATOR_NAME"

TAGS=`curl -s REGISTRY_IP/v2/$CHOSEN_OPERATOR/tags/list | jq -r .tags[]`
TAG_COUNT=`echo "$TAGS" | wc -l`
SEQ_WITH_TAGS=`paste <(seq 1 $TAG_COUNT) <(echo "$TAGS")`
CHOSEN_TAG=$(dialog --clear --title "Catalog Source Creation" --menu "Select Tag" 20 50 $TAG_COUNT $SEQ_WITH_TAGS 2>&1 >/dev/tty)
CHOSEN_TAG=`echo $TAGS | cut -d ' ' -f $CHOSEN_TAG`

IMAGE=$CHOSEN_OPERATOR:$CHOSEN_TAG



echo
echo
echo
echo "apiVersion: operators.coreos.com/v1alpha1
kind: CatalogSource
metadata:
  name: $OPERATOR_NAME
  namespace: openshift-marketplace
spec:
  sourceType: grpc
  image: openshift/$IMAGE"
echo
echo
echo
