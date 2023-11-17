/**
 * @description TM_AddProductsController
 */ 
public without sharing class TM_AddProductsController {
    /**
     * @description getProductDetails description
     * @return   return description
     */
    @AuraEnabled(cacheable=true)
    public static List<PricebookEntry> getProductDetails(String oppId){
        try{
            // Get Opportunity recordtype to distinguish the product
            List<Opportunity> oppLst = [SELECT Id, RecordType.Name FROM Opportunity WHERE Id =: oppId];
            String oppProductType = 'Treasury Solutions';
            if ( oppLst.size() > 0 && oppLst[0].RecordType.Name == 'Track Deposit Pipeline') {
                oppProductType = 'Business Deposits';
            }
            // system.debug('check data' + oppProductType);

            List<PricebookEntry> productsList = [SELECT Name,Pricebook2Id,Product2Id,UnitPrice,Product2.Name,Product2.TM_Product_Line__c,Product2.TM_Product_Type__c,Product2.TM_Product__c,Product2.TM_Order_Number__c FROM PricebookEntry WHERE Product2.TM_Product_Line__c = :oppProductType ORDER BY Product2.TM_Order_Number__c];
            return productsList;
        } catch(Exception ex) {
            throw new AuraHandledException(System.Label.TM_StdErrorMessage);
        }
    }

    /**
     * @description saveOpportunityItems description
     * @param  oppId    oppId description
     * @param  oppItems oppItems description
     */ 
    // @AuraEnabled(cacheable=true)
    @AuraEnabled(Cacheable=false)
    public static void saveOpportunityItems(String oppId, List<OpportunityLineItem> oppItems){
        Savepoint sp = Database.setSavepoint();
        try {
            // Opportunity list
            List<Opportunity> oppLst = [SELECT Id, Pricebook2Id FROM Opportunity WHERE Id =: oppId];
            if (oppLst.size() > 0 && oppLst[0].Pricebook2Id != null) {
                for (OpportunityLineItem item : oppItems) {
                    item.OpportunityId = oppId;
                }
                insert oppItems;
            } else {
                if(Test.isrunningtest()) {
                    Id pricebookId = Test.getStandardPricebookId();//Return getStandardPricebookId 
                    oppLst[0].Pricebook2Id = pricebookId;
                } else {
                    Pricebook2 pricebookId = [SELECT Id FROM Pricebook2 WHERE Name = 'Standard Price Book'][0]; 
                    oppLst[0].Pricebook2Id = pricebookId.Id;
                }
                // Pricebook2 pricebookId = [SELECT Id FROM Pricebook2 WHERE Name = 'Standard Price Book'][0]; 
                // oppLst[0].Pricebook2Id = pricebookId.Id;
                
                update oppLst;
                for (OpportunityLineItem item : oppItems) {
                    item.OpportunityId = oppId;
                }
                insert oppItems;
            }
        } catch (Exception ex) {
            Database.rollback(sp);
            // throw exception
            throw new AuraHandledException(System.Label.TM_StdErrorMessage);
        } 
    }
}