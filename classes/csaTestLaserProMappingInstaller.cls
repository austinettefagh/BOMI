@isTest(IsParallel=true)
private with sharing class csaTestLaserProMappingInstaller {
  @isTest
  static void testCheckInstall() {
    nCSA_FRAME.csaTestDataFactory.createForceSystemProperty(
      nCSA_FRAME.csaConstants.CSASYSTEMPROPERTYCATEGORY,
      csaLaserProMappingConstants.PROPERTY_INSTALLEDKEY,
      csaLaserProMappingConstants.PROPERTY_INSTALLEDVALUE,
      true,
      null
    );

    Test.startTest();

    Boolean result = (Boolean) nFORCE.RemoteActionController.invoke(
      'csaLaserProMappingInstallerController.CheckInstall',
      null
    );

    Test.stopTest();

    System.assertEquals(true, result);
  }

  @isTest
  static void testInstall() {
    Test.startTest();

    nFORCE.RemoteActionController.invoke(
      'csaLaserProMappingInstallerController.Install',
      null
    );
    List<nFORCE__System_Properties__c> propertiesResults = [
      SELECT Id
      FROM nFORCE__System_Properties__c
      LIMIT 3
    ];

    Test.stopTest();

    System.assertEquals(1, propertiesResults.size());
  }

  @isTest
  static void testUninstall() {
    nCSA_FRAME.csaTestDataFactory.createForceSystemProperty(
      nCSA_FRAME.csaConstants.CSASYSTEMPROPERTYCATEGORY,
      csaLaserProMappingConstants.PROPERTY_INSTALLEDKEY,
      csaLaserProMappingConstants.PROPERTY_INSTALLEDVALUE,
      true,
      null
    );

    Test.startTest();

    nFORCE.RemoteActionController.invoke(
      'csaLaserProMappingInstallerController.Uninstall',
      null
    );
    List<nFORCE__System_Properties__c> propertiesResults = [
      SELECT Id
      FROM nFORCE__System_Properties__c
      LIMIT 3
    ];

    Test.stopTest();

    System.assertEquals(0, propertiesResults.size());
  }

  @TestSetup
  private static void testSetup() {
    nFORCE.BeanRegistry.getInstance()
      .registerBean(
        'ClassTypeProvider',
        nFORCE.ClassTypeProvider.class,
        Type.forName('ClassTypeProvider')
      );
  }
}