#!/usr/bin/env bash

git clone https://github.com/GoogleCloudPlatform/govanityurls.git \
    && cp vanity.yaml govanityurls \
    && cd govanityurls \
    && gcloud app deploy --project=opentelemetry-go
