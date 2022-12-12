#!/bin/bash

if [ -z "$1" -o -z "$2" ]; then
	echo -e "This command takes a Subscription ID (in GUID format) and a billing period (in YYYYmm format) and retrieves"
    echo -e "the price sheets associated with that subscription, for that billing period."
    echo -e ""
    echo -e "usage: $0 subscription-guid billing-period optional-output-file-name-prefix"
	echo -e "example: $0 12345678-90ab-cdef-fedc-ba0987654321 202203 mysheet"
    echo -e ""
    echo -e "Prerequisites: "
    echo -e " * latest Azure CLI is installed"
    echo -e " * you are signed in with 'az login' first"
    echo -e " * subscription offer type must be 0017P (Azure Enterprise Subscription) or 0148P (Enterprise Dev/Test)"
    echo -e ""
    echo -e "Price sheets are downloaded in chunks from the Microsoft.Consumption APIs, and saved in numbered JSON files."
    echo -e "The file name format is: prefix_subscription-id_billing-period_####.json"
    echo -e "The default prefix is 'pricesheet' but you can specify one as an optional argument."
    echo -e ""
else
	i=0
    printf -v index "%04d" $i
    nextRestCall="https://management.azure.com/subscriptions/$1/providers/Microsoft.Billing/billingPeriods/$2/providers/Microsoft.Consumption/pricesheets/default?api-version=2021-10-01"

    prefix=pricesheet
    if [ ! -z "$3" ]; then
        prefix=$3
    fi
    outFile=${prefix}_${1}_${2}_${index}.json

	echo -e "Getting price sheet $outFile..."
    az rest --method get --uri "$nextRestCall" > $outFile
    
	nextRestCall=$( cat $outFile | jq -r '.properties.nextLink' )
    
    while [ ! -z "$nextRestCall" ]; do
    	((i++))
        printf -v index "%04d" $i
        outFile=${prefix}_${1}_${2}_${index}.json
        echo -e "Getting price sheet $outFile..."
    	az rest --method get --uri "$nextRestCall" > $outFile
    	nextRestCall=$( cat $outFile | jq -r '.properties.nextLink' )
    done
fi
