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

    echo "$subdomain is live" | tee -a subdomain_status.txt
elif []

    echo "$subdomain is not live (http $http_response)" | tee -a subdomain_status.txt

fi

 counter=$((counter + 1))
    echo -ne "Progress: [$counter/$total_subdomains] $((counter * 100 / total_subdomains))%\r"


done < subdomains.txt 

echo -e "\nDone!"