#!/usr/bin/env bash
public_ip=$(terraform output -json -state=./terraform.tfstate | jq -r .public_ip.value)
echo $public_ip
mkdir -p ./dags
sudo mount -t nfs -o vers=4 -o tcp -w ${public_ip}:/ ./dags
sudo chown 1000:1000 ./dags