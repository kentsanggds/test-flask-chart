#!/bin/bash

echo "Usage: <arg1 = app name (default: test-flask)> <arg2 = scrape (true|default: false)>"

APP=${1}
SCRAPE=${2}
if [ -z "${1}" ] ; then
    APP=test-flask
fi

if [ -z "${2}" ] ; then
    SCRAPE=false
fi

helm template --name v1 --set scrape.enabled=true --set app.name=${APP} --output-dir=output .
gsp -t example -e dev -p amazon exec -- k apply -R -f output
gsp -t example -e dev -p amazon exec -- k get all
