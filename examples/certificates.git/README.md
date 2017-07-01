# Certificates

This repository contains the PEM encoded certificate authority files to include in docker images.

## Usage

You need a certificate signed by each CA you want to include for the tests to work.

Each certificate has to be PEM encoded. 

The filename must end in ".crt". 

Put the certificates to include into the docker images inside the directory "src/main/".

Put certificates signed by those CAs inside the directory "src/test/" with the exact same filename.

If a CA is not a root CA, then you also need to add the root CA and all intermediate certificates up to the one you want to include inside a file "src/file/<NAME.CRT>.trusted".

