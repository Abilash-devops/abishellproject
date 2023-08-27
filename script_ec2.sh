#!/bin/bash

NAMES=("dev" "QA" "preprod" "prod")

for i in "${NAMES[@]}"
do
    echo "NAME :$i"
done