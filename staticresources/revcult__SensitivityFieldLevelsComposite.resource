{
  "compositeResponse": [
    {
      "body": {
        "totalSize": 3,
        "done": true,
        "records": [
          {
            "attributes": {
              "type": "revcult__Data_Classification_Field_Level__c",
              "url": "/services/data/v52.0/sobjects/revcult__Data_Classification_Field_Level__c/a040U000002ppVhQAI"
            },
            "Id": "a040U000002ppVhQAI",
            "revcult__Encrypted__c": false,
            "revcult__Exposure__c": null,
            "revcult__Field_Durable_Id__c": "Contact.Name",
            "revcult__Tracked__c": false,
            "revcult__Compliance_Categorization__c": null
          },
          {
            "attributes": {
              "type": "revcult__Data_Classification_Field_Level__c",
              "url": "/services/data/v52.0/sobjects/revcult__Data_Classification_Field_Level__c/a040U000002ppVgQAI"
            },
            "Id": "a040U000002ppVgQAI",
            "revcult__Encrypted__c": false,
            "revcult__Exposure__c": null,
            "revcult__Field_Durable_Id__c": "Account.Name",
            "revcult__Tracked__c": false,
            "revcult__Compliance_Categorization__c": null
          },
          {
            "attributes": {
              "type": "revcult__Data_Classification_Field_Level__c",
              "url": "/services/data/v52.0/sobjects/revcult__Data_Classification_Field_Level__c/a040U000002ppVfQAI"
            },
            "Id": "a040U000002ppVfQAI",
            "revcult__Encrypted__c": false,
            "revcult__Exposure__c": null,
            "revcult__Field_Durable_Id__c": "Lonely.Land",
            "revcult__Tracked__c": false,
            "revcult__Compliance_Categorization__c": "PII;"
          },
          {
            "attributes": {
              "type": "revcult__Data_Classification_Field_Level__c",
              "url": "/services/data/v52.0/sobjects/revcult__Data_Classification_Field_Level__c/a040U000002ppVfQAI"
            },
            "Id": "a040U000002ppVfQAI",
            "revcult__Encrypted__c": false,
            "revcult__Exposure__c": null,
            "revcult__Field_Durable_Id__c": "Good.Grief",
            "revcult__Tracked__c": false,
            "revcult__Compliance_Categorization__c": "Fucky;"
          }
        ]
      },
      "httpHeaders": {},
      "httpStatusCode": 200,
      "referenceId": "req1"
    },
    {
      "body": [
        {
          "errorCode": "PROCESSING_HALTED",
          "message": "Invalid reference specified. No value for req1.nextRecordsUrl found in req1. Provided referenceId ('req1.nextRecordsUrl') must start with a letter or a number, and it can contain only letters, numbers and underscores ('_')."
        }
      ],
      "httpHeaders": {},
      "httpStatusCode": 400,
      "referenceId": "req2"
    },
    {
      "body": [
        {
          "errorCode": "PROCESSING_HALTED",
          "message": "Execution halted as previous operation (req2) was not successful."
        }
      ],
      "httpHeaders": {},
      "httpStatusCode": 400,
      "referenceId": "req3"
    },
    {
      "body": [
        {
          "errorCode": "PROCESSING_HALTED",
          "message": "Execution halted as previous operation (req3) was not successful."
        }
      ],
      "httpHeaders": {},
      "httpStatusCode": 400,
      "referenceId": "req4"
    },
    {
      "body": [
        {
          "errorCode": "PROCESSING_HALTED",
          "message": "Execution halted as previous operation (req4) was not successful."
        }
      ],
      "httpHeaders": {},
      "httpStatusCode": 400,
      "referenceId": "req5"
    }
  ]
}