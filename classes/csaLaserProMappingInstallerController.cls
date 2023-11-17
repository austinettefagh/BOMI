public with sharing class csaLaserProMappingInstallerController {
  public class CheckInstall extends nFORCE.RemoteActionController.Endpoint {
    public override virtual Object invoke(Map<String, Object> params) {
      nFORCE.SystemProperties properties = nFORCE.SystemProperties.getInstance();
      return properties.getPropertyAsBoolean(
        nCSA_FRAME.csaConstants.CSASYSTEMPROPERTYCATEGORY,
        csaLaserProMappingConstants.PROPERTY_INSTALLEDKEY,
        false
      );
    }
  }

  public class Install extends nFORCE.RemoteActionController.Endpoint {
    public override virtual Object invoke(Map<String, Object> params) {
      List<sObject> toInsert = new List<sObject>();

      toInsert.add(
        nFORCE.SystemProperties.createProperty(
          nCSA_FRAME.csaConstants.CSASYSTEMPROPERTYCATEGORY,
          csaLaserProMappingConstants.PROPERTY_INSTALLEDKEY,
          csaLaserProMappingConstants.PROPERTY_INSTALLEDVALUE,
          true
        )
      );

      LLCLP.FormatManager.registerCustomFormatter(
        csaLaserProMappingController.class
      );

      insert toInsert;
      return null;
    }
  }

  public class Uninstall extends nFORCE.RemoteActionController.Endpoint {
    public override virtual Object invoke(Map<String, Object> params) {
      List<nFORCE__System_Properties__c> toDelete = new List<nFORCE__System_Properties__c>();

      toDelete.addAll(
        [
          SELECT Id
          FROM nFORCE__System_Properties__c
          WHERE
            nFORCE__Key__c = :csaLaserProMappingConstants.PROPERTY_INSTALLEDKEY
            OR nFORCE__Category_Name__c = :csaLaserProMappingConstants.PROERPTY_CATEGORY
          LIMIT 100
        ]
      );

      if (!toDelete.isEmpty()) {
        delete toDelete;
      }

      return null;
    }
  }
}