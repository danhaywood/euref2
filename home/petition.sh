#!/bin/bash
#set -x
#trap read debug
set -o nounset
set -o errexit


# uses 'jq' to parse JSON
# - on Linux: apt install jq
# - on Mac: brew install jq
# - on Windows: download exe from http://stedolan.github.io/jq/download/
#


petition_url="https://petition.parliament.uk/petitions/131215.json"

while [ 1 ]
do

        petition_json=$(curl -s "$petition_url")
        if [ $? -eq 0 ]; then
                signature_count=$(echo $petition_json | jq --raw-output '.data .attributes .signature_count')
                time_now=$(date --iso-8601=seconds)

                echo "$time_now,$signature_count" >> /var/www/html/petition.csv
        fi

        sleep 300
done
