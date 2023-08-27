#!/bin/bash

NAMES=("mongodb" "mysql" "redis" "rebbitmq" "catalogue" "user" "cart" "shippig" "payment" "dispatch" "web")

for i in "${NAMES[@]}"
do
    echo "NAME :$i"
done