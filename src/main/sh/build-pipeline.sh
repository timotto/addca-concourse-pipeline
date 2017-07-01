#!/bin/sh -e

# Build the pipeline

build="pipeline-output"

while read name tag flavor; do 
	flatname="$(echo "$name" | tr / _)"
	cat ca-src/src/main/concourse/pipeline.jobs.template.yaml | \
		sed \
			-es'^_NAME_^'"$name"'^' \
			-es'^_FLATNAME_^'"$flatname"'^' \
			-es'^_TAG_^'"$tag"'^' \
			-es'^_FLAVOR_^'"$flavor"'^' \
			-es'^_PREFIX_^'"$prefix"'^' \
		>> ${build}/jobs
	cat ca-src/src/main/concourse/pipeline.resources.template.yaml | \
		sed \
			-es'^_NAME_^'"$name"'^' \
			-es'^_FLATNAME_^'"$flatname"'^' \
			-es'^_TAG_^'"$tag"'^' \
			-es'^_FLAVOR_^'"$flavor"'^' \
			-es'^_PREFIX_^'"$prefix"'^' \
		>> ${build}/resources
done < docker-images/src/docker-images.txt

cat <<EOT > ${build}/sed
/_JOBS_/ {
  r ${build}/jobs
  d
}
/_RESOURCES_/ {
  r ${build}/resources
  d
}
EOT

sed \
	-f ${build}/sed \
	ca-src/src/main/concourse/pipeline.template.yaml \
> ${build}/pipeline.yaml
