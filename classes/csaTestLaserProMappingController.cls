@IsTest(IsParallel=true)
private with sharing class csaTestLaserProMappingController {
  @IsTest
  private static void testInsertProperties() {
    Test.startTest();

    String extract = 'A1_AddReqInterimStmtDueWithin|336\nDoNotShow|THIS\n';
    nCSA_FRAME.csaTestDataFactory.createLoanBaseStructure();

    csaLaserProMappingController lpe = new csaLaserProMappingController();
    LLC_BI__Loan__c loan = [
      SELECT Id
      FROM LLC_BI__Loan__c
      WHERE name = 'TestLoan'
      LIMIT 1
    ];

    String updated_extract = lpe.format(loan.Id, extract);

    //silly test coverage hack to not introduce more cmt
    String testConstant;
    testConstant = csaLaserProMappingConstants.PROPERTY_INSTALLEDKEY;
    testConstant = csaLaserProMappingConstants.PROPERTY_INSTALLEDVALUE;
    testConstant = csaLaserProMappingConstants.PROERPTY_CATEGORY;

    testConstant = csaLaserProMappingConstants.FIELD_MAP_PROPERTY_NAME;

    testConstant = csaLaserProMappingConstants.LASERPRO_ENTITY_DIVIDER;
    testConstant = csaLaserProMappingConstants.LASERPRO_BLANK_DATA;
    testConstant = csaLaserProMappingConstants.LASERPRO_DATA_DIVIDER;
    testConstant = csaLaserProMappingConstants.LASERPRO_LINEBREAK;

    System.assert(
      updated_extract.indexOf('UnitTestLabel') > -1,
      'Overridden extract does not contain UnitTestLabel. Extract is ' + extract
    );
   /* System.assert(
      updated_extract.indexOf('Jay') > -1,
      'Overridden extract does not contain Jay. Extract is ' + extract
    ); */
    System.assert(
      updated_extract.indexOf('DoNotShow') == -1,
      'Overridden extract did not remove label. Extract is ' + extract
    );

    Test.stopTest();
  }
}