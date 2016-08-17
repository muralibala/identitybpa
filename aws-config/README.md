## Assumptions
1. Certificate for your domain has been requested via AWS certificate Manager 
2. You have created a Security group for your load balancer with Inbound rule that allows any source to connect to the ELB via port 443
3. You have created a subnet for each AZ where you wish traffic to be routed by Load balancer to your EC2 instance.
4. You have provisioned an Ec2 instance with any web server running (IIS/Apache etc)

## Steps to be run via CLI 
(Note : Replace subnets / Security group details / Load balancer name/ Custom cipher policy name with your custom details)

### 1. you can run the following Commands from an EC2 instance that has an EC2 role to create an ELB 
```shell
aws elb create-load-balancer --load-balancer-name my-load-balancer --listeners "Protocol=HTTPS,LoadBalancerPort=443,InstanceProtocol=HTTPS,InstancePort=443,SSLCertificateId=arn:aws:acm:us-east-1:761805658877:certificate/24649197-5a95-4f73-a2d5-9806aeec5e6c" --subnets subnet-5348736e subnet-7ac4e350 subnet-e93a2d9f subnet-e9bb9ab1 --security-groups sg-c2d588b9
```
### 2. Now create a new cipher security policy that will be tied with the ELB
```shell
aws elb create-load-balancer-policy \
--load-balancer-name my-load-balancer \
--policy-name MySecurityPolicy-2016-08 \
--policy-type-name SSLNegotiationPolicyType \
--region us-east-1 \
--policy-attributes \
AttributeName=Protocol-TLSv1,AttributeValue=true \
AttributeName=Protocol-TLSv1.1,AttributeValue=true \
AttributeName=Protocol-TLSv1.2,AttributeValue=true \
AttributeName=Server-Defined-Cipher-Order,AttributeValue=true \
AttributeName=ECDHE-ECDSA-AES128-GCM-SHA256,AttributeValue=true \
AttributeName=ECDHE-RSA-AES128-GCM-SHA256,AttributeValue=true \
AttributeName=ECDHE-ECDSA-AES128-SHA256,AttributeValue=true \
AttributeName=ECDHE-RSA-AES128-SHA256,AttributeValue=true \
AttributeName=ECDHE-ECDSA-AES128-SHA,AttributeValue=true \
AttributeName=ECDHE-RSA-AES128-SHA,AttributeValue=true \
AttributeName=ECDHE-ECDSA-AES256-GCM-SHA384,AttributeValue=true \
AttributeName=ECDHE-RSA-AES256-GCM-SHA384,AttributeValue=true \
AttributeName=ECDHE-ECDSA-AES256-SHA384,AttributeValue=true \
AttributeName=ECDHE-RSA-AES256-SHA384,AttributeValue=true \
AttributeName=ECDHE-RSA-AES256-SHA,AttributeValue=true \
AttributeName=ECDHE-ECDSA-AES256-SHA,AttributeValue=true \
AttributeName=AES128-GCM-SHA256,AttributeValue=true \
AttributeName=AES128-SHA256,AttributeValue=true \
AttributeName=AES128-SHA,AttributeValue=true \
AttributeName=AES256-GCM-SHA384,AttributeValue=true \
AttributeName=AES256-SHA256,AttributeValue=true \
AttributeName=AES256-SHA,AttributeValue=true \
AttributeName=DES-CBC3-SHA,AttributeValue=true
```
### 3. Attach the custom cipher policy to your ELB
```shell
aws elb set-load-balancer-policies-of-listener --load-balancer-name my-load-balancer --load-balancer-port 443 --policy-name MySecurityPolicy-2016-08 --region us-east-1
```
