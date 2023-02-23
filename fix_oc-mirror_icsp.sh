echo "What is the name of the operator?"
read name

cp mapping.txt mapping.txt.new

sed -i "/registry.redhat.io\/redhat\/.*-operator-index:v/d" mapping.txt.new
sed -i 's/@.*=/=/' mapping.txt.new

MAPPING=`cat mapping.txt.new`
echo "$MAPPING" | grep -o ".*:.*:" > mapping.txt.new
sed -i 's/.$//g' mapping.txt.new

echo "apiVersion: operator.openshift.io/v1alpha1
kind: ImageContentSourcePolicy
metadata:
  name: $name
spec:
  repositoryDigestMirrors:" > icsp-new.yaml

while IFS= read -r line
do
        IFS== read -r left right <<< `echo $line`
        echo -e "  - mirrors:
    - $right
    source: $left" >> icsp-new.yaml
done < "mapping.txt.new"

rm -f mapping.txt.new

sed 's/  name:.*/  name: '"$name"'/' catalogSource-*\.yaml > cs-new.yaml
