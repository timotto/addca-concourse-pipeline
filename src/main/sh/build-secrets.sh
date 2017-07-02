#!/bin/sh -e

build="secrets-output"

cat <<EOT > "${build}/secrets.yaml"
git-private-key: |
EOT

echo "${git_private_key}" | while read line; do
	echo "  $line"
done >> "${build}/secrets.yaml"

cat <<EOT >> "${build}/secrets.yaml"
certificates-git: ${certificates_git}
docker-images-git: ${docker_images_git}
addca-git: ${addca_git}
addca-git-branch: ${addca_git_branch}
docker-registry-username: ${docker_registry_username}
docker-registry-password: ${docker_registry_password}
docker-registry-prefix: ${docker_registry_prefix}
concourse-target: ${concourse_target}
concourse-insecure: ${concourse_insecure}
concourse-team: ${concourse_team}
concourse-username: ${concourse_username}
concourse-password: ${concourse_password}
concourse-pipeline: ${concourse_pipeline}
EOT
