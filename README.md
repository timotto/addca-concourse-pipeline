# AddCA Concourse Pipeline

The purpose of the pipeline is to add CA certificates to docker images, so those docker images can be used in an environment where non-public Certificate Authorities are required to function properly.

The certificates are read from a user defined git repository. An example and a README.md for the expected layout of the certificates git repository is at the directory "examples/certificates.git/".

Another required git repository manages a single text file with a list of docker images which shall be enriched with the CA certificates. An example of the git repository layout as well as the text file format is at the directory "examples/docker-images.git".

## Setup

Create the two required git repositories. Then run the shell script "src/main/sh/bootstrap.sh". It will create the files "build/pipeline.yaml" as well as "build/secrets.yaml" with the latter one being a copy of "secrets.example.yaml". Modify the created file "build/secrets.yaml" to match your environment. It will not be overwritten if you run "bootstrap.sh" again.

Assuming you configured "build/secrets.yaml" for a concourse pipeline named "addca" with a fly target "target" run

fly -t target set-pipeline -p addca -c build/pipeline.yaml -l build/secrets.yaml

to bootstrap the pipeline. It will listen on the git repositories and add more jobs as docker images are added to the "docker-images.txt" file in the docker images git repository.

## Setup-and-Forget

The pipeline triggers on the git repositories as well as on the source docker images. As soon as an update for a registered docker image is published, the pipeline will create an enriched version.
