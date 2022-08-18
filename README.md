# EA price sheets comparison

Overview: https://docs.microsoft.com/en-us/rest/api/consumption/

APIs:
- https://docs.microsoft.com/en-us/rest/api/consumption/price-sheet/get
- https://docs.microsoft.com/en-us/rest/api/consumption/price-sheet/get-by-billing-period

## Retail Price Sheet Query

- https://docs.microsoft.com/en-us/rest/api/cost-management/retail-prices/azure-retail-prices

Should be able to match on an ODATA filter, ex `$filter=meterId eq 'eaPriceSheetMeterId'`

# Example 1

## EA pricesheet entry

Filtered output:
```json
{
  "properties": {
    "pricesheets": [
      {
        "billingPeriodId": "/subscriptions/12345678-90ab-cdef-fedc-ba0987654321/providers/Microsoft.Billing/billingPeriods/20220301",
        "currencyCode": "USD",
        "includedQuantity": 0.0,
        "meterDetails": null,
        "meterId": "4e763e64-5ae4-5ed3-8892-902bb82ca7d3",
        "offerId": "MS-AZR-0017P",
        "partNumber": "AAF-53725",
        "unitOfMeasure": "100 Hours",
        "unitPrice": 46.0
      }
    ]
  }
}
```

The meterID corresponding to the Part number is `4e763e64-5ae4-5ed3-8892-902bb82ca7d3`

## Corresponding retail query

