# Installation instructions

This usecase shows configuration using Docker.

## Assumptions
1. This repository is cloned and docker-config is workign directory. 
2. The Azure or AWS subscription is available
3. Docker, Docker-compose and Docker-machine is installed 

## Steps to be run via CLI 

### 1. Create docker-machine in cloud provider 
```shell
docker-machine create -d azure \
  --azure-ssh-user dockeruser \
  --azure-subscription-id <Your AZURE_SUBSCRIPTION_ID> \
  --azure-open-port 443 \
  identitybpa
```
### 2. Check the ip address of new docker-machine 
```shell
docker-machine ls
```
### 3. Point subdomain to ip addrress of new docker-machine
### 4. Bring up docker containers 
```shell
docker-compose -f .\docker-compose-identity.yml -f .\docker-compose-proxy.yml up
```
