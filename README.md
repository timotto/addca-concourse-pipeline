# AddCA Concourse Pipeline

The purpose of the pipeline is to add CA certificates to docker images, so those docker images can be used in an environment where non-public Certificate Authorities are required to function properly.

The certificates are read from a user defined git repository. An example and a README.md for the expected layout of the certificates git repository is at the directory "examples/certificates.git/".

Another required git repository manages a single text file with a list of docker images which shall be enriched with the CA certificates. An example of the git repository layout as well as the text file format is at the directory "examples/docker-images.git".

## Setup

Create the two required git repositories as well as an SSH key to access them. 

Create a copy of "secrets.example.yaml" and modify it to match your environment.

Start the pipeline by setting the bootstrap.pipeline.yaml file. The pipeline will execute the bootstrap-pipeline.yaml task, which builds the initial empty pipeline using the bootstrap.sh script. Afterwards the pipeline will re-set itself to the created pipeline. This new pipeline will be able to check the configured git repositories and grow by itself.

## Setup-and-Forget

The pipeline triggers on the git repositories as well as on the source docker images. As soon as an update for a registered docker image is published, the pipeline will create an enriched version.
