#!/bin/bash

if [[ $(echo $@ | grep -F -e '-h' -e '--help') ]]; then
    echo -e "This command retrieves the currently available azure retail price sheets at the time of execution."
    echo -e ""
    echo -e "usage: $0 optional-output-file-name-prefix"
    echo -e "example: $0 mysheet"
    echo -e ""
    echo -e "Price sheets are downloaded in chunks from the public retail price API, and saved in numbered JSON files."
    echo -e "The file name format is: prefix_timestamp_####.json"
    echo -e "The default prefix is 'retailpricesheet' but you can specify one as an optional argument."
    echo -e "Timestamp is represented in yyyymmddHHMMSSz format (for example, $(date +"%Y%m%d%H%M%S%z"))"
    echo -e ""
else
    i=0
    printf -v index "%04d" $i
    nextRestCall="https://prices.azure.com/api/retail/prices?api-version=2021-10-01-preview"
    
    prefix=retailpricesheet
    timestamp=$(date +"%Y%m%d%H%M%S%z")
    if [ ! -z "$1" ]; then
        prefix=$1
    fi
    outFile=${prefix}_${timestamp}_${index}.json
    
    while [ ! -z "$nextRestCall" ]; do
        # Retrieve pricesheet records
        echo -e "Getting price sheet $outFile..."
        curl --no-progress-meter --get "$nextRestCall" | jq > $outFile
        
        ## Prepare for next API call
        nextRestCall=$( cat $outFile | jq -r '.NextPageLink // ""' )
        ((i++))
        printf -v index "%04d" $i
        outFile=${prefix}_${timestamp}_${index}.json
    done
fi
