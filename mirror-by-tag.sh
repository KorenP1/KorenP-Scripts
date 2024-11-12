echo "Please enter the source registry path (Where located in internet) without tag"
read source
echo "Please enter the mirror registry path without tag"
read mirror
cat << EOF > mirror.conf
[[registry]]
prefix = ""
location = "$source"
mirror-by-digest-only = false

[[registry.mirror]]
location = "$mirror"
EOF
based=$(cat mirror.conf | base64 -w0)
rm -f mirror.conf
mc_name=$(sed 's/\./-/g; s/\//-/g' <<< $source)
cat << EOF > $mc_name-mirror-by-tag.yaml
apiVersion: machineconfiguration.openshift.io/v1
kind: MachineConfig
metadata:
  labels:
    machineconfiguration.openshift.io/role: worker
  name: $nc_name
spec:
  config:
    ignition:
      version: 3.2.0
    storage:
      files:
        - contents:
            source: data: text/plain; charset=utf-8;base64, $based
          mode: 420
          path: /etc/containers/registries.conf.d/$mc_name.conf
