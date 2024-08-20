#!/usr/bin/env bash

git clone https://github.com/open-telemetry/govanityurls.git \
    && cp vanity.yaml govanityurls \
    && cd govanityurls \
    && gcloud app deploy --project=golang-imports
