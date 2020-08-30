#!/usr/bin/env bash

set -e
set -o nounset
set -o pipefail

script_dir=$(cd "$(dirname "$0")" ; pwd -P)

check_prerequisites() {
  if [ ! session-manager-plugin ]; then
    echo "ERROR: Session Manager Plugin required. Download it here: https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html"
    exit 1
  fi
}

goal_run-ehrmantraut() {
  pushd "${script_dir}" > /dev/null
    check_prerequisites
    instance_id=$(aws ec2 describe-instances \
               --profile tortugas-developer \
               --region eu-central-1 \
               --filter "Name=tag:Name,Values=sars-cov-2-ehrmantraut" \
               --query "Reservations[].Instances[?State.Name == 'running'].InstanceId[]" \
               --output text)
    aws ssm start-session --target $instance_id \
      --profile tortugas-developer \
      --region eu-central-1 \
      --document-name AWS-StartPortForwardingSession \
      --parameters '{"portNumber":["80"],"localPortNumber":["9999"]}'
  popd > /dev/null
}

goal_start-session() {
 pushd "${script_dir}" > /dev/null
    check_prerequisites
    instance_id=$(aws ec2 describe-instances \
               --profile tortugas-developer \
               --region eu-central-1 \
               --filter "Name=tag:Name,Values=sars-cov-2-ehrmantraut" \
               --query "Reservations[].Instances[?State.Name == 'running'].InstanceId[]" \
               --output text)
    aws ssm start-session --target $instance_id \
      --profile tortugas-developer \
      --region eu-central-1
  popd > /dev/null
}

TARGET=${1:-}
if type -t "goal_${TARGET}" &>/dev/null; then
  "goal_${TARGET}" ${@:2}
else
  echo "Usage: $0 <goal>

goal:
    run-ehrmantraut             - Port Forwards MLFlow to localhost:9999
    start-session               - Starts a Systems Manager session
"
  exit 1
fi