[https://prices.azure.com/api/retail/prices?$filter=meterId%20eq%20'4e763e64-5ae4-5ed3-8892-902bb82ca7d3'%20and%20priceType%20eq%20'Consumption'](https://prices.azure.com/api/retail/prices?$filter=meterId%20eq%20'4e763e64-5ae4-5ed3-8892-902bb82ca7d3'%20and%20priceType%20eq%20'Consumption')

Output:
```json
{
  "BillingCurrency": "USD",
  "CustomerEntityId": "Default",
  "CustomerEntityType": "Retail",
  "Items": [
    {
      "currencyCode": "USD",
      "tierMinimumUnits": 0.0,
      "reservationTerm": "1 Year",
      "retailPrice": 2377.0,
      "unitPrice": 2377.0,
      "armRegionName": "westeurope",
      "location": "EU West",
      "effectiveStartDate": "2020-08-01T00:00:00Z",
      "meterId": "4e763e64-5ae4-5ed3-8892-902bb82ca7d3",
      "meterName": "D8 v4",
      "productId": "DZH318Z0D1L4",
      "skuId": "DZH318Z0D1L4/01DC",
      "productName": "Virtual Machines Dv4 Series",
      "skuName": "D8 v4",
      "serviceName": "Virtual Machines",
      "serviceId": "DZH313Z7MMC8",
      "serviceFamily": "Compute",
      "unitOfMeasure": "1 Hour",
      "type": "Reservation",
      "isPrimaryMeterRegion": true,
      "armSkuName": "Standard_D8_v4"
    },
    {
      "currencyCode": "USD",
      "tierMinimumUnits": 0.0,
      "retailPrice": 0.46,
      "unitPrice": 0.46,
      "armRegionName": "westeurope",
      "location": "EU West",
      "effectiveStartDate": "2020-08-01T00:00:00Z",
      "meterId": "4e763e64-5ae4-5ed3-8892-902bb82ca7d3",
      "meterName": "D8 v4",
      "productId": "DZH318Z0D1L4",
      "skuId": "DZH318Z0D1L4/00J2",
      "productName": "Virtual Machines Dv4 Series",
      "skuName": "D8 v4",
      "serviceName": "Virtual Machines",
      "serviceId": "DZH313Z7MMC8",
      "serviceFamily": "Compute",
      "unitOfMeasure": "1 Hour",
      "type": "Consumption",
      "isPrimaryMeterRegion": true,
      "armSkuName": "Standard_D8_v4"
    },
    {
      "currencyCode": "USD",
      "tierMinimumUnits": 0.0,
      "reservationTerm": "3 Years",
      "retailPrice": 4594.0,
      "unitPrice": 4594.0,
      "armRegionName": "westeurope",
      "location": "EU West",
      "effectiveStartDate": "2020-08-01T00:00:00Z",
      "meterId": "4e763e64-5ae4-5ed3-8892-902bb82ca7d3",
      "meterName": "D8 v4",
      "productId": "DZH318Z0D1L4",
      "skuId": "DZH318Z0D1L4/01DF",
      "productName": "Virtual Machines Dv4 Series",
      "skuName": "D8 v4",
      "serviceName": "Virtual Machines",
      "serviceId": "DZH313Z7MMC8",
      "serviceFamily": "Compute",
      "unitOfMeasure": "1 Hour",
      "type": "Reservation",
      "isPrimaryMeterRegion": true,
      "armSkuName": "Standard_D8_v4"
    }
  ],
  "NextPageLink": null,
  "Count": 3
}
```

Note: the unit of measure between the two queries does not match. Keep this in mind when formulating comparisons of expected pricing.

# Example 2

## EA pricesheet entries

Searched for the following SKUs from an EA Price Sheet, collected the entire entry for each.
- AAA-48845, Az VM Ev3/ESv3 Series E16/E16s-10 Hrs-US E
- AAA-54044, Az VM Ev3/ESv3 Series E32/E32s-10 Hrs-US E

Filtered output:
```json
{
  "properties": {
    "pricesheets": [
      {
        "billingPeriodId": "/subscriptions/12345678-90ab-cdef-fedc-ba0987654321/providers/Microsoft.Billing/billingPeriods/20220301",
        "currencyCode": "USD",
        "includedQuantity": 0.0,
        "meterDetails": null,
        "meterId": "82a17126-c674-4838-bfd8-b180068ab695",
        "offerId": "MS-AZR-0017P",
        "partNumber": "AAA-54044",
        "unitOfMeasure": "10 Hours",
        "unitPrice": 20.16
      },
      {
        "billingPeriodId": "/subscriptions/12345678-90ab-cdef-fedc-ba0987654321/providers/Microsoft.Billing/billingPeriods/20220301",
        "currencyCode": "USD",
        "includedQuantity": 0.0,
        "meterDetails": null,
        "meterId": "71e1db1c-32f2-4a36-98b3-79682ea69ace",
        "offerId": "MS-AZR-0017P",
        "partNumber": "AAA-48845",
        "unitOfMeasure": "10 Hours",
        "unitPrice": 10.08
      }
    ]
  }
}
```

## Corresponding retail query

[https://prices.azure.com/api/retail/prices?$filter=(meterId%20eq%20'82a17126-c674-4838-bfd8-b180068ab695'%20or%20meterId%20eq%20'71e1db1c-32f2-4a36-98b3-79682ea69ace')%20and%20priceType%20eq%20'Consumption'](https://prices.azure.com/api/retail/prices?$filter=(meterId%20eq%20'82a17126-c674-4838-bfd8-b180068ab695'%20or%20meterId%20eq%20'71e1db1c-32f2-4a36-98b3-79682ea69ace')%20and%20priceType%20eq%20'Consumption')

Output:
```json
{
  "BillingCurrency": "USD",
  "CustomerEntityId": "Default",
  "CustomerEntityType": "Retail",
  "Items": [
    {
      "currencyCode": "USD",
      "tierMinimumUnits": 0.0,
      "retailPrice": 1.008,
      "unitPrice": 1.008,
      "armRegionName": "eastus",
      "location": "US East",
      "effectiveStartDate": "2019-01-01T00:00:00Z",
      "meterId": "71e1db1c-32f2-4a36-98b3-79682ea69ace",
      "meterName": "E16 v3/E16s v3",
      "productId": "DZH318Z0BQ4L",
      "skuId": "DZH318Z0BQ4L/00H8",
      "productName": "Virtual Machines Ev3 Series",
      "skuName": "E16 v3",
      "serviceName": "Virtual Machines",
      "serviceId": "DZH313Z7MMC8",
      "serviceFamily": "Compute",
      "unitOfMeasure": "1 Hour",
      "type": "Consumption",
      "isPrimaryMeterRegion": true,
      "armSkuName": "Standard_E16_v3"
    },
    {
      "currencyCode": "USD",
      "tierMinimumUnits": 0.0,
      "retailPrice": 1.008,
      "unitPrice": 1.008,
      "armRegionName": "eastus",
      "location": "US East",
      "effectiveStartDate": "2019-01-01T00:00:00Z",
      "meterId": "71e1db1c-32f2-4a36-98b3-79682ea69ace",
      "meterName": "E16-4s v3",
      "productId": "DZH318Z0BQ4R",
      "skuId": "DZH318Z0BQ4R/029D",
      "productName": "Virtual Machines ESv3 Series",
      "skuName": "E16-4s v3",
      "serviceName": "Virtual Machines",
      "serviceId": "DZH313Z7MMC8",
      "serviceFamily": "Compute",
      "unitOfMeasure": "1 Hour",
      "type": "Consumption",
      "isPrimaryMeterRegion": false,
      "armSkuName": "Standard_E16-4s_v3"
    },
    {
      "currencyCode": "USD",
      "tierMinimumUnits": 0.0,
      "retailPrice": 1.008,
      "unitPrice": 1.008,
      "armRegionName": "eastus",
      "location": "US East",
      "effectiveStartDate": "2019-01-01T00:00:00Z",
      "meterId": "71e1db1c-32f2-4a36-98b3-79682ea69ace",
      "meterName": "E16-8s v3",
      "productId": "DZH318Z0BQ4R",
      "skuId": "DZH318Z0BQ4R/01MC",
      "productName": "Virtual Machines ESv3 Series",
      "skuName": "E16-8s v3",
      "serviceName": "Virtual Machines",
      "serviceId": "DZH313Z7MMC8",
      "serviceFamily": "Compute",
      "unitOfMeasure": "1 Hour",
      "type": "Consumption",
      "isPrimaryMeterRegion": false,
      "armSkuName": "Standard_E16-8s_v3"
    },
    {
      "currencyCode": "USD",
      "tierMinimumUnits": 0.0,
      "retailPrice": 1.008,
      "unitPrice": 1.008,
      "armRegionName": "eastus",
      "location": "US East",
      "effectiveStartDate": "2019-01-01T00:00:00Z",
      "meterId": "71e1db1c-32f2-4a36-98b3-79682ea69ace",
      "meterName": "E16s v3",
      "productId": "DZH318Z0BQ4R",
      "skuId": "DZH318Z0BQ4R/00GG",
      "productName": "Virtual Machines ESv3 Series",
      "skuName": "E16s v3",
      "serviceName": "Virtual Machines",
      "serviceId": "DZH313Z7MMC8",
      "serviceFamily": "Compute",
      "unitOfMeasure": "1 Hour",
      "type": "Consumption",
      "isPrimaryMeterRegion": false,
      "armSkuName": "Standard_E16s_v3"
    },
    {
      "currencyCode": "USD",
      "tierMinimumUnits": 0.0,
      "retailPrice": 2.016,
      "unitPrice": 2.016,
      "armRegionName": "eastus",
      "location": "US East",
      "effectiveStartDate": "2019-01-01T00:00:00Z",
      "meterId": "82a17126-c674-4838-bfd8-b180068ab695",
      "meterName": "E32 v3/E32s v3",
      "productId": "DZH318Z0BQ4L",
      "skuId": "DZH318Z0BQ4L/00JV",
      "productName": "Virtual Machines Ev3 Series",
      "skuName": "E32 v3",
      "serviceName": "Virtual Machines",
      "serviceId": "DZH313Z7MMC8",
      "serviceFamily": "Compute",
      "unitOfMeasure": "1 Hour",
      "type": "Consumption",
      "isPrimaryMeterRegion": true,
      "armSkuName": "Standard_E32_v3"
    },
    {
      "currencyCode": "USD",
      "tierMinimumUnits": 0.0,
      "retailPrice": 2.016,
      "unitPrice": 2.016,
      "armRegionName": "eastus",
      "location": "US East",
      "effectiveStartDate": "2019-01-01T00:00:00Z",
      "meterId": "82a17126-c674-4838-bfd8-b180068ab695",
      "meterName": "E32s v3",
      "productId": "DZH318Z0BQ4R",
      "skuId": "DZH318Z0BQ4R/00M9",
      "productName": "Virtual Machines ESv3 Series",
      "skuName": "E32s v3",
      "serviceName": "Virtual Machines",
      "serviceId": "DZH313Z7MMC8",
      "serviceFamily": "Compute",
      "unitOfMeasure": "1 Hour",
      "type": "Consumption",
      "isPrimaryMeterRegion": false,
      "armSkuName": "Standard_E32s_v3"
    },
    {
      "currencyCode": "USD",
      "tierMinimumUnits": 0.0,
      "retailPrice": 2.016,
      "unitPrice": 2.016,
      "armRegionName": "eastus",
      "location": "US East",
      "effectiveStartDate": "2019-01-01T00:00:00Z",
      "meterId": "82a17126-c674-4838-bfd8-b180068ab695",
      "meterName": "E32-16s v3",
      "productId": "DZH318Z0BQ4R",
      "skuId": "DZH318Z0BQ4R/01GG",
      "productName": "Virtual Machines ESv3 Series",
      "skuName": "E32-16s v3",
      "serviceName": "Virtual Machines",
      "serviceId": "DZH313Z7MMC8",
      "serviceFamily": "Compute",
      "unitOfMeasure": "1 Hour",
      "type": "Consumption",
      "isPrimaryMeterRegion": false,
      "armSkuName": "Standard_E32-16s_v3"
    },
    {
      "currencyCode": "USD",
      "tierMinimumUnits": 0.0,
      "retailPrice": 2.016,
      "unitPrice": 2.016,
      "armRegionName": "eastus",
      "location": "US East",
      "effectiveStartDate": "2019-01-01T00:00:00Z",
      "meterId": "82a17126-c674-4838-bfd8-b180068ab695",
      "meterName": "E32-8s v3",
      "productId": "DZH318Z0BQ4R",
      "skuId": "DZH318Z0BQ4R/025R",
      "productName": "Virtual Machines ESv3 Series",
      "skuName": "E32-8s v3",
      "serviceName": "Virtual Machines",
      "serviceId": "DZH313Z7MMC8",
      "serviceFamily": "Compute",
      "unitOfMeasure": "1 Hour",
      "type": "Consumption",
      "isPrimaryMeterRegion": false,
      "armSkuName": "Standard_E32-8s_v3"
    }
  ],
  "NextPageLink": null,
  "Count": 8
}
```
