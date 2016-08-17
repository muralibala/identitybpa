domain_name=$1
email_id=$2
echo $domain_name
echo "installing nginx"
apt-get --assume-yes install nginx
echo "installing git"
apt-get --assume-yes install git bc
git clone https://github.com/letsencrypt/letsencrypt /opt/letsencrypt
echo "Replacing domain name "
sed -i 's/domain_name/'"$domain_name"'/g' domain-http.conf
sed -i 's/domain_name/'"$domain_name"'/g' domain-https.conf
mkdir /etc/nginx/cert
echo "******* Generating DH Params File *******"
openssl dhparam 2048 -out /etc/nginx/cert/dhparam.pem
echo "***** Copying domain configuration files *******"
cp domain-http.conf /etc/nginx/conf.d/
echo "***** Starting NGINX for first time ******"
service nginx start
echo "***** Creating Directory ******"
mkdir -p /var/www/$domain_name.com
cp html/index.html /var/www/$domain_name.com/
echo "***** Validating and Obtaining Certs ******"
/opt/letsencrypt/letsencrypt-auto certonly --agree-tos --quiet --agree-tos --webroot -m $email_id -w /var/www/$domain_name.com -d $domain_name.com
cp domain-https.conf /etc/nginx/conf.d/
echo "***** Restarting Nginx ******"
service nginx restart