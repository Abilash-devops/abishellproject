#!/bin/bash

NAMES=("dev" "QA" "preprod" "prod")
INSTANCE_TYPE=""
IMAGE_ID=ami-03265a0778a880afb
SECUIRTY_GROUP=sg-00e1606b168b9215a

for i in "${NAMES[@]}"
do
    if [[ $i == preprod || $i == prod ]]
    then
    INSTANCE_TYPE="t3.medium"
    else
    INSTACE_TYPE="t2.micro"
    echo "Creating $i instance"
    IP_ADDRESS=$(aws ec2 run-instances --image-id $IMAGE_ID --instance-type $INSTANCE_TYPE --security-group-ids $SECURITY_GROUP --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$i}]" | jq -r '.Instances[0].PrivateIpAddress') 
    echo "created $i instance: $IP_ADDRESS"
    fi

done