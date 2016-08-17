
## LetsEncrypt SSL Certs on Nginx

This usecase shows auto congiruation of an nginx server with SSL certs. 

The demo SSL site is configured at - 
https://identitybpa1.skvared.com/

### High Level Steps
* Procure a basic Ubuntu/Debian VM. For our setup we used a micro instance from AWS
* Assign a public ip to the VM 
* Create a new A record for your domain mapping 'identitybpa' sub-domain to the public-ip
* SSH to the VM and copy all files from the current github folder
* Execute the following statement as root user passing in the sub-domain name and email id
``` 
./install.sh identitybpa.domain email_id@gmail.com 
```
* You should now be able to access https://identitybpa.domain.com
* Take a look at install.sh to see details

