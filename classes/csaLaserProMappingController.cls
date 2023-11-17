global with sharing class csaLaserProMappingController implements LLCLP.FormatManager.ICustomFormatter {
  public Map<String, String> fieldLabelTranslationMap = new Map<String, String>();

  global String format(Id loanId, String extract) {
    List<CSA_LaserPro_Field_Mappings__mdt> mappingsToAddandRemove;

    String excludeValue = Test.isRunningTest()
      ? nCSA_FRAME.csaConstants.BLANK
      : DO_NOT_DELETE;

    mappingsToAddandRemove = getLaserProMappingList(excludeValue);

    //Remove Labels that are going to be overridden, or configured to be removed from extract
    for (CSA_LaserPro_Field_Mappings__mdt removal : mappingsToAddandRemove) {
      //01-20-21:nCino added If condition to validate Removal Data Label exists in the Extract
      if (
        extract.indexOf(removal.LaserPro_Extract_Data_Label__c) > -1 &&
        removal.Remove_Value_from_Extract__c
      ) {
        System.debug('Removing ' + removal.LaserPro_Extract_Data_Label__c);
        extract = removeDataLabel(
          extract,
          removal.LaserPro_Extract_Data_Label__c
        );
      }
    }

    //Hold list of fields to be used per Object in order to only queyr records once per object
    //defined in the custom metadata
    Map<String, List<String>> fieldByObjectMap = new Map<String, List<String>>();

    //Hold list of fields and how they coorelate to the desired data label to be
    //displayed in the LPL Extract
    Map<String, String> fieldsByDataLabelMap = new Map<String, String>();

    //Determines if a data label should only apply to certain records
    //this allows us to not have to run an additional SOQL query
    Map<String, List<String>> filterRulesbyObject = new Map<String, List<String>>();

    //Stores the field/translation pairing

    for (CSA_LaserPro_Field_Mappings__mdt mapping : mappingsToAddandRemove) {
      if (
        mapping.Field_API_Name__c != null &&
        mapping.LaserPro_Extract_Data_Label__c != null &&
        mapping.Pertains_to_Object_API__c != null
      ) {
        //Remove Existing Data Label from Extract so it doesn't appear twice
        if (extract.indexOf(mapping.LaserPro_Extract_Data_Label__c) > -1) {
          //01-20-21:nCino removed concatenation of the output extracts
          //extract += removeDataLabel(extract, mapping.LaserPro_Extract_Data_Label__c);
          extract = removeDataLabel(
            extract,
            mapping.LaserPro_Extract_Data_Label__c
          );
        }

        //List of fields to use in SOQL query
        List<String> fieldList;

        //List of Key=Value pair for records configured with filterable data labels
        List<String> filterCriteriaFields = new List<String>();

        if (!fieldByObjectMap.containsKey(mapping.Pertains_to_Object_API__c)) {
          fieldList = new List<String>();
        } else {
          fieldList = fieldByObjectMap.get(mapping.Pertains_to_Object_API__c);
        }

        if (mapping.Field_Value_Translation__c != null) {
          fieldLabelTranslationMap.put(
            mapping.LaserPro_Extract_Data_Label__c,
            mapping.Field_Value_Translation__c
          );
        }
        if (mapping.Filter_Criteria__c != null) {
          String fieldToAdd = mapping.Filter_Criteria__c.split('\\=')[0];
          String valueToFilter = mapping.Filter_Criteria__c.split('\\=')[1];

          if (!fieldList.contains(fieldToAdd)) {
            fieldList.add(fieldToAdd);
          }

          //Add field to main SOQL Query as well
          filterCriteriaFields.add(mapping.Filter_Criteria__c);

          filterRulesbyObject.put(
            mapping.Pertains_to_Object_API__c,
            filterCriteriaFields
          );
        }

        //Dynamically build field for data that's not from the primary object
        if (mapping.Data_Resides_on_Account_Object__c) {
          String relatedField =
            mapping.Relationship_to_Account__c +
            SFDC_RELATED_OBJECT_SEPERATOR +
            mapping.Field_API_Name__c;

          if (!fieldList.contains(relatedField)) {
            fieldList.add(relatedField);
            //Add the Field and which LPL Field it maps to
            fieldsByDataLabelMap.put(
              relatedField,
              mapping.LaserPro_Extract_Data_Label__c
            );
          }
        } else {
          if (!fieldList.contains(mapping.Field_API_Name__c)) {
            fieldList.add(mapping.Field_API_Name__c);
            fieldsByDataLabelMap.put(
              mapping.Field_API_Name__c,
              mapping.LaserPro_Extract_Data_Label__c
            );
          }
        }

        fieldByObjectMap.put(mapping.Pertains_to_Object_API__c, fieldList);
      }
    }

    for (String ruleByObject : fieldByObjectMap.keySet()) {
      String pertainsTo = ruleByObject;
      List<String> fields = fieldByObjectMap.get(ruleByObject);
      String fieldsJoined = String.join(fields, SOQL_FIELD_SEPERATOR);

      String sortOrder;

      //LPL Extract does not have any order clauses except for Fees
      if (pertainsTo == FEE_OBJECT_API_NAME) {
        sortOrder = FEE_OBJECT_SORT_ORDER;
      }
      if (pertainsTo != LOAN_OBJECT_API_NAME) {
        fieldsJoined += ', LLC_BI__Loan__c';
      }
      String queryStr =
        SOQL_SELECT_WITH_SPACE +
        String.escapeSingleQuotes(fieldsJoined) +
        SOQL_FROM_WITH_PADDING +
        pertainsTo +
        WHERE_WITH_PADDING;

      if (pertainsTo != LOAN_OBJECT_API_NAME) {
        queryStr += LOAN_OBJECT_API_NAME + EQUALS_WITH_PADDING;
      } else {
        queryStr += SOQL_RECORD_ID + EQUALS_WITH_PADDING;
      }

      queryStr += LOANIDVAR;

      if (sortOrder != null) {
        queryStr += ORDER_BY_WITH_PADDING + sortOrder;
      }
      system.debug(queryStr);
      List<sObject> results = Database.query(queryStr);
      Id oldId;
      Id currentId;
      Integer recordCount = 0; //used if data mapping is a collection
      for (sObject a : results) {
        System.debug('Record');
        System.debug(a);
        //System.debug(a.getSObject('LLC_BI__Collateral__r').getSObject('LLC_BI__Collateral_Type__r').get('cm_LaserPro_Type__c'));
		 
        if (pertainsTo != LOAN_OBJECT_API_NAME) {
          currentId = (Id) a.get('LLC_BI__Loan__c');
        } else {
          currentId = (Id) a.get('Id');
        }
        if (oldId == null) {
          oldId = currentId;
        }

        recordCount += 1;
        for (String dataLabels : fieldByObjectMap.get(pertainsTo)) {
          String lplLabel = fieldsByDataLabelMap.get(dataLabels);
          System.debug('looping for ' + lplLabel);
          //if data is pulled from a related object
          if (dataLabels.indexOf(SFDC_RELATED_OBJECT_SEPERATOR) > -1) {
            String relationshipName = dataLabels.split('\\.')[0];
            String apiField = dataLabels.split('\\.')[1];
            String childRelationship;
            if (dataLabels.split('\\.').size() == 3) {
            	childRelationship =  dataLabels.split('\\.')[1];
                apiField =  dataLabels.split('\\.')[2];
            }
			System.debug('Relationship Lookup Name: ' + relationshipName);
			System.debug('childRelationship Lookup Name: ' + childRelationship);
			System.debug('apiField  Name: ' + apiField);

            Object fieldValue;
            if (dataLabels.split('\\.').size() == 2) {
            	fieldValue = a.getSObject(relationshipName).get(apiField);
            } else {
                fieldValue = a.getSObject(relationshipName).getSObject(childRelationship).get(apiField);
            }

            String dataPoint = String.valueOf(fieldValue);
            extract += updateExtract(lplLabel, recordCount, dataPoint);

            /*
                        if (pertainsTo != LOAN_OBJECT_API_NAME) {
                            currentId = (Id) a.get('LLC_BI__Loan__c');
                        } else {
                            currentId = (Id) a.get('Id');
                        }
                        System.debug('Current ID: ' + currentId);
                        System.debug('Old ID: ' + oldId);
                        System.debug('Record Count: ' + recordCount);

                        if (currentId != oldId) {
                            System.debug('Increasting Current Count ' + recordCount);
                            recordCount +=1;
                        }
                        if (pertainsTo != LOAN_OBJECT_API_NAME) {
                            oldId = (Id) a.get('LLC_BI__Loan__c');
                        } else {
                            oldId = (Id) a.get('Id');
                        }
                        */
          } else {
            Object fieldValue = a.get(dataLabels);
            String dataPoint = String.valueOf(fieldValue);

            //If the data label only applies to certain records
            if (filterRulesbyObject.containsKey(pertainsTo)) {
              for (String item : filterRulesbyObject.get(pertainsTo)) {
                String filterField = item.split('\\=')[0];
                String filterValue = item.split('\\=')[1];

                //Check the actual value of the record based on the value to filter on
                if (
                  String.valueOf(a.get(filterField)) == filterValue &&
                  lplLabel != null
                ) {
                  extract += updateExtract(lplLabel, recordCount, dataPoint);
                }
              }
            } else {
              extract += updateExtract(lplLabel, recordCount, dataPoint);
            }
          }
        }
      }
    }

    return extract;
  }

  private String translateValue(
    String recordValue,
    String translationKeyValuePair
  ) {
    System.debug('checking split for ' + recordValue);
    for (String translatedValue : translationKeyValuePair.split('\n')) {
      String key = translatedValue.split('\\=')[0];
      String value = translatedValue.split('\\=')[1];
      System.debug(translatedValue);
      if (recordValue == key) {
        return value;
      }
    }
    return recordValue;
  }
  private String updateExtract(
    String dataLabel,
    Integer recordCount,
    String recordValue
  ) {
    //Replace LPL placeholder counter of x_ or y_ data labels with record count

    try {
      recordValue = String.valueOf(
        DateTime.valueOf(recordValue).format('MM-dd-YYYY')
      );
    } catch (Exception ex) {
    }

    if (recordValue == 'true') {
      recordValue = 'Y';
    } else if (recordValue == 'false') {
      recordValue = 'N';
    }
    System.debug('Checking if tranlation applies for ' + dataLabel);
    System.debug(fieldLabelTranslationMap.get(dataLabel));
    if (
      recordValue != null && fieldLabelTranslationMap.containsKey(dataLabel)
    ) {
      recordValue = translateValue(
        recordValue,
        fieldLabelTranslationMap.get(dataLabel)
      );
    }
    if (
      dataLabel.indexOf(csaLaserProMappingConstants.LASERPRO_ENTITY_DIVIDER) >
      -1 &&
      dataLabel.indexOf('x') > -1
    ) {
      Integer dataLabelCounter = dataLabel.indexOf(
        csaLaserProMappingConstants.LASERPRO_ENTITY_DIVIDER
      );
      Integer dataLabelCounterPrevCharPos = dataLabelCounter - 1;
      String labelStart = dataLabel.substring(0, dataLabelCounterPrevCharPos);
      System.debug('Label dataLabelCounter ' + dataLabelCounter);
      String labelEnd = datalabel.substring(
        dataLabelCounter + 1,
        dataLabel.length()
      );
      if (recordValue != null) {
        return labelStart +
          recordCount +
          csaLaserProMappingConstants.LASERPRO_ENTITY_DIVIDER +
          labelEnd +
          csaLaserProMappingConstants.LASERPRO_DATA_DIVIDER +
          recordValue +
          csaLaserProMappingConstants.LASERPRO_LINEBREAK;
      } else {
        return '';
      }
    }

    if (recordValue != null) {
      return dataLabel +
        csaLaserProMappingConstants.LASERPRO_DATA_DIVIDER +
        recordValue +
        csaLaserProMappingConstants.LASERPRO_LINEBREAK;
    } else {
      return '';
    }
  }

  global Type forName(String className) {
    return Type.forName(className);
  }

  private String removeDataLabel(String extract, String property) {
    String labelEnd = property;
    if (
      property.indexOf(csaLaserProMappingConstants.LASERPRO_ENTITY_DIVIDER) > -1
    ) {
      Integer dataLabelCounter = property.indexOf(
        csaLaserProMappingConstants.LASERPRO_ENTITY_DIVIDER
      );
      Integer dataLabelCounterPrevCharPos = dataLabelCounter - 1;
      String labelStart = property.substring(0, dataLabelCounterPrevCharPos);
      labelEnd = property.substring(dataLabelCounter + 1, property.length());
    }

    Pattern p = Pattern.compile(
      REGEX_WILDCARD +
      labelEnd +
      REGEX_WILDCARD +
      REGEX_LINE_BREAK_PATTERN
    );
    Matcher pm = p.matcher(extract);
    try {
      extract = pm.replaceAll(csaLaserProMappingConstants.LASERPRO_BLANK_DATA);
    } catch (Exception ex) {
      System.debug('Matching/Replacement on removing label issue');
      System.debug('Label Error is: ' + property);
      System.debug(ex.getMessage());
    }
    return extract;
  }

  private static List<CSA_LaserPro_Field_Mappings__mdt> getLaserProMappingList(
    String exclude
  ) {
    if (!Test.isRunningTest()) {
      return [
        SELECT
          Id,
          Field_API_Name__c,
          LaserPro_Extract_Data_Label__c,
          Filter_Criteria__c,
          Data_Resides_on_Account_Object__c,
          Relationship_to_Account__c,
          Pertains_to_Object_API__c,
          Remove_Value_from_Extract__c,
          Field_Value_Translation__c
        FROM CSA_LaserPro_Field_Mappings__mdt
        WHERE MasterLabel != :exclude AND Active__c = TRUE
      ];
    } else {
      List<CSA_LaserPro_Field_Mappings__mdt> testCoverageMDT = new List<CSA_LaserPro_Field_Mappings__mdt>();
      CSA_LaserPro_Field_Mappings__mdt t1 = new CSA_LaserPro_Field_Mappings__mdt(
        DeveloperName = 'UNIT_TEST_EXCLUDE_DO_NOT_DELETE',
        Label = 'DO_NOT_DELETE',
        Pertains_to_Object_API__c = 'LLC_BI__Loan__c',
        LaserPro_Extract_Data_Label__c = 'DoNotShow',
        Remove_Value_from_Extract__c = true,
        Field_API_Name__c = 'Name'
      );

      CSA_LaserPro_Field_Mappings__mdt t2 = new CSA_LaserPro_Field_Mappings__mdt(
        DeveloperName = 'UNIT_TEST_EI_DO_NOT_DELETE',
        Label = 'DO_NOT_DELETE',
        Filter_Criteria__c = 'LLC_BI__Borrower_Type__c=Borrower',
        Pertains_to_Object_API__c = 'LLC_BI__Legal_Entities__c',
        LaserPro_Extract_Data_Label__c = 'TestLabelEI',
        Remove_Value_from_Extract__c = true,
        Field_API_Name__c = 'Name',
        Field_Value_Translation__c = 'TestLegalEntity=Jay'
      );

      CSA_LaserPro_Field_Mappings__mdt t3 = new CSA_LaserPro_Field_Mappings__mdt(
        DeveloperName = 'UNIT_TEST_DO_NOT_DELETE',
        Label = 'UnitTestLabel',
        Pertains_to_Object_API__c = 'LLC_BI__Loan__c',
        Relationship_to_Account__c = 'LLC_BI__Account__r',
        LaserPro_Extract_Data_Label__c = 'UnitTestLabel',
        Data_Resides_on_Account_Object__c = true,
        Field_API_Name__c = 'Name'
      );

      testCoverageMDT.add(t1);
      testCoverageMDT.add(t2);
      testCoverageMDT.add(t3);
      return testCoverageMDT;
    }
  }

  private static final String SFDC_RELATED_OBJECT_SEPERATOR = '.';
  private static final String SOQL_SELECT_WITH_SPACE = 'SELECT ';
  private static final String SOQL_FROM_WITH_PADDING = ' FROM ';
  private static final String WHERE_WITH_PADDING = ' WHERE ';
  private static final String SOQL_FIELD_SEPERATOR = ',';
  private static final String EQUALS_WITH_PADDING = ' = ';
  private static final String SOQL_RECORD_ID = 'Id';
  private static final String ORDER_BY_WITH_PADDING = ' order by ';
  private static final String FEE_OBJECT_API_NAME = 'LLC_BI__Fee__c';
  private static final String FEE_OBJECT_SORT_ORDER = 'SystemModStamp ASC';
  private static final String LOAN_OBJECT_API_NAME = 'LLC_BI__Loan__c';
  private static final String REGEX_WILDCARD = '.*';
  private static final String REGEX_LINE_BREAK_PATTERN = '(\r?\n)';
  private static final String DO_NOT_DELETE = 'DO_NOT_DELETE';
  private static final String LOANIDVAR = ':loanId';
}