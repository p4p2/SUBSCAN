#!/usr/bin/env bash

##subdomain start

read -p "enter the domain:" DOMAIN

echo "finding subdomains for $DOMAIN"

if [[ -f "subdomains.txt" ]]; then 
    rm subdomains.txt 

    echo "previous file has deleted"
fi


subfinder -d "$DOMAIN" -o "subdomains.txt"

if [[ -f subdomain_status.txt ]]; then
    rm subdomain_status.txt
    echo "previous file hs deleted"
fi


echo "checking which subdomains are live...."


total_subdomains=$(wc -l < subdomains.txt)
counter=0

while read subdomain; do
    http_response=$(curl --max-time 5 --write-out "%{http_code}" --silent --output /dev/null "http://$subdomain")

if [[ $http_response -eq 200 ]]; then

    echo "$subdomain is live (http $http_response)" | tee -a subdomain_status.txt

elif [ $http_response -eq 301 ]; then

    echo "$subdomain is Moved Permanently (http $http_response)" | tee -a subdomain_status.txt


elif [ $http_response -eq 301 ]; then

    echo "$subdomain is Found (http $http_response)" | tee -a subdomain_status.txt


elif [ $http_response -eq 400 ]; then

    echo "$subdomain is Bad request (http $http_response)" | tee -a subdomain_status.txt


elif [ $http_response -eq 401 ]; then

    echo "$subdomain is unauthorized (http $http_response)" | tee -a subdomain_status.txt

elif [ $http_response -eq 403 ]; then

    echo "$subdomain is Forbidden (http $http_response)" | tee -a subdomain_status.txt

elif [ $http_response -eq 404 ]; then

    echo "$subdomain is Not Found (http $http_response)" | tee -a subdomain_status.txt

elif [ $http_response -eq 429 ]; then

    echo "$subdomain is too many request (http $http_response)" | tee -a subdomain_status.txt

else

    echo "$subdomain is not live (http $http_response)" | tee -a subdomain_status.txt

fi

 counter=$((counter + 1))
    echo -ne "Progress: [$counter/$total_subdomains] $((counter * 100 / total_subdomains))%\r"


done < subdomains.txt 

echo -e "\nDone!"