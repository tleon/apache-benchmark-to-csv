#!/bin/bash
set -xe

ab_results=results
csv=results.csv
conf=bench.conf

if [ -f ${conf} ]; then
    readonly api_key=$(awk -F "api_key *= *" '{print $2}' "${conf}")
    readonly base_url=$(awk -F "base_url *= *" '{print $2}' "${conf}")
    readonly routes=$(awk -F "routes *= *" '{print $2}' "${conf}")
    readonly request_number=$(awk -F "request_number *= *" '{print $2}' "${conf}")
    readonly concurency_level=$(awk -F "concurency_level *= *" '{print $2}' "${conf}")
else
    echo "${conf} does not exist"
    exit
fi

if [ ! -f ${ab_results} ]; then
    touch $ab_results
fi

if [ ! -f ${csv} ]; then
    touch $csv
fi

url=(${routes})

rm results.csv;

for i in "${url[@]}";
do 
    echo $i;
    rm results;
    ab -n ${request_number} -c ${concurency_level} -H "Authorization: token ${api_key}" ${base_url}$i >> results;
    python3 process.py;
done;