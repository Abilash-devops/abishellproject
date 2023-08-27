#!/bin/bash

NAMES=("dev" "QA" "preprod" "prod")
INSTANCE_TYPE=""
IMAGE_ID=ami-03265a0778a880afb
SECUIRTY_GROUP=sg-00e1606b168b9215a
DOMAIN_NAME=abilashhareendran.in

for i in "${NAMES[@]}"
do
    if [[ $i == preprod || $i == prod ]]
    then
    INSTANCE_TYPE="t3.medium"
    else
    INSTANCE_TYPE="t2.micro"
    fi
    echo "Creating $i instance"
    IP_ADDRESS=$(aws ec2 run-instances --image-id $IMAGE_ID --instance-type $INSTANCE_TYPE --security-group-ids $SECURITY_GROUP --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$i}]" | jq -r '.Instances[0].PrivateIpAddress') 
    echo "created $i instance: $IP_ADDRESS"

    aws route53 change-resource-record-sets --hosted-zone-id Z07575063UROBJWYQYSPQ --change-batch '
    {
            "Comment": "Update a record ",
            "Changes": [{
            "Action": "UPSERT",
                        "ResourceRecordSet": {
                                    "Name": "'$i'.'$DOMAIN_NAME'",
                                    "Type": "A",
                                    "TTL": 1,
                                 "ResourceRecords": [{ "Value": "'$IP_ADDRESS'"}]
}}]
}
'

done