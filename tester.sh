#!/usr/bin/env bash

docker run \
  -it -w $PWD -v $PWD:$PWD \
  -e TAG="testing" \
  awsbatch/awsbatch_run_cctyper_dev
