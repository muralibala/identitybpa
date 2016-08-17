# Secure website configuration in support of Identity Management response

We have provided three alternate ways to create a site that gets A or A+ certificate on SSL Labs. 

## 1. Using Docker containers 
 We have used a Nginx docker container as a proxy for web sites. The Nginx proxy container is paired with a Let's Encrypt proxy companion. Together, both of these containers create secure proxy for websites behind the proxy. The website can be implemented in any techology as long as VIRTUAL_HOST and LETSENCRYPT_HOST environment variables are set. The proxy container automatically creates/renews Let's Encrypt certificates. This companion container also automatically creates strong Diffie-Hellman Group. 
 
This functioning implementation, hosted in Azure, is available at [identitybpa.agileana.com](https://identitybpa.agileana.com). This implementation gets [A+ rating](https://www.ssllabs.com/ssltest/analyze.html?d=identitybpa.agileana.com) from SSL Labs. 

The source for implementation using docker containers is available in docker-config folder. The [README](./docker-config/README.md) contains additional information. 

## 2. Using Ngnix config 
  We have configured an EC2 instance with Nginx to automatically create/renew Let's Encrypt Certificates. This functioning implementation, hosted in AWS, is available at [https://identitybpa1.skvared.com/](https://identitybpa1.skvared.com). This implementation gets [A+ rating](https://www.ssllabs.com/ssltest/analyze.html?d=identitybpa1.skvared.com) from SSL Labs. 
  
  The source for direct Ngnix configuration is available in ngnix-config folder. The [README](./nginx-config/README.md) contains additional information.

## 3. Using AWS Certificate Management services
  We have configured an AWS Elastic load balancer to use a certificate provisioned from 'AWS Certificate Manager' and applied a custom security policy. This functioning implementation, hosted in AWS, is available at [https://identitybpa2.skvared.com/](https://identitybpa2.skvared.com). This implementation gets [A rating](https://www.ssllabs.com/ssltest/analyze.html?d=identitybpa2.skvared.com) from SSL Labs. 
  
  See [README](./aws-config) for additional information.
