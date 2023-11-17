/**
 * @description test class for TM_AddProductsController description
 * 
 */ 
@isTest(SeeAllData=false)
public class TM_AddProductsControllerTest {
    // IndustriesBusiness Account Record Type
    private static String accRecordTypeId = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosByDeveloperName().get('IndustriesBusiness').getRecordTypeId();
    // TM_Track_Deposit_Pipeline Opportunity Record Type
    private static String depositRecordTypeId = Schema.getGlobalDescribe().get('Opportunity').getDescribe().getRecordTypeInfosByDeveloperName().get('TM_Track_Deposit_Pipeline').getRecordTypeId();
    // TM_Track_Treasury_Products_Sold Opportunity Record Type
    private static String treasuryRecordTypeId = Schema.getGlobalDescribe().get('Opportunity').getDescribe().getRecordTypeInfosByDeveloperName().get('TM_Track_Treasury_Products_Sold').getRecordTypeId();
    
    /**
     * @description setupTestData description
     * 
     */ 
    @testSetup
    static void setupTestData(){
        test.startTest();
        // insert acc record
        Account acc = new Account(Name = 'Smith', RecordTypeId = accRecordTypeId, BillingStreet = 'gumei', BillingCity = 'shanghai', BillingState = 'test', BillingPostalCode = '123', AnnualRevenue = 2000000);
        insert acc;
        // Pricebook2 price = new Pricebook2(Name = 'Standard Price Book', IsActive = true);
        // insert price;
        Id pricebookId = Test.getStandardPricebookId();
        // insert oppty records
        List<Opportunity> opps = new List<Opportunity>();
        Opportunity depositOpp = new Opportunity(Name = 'Smith Opportunity2',StageName = 'Closed Won',CloseDate = System.today(), AccountId = acc.Id, RecordTypeId = depositRecordTypeId, TM_Anticipated_Deposit_Amount__c = 2000000, Pricebook2Id = pricebookId);
        opps.add(depositOpp);
        Opportunity treasuryOpp = new Opportunity(Name = 'Smith Opportunity3',StageName = 'Closed Won',CloseDate = System.today(), AccountId = acc.Id, RecordTypeId = treasuryRecordTypeId, TM_Projected_Annual_Treasury_Fee_Income__c = 2000000);
        opps.add(treasuryOpp);
        insert opps;
        List<Product2> prods = new List<Product2>();
        Product2 prod1 = new Product2(Name = 'B1 - Small Business Checking', TM_Product_Line__c = 'Business Deposits', TM_Product_Type__c = 'Business Checking', TM_Product__c = 'B1 - Small Business Checking',TM_Order_Number__c=1);
        prods.add(prod1);
        Product2 prod2 = new Product2(Name = 'Multi User', TM_Product_Line__c = 'Treasury Solutions', TM_Product_Type__c = 'Management Solutions', TM_Product__c = 'Multi User',TM_Order_Number__c=1);
        prods.add(prod2);
        insert prods;
        List<PricebookEntry> entry = new List<PricebookEntry>();
        PricebookEntry entry1 = new PricebookEntry(IsActive = true, UnitPrice = 0, Product2Id = prod1.Id, Pricebook2Id = pricebookId);
        entry.add(entry1);
        PricebookEntry entry2 = new PricebookEntry(IsActive = true, UnitPrice = 0, Product2Id = prod2.Id, Pricebook2Id = pricebookId);
        entry.add(entry2);
        insert entry;
        test.stopTest();
    }

    static testMethod void testgetProductDetails(){
        test.StartTest();
        List<Product2> prod = [SELECT Id FROM Product2 WHERE Name = 'B1 - Small Business Checking'];
        System.assertEquals(true,prod.size()>0);
        List<OpportunityLineItem> oppItems = new List<OpportunityLineItem>();
        OpportunityLineItem oppItem = new OpportunityLineItem(UnitPrice = 0, ServiceDate = Date.today(), Description = 'SJLISNFSDLKSDJF', Quantity = 1, Product2Id = prod[0].Id);
        oppItems.add(oppItem);
        List<Opportunity> oppList  =  [SELECT Id from Opportunity WHERE RecordType.DeveloperName = 'TM_Track_Deposit_Pipeline'];
        System.assertEquals(true,oppList.size()>0);
        TM_AddProductsController.getProductDetails(oppList[0].Id);
        TM_AddProductsController.saveOpportunityItems(oppList[0].Id,oppItems);
        test.stopTest();
    }

    static testMethod void testgetOppDetails(){
        
        test.StartTest();
        List<Product2> prod = [SELECT Id FROM Product2 WHERE Name='Multi User'];
        System.assertEquals(true,prod.size()>0);
        List<OpportunityLineItem> oppItems = new List<OpportunityLineItem>();
        OpportunityLineItem oppItem = new OpportunityLineItem(UnitPrice = 0, ServiceDate = Date.today(), Description = 'SIENWELSDLFIN', Quantity = 1, Product2Id = prod[0].Id);
        oppItems.add(oppItem);
        List<Opportunity> oppList  =  [SELECT Id from Opportunity WHERE RecordType.DeveloperName = 'TM_Track_Treasury_Products_Sold'];
        System.assertEquals(true,oppList.size()>0);
        TM_AddProductsController.getProductDetails(oppList[0].Id);
        TM_AddProductsController.saveOpportunityItems(oppList[0].Id,oppItems);
        test.stopTest();
    }

    static testMethod void testgetOppDetails2(){
        
        test.StartTest();
        try {
            TM_AddProductsController.getProductDetails('0011');
        } catch (Exception expt) {
            System.assert(expt.getMessage()!=null);
        }
        test.stopTest();
    }
    static testMethod void testgetOppDetails3(){
        
        test.StartTest();
        try {
            TM_AddProductsController.saveOpportunityItems('0011',null);
        } catch (Exception expt) {
            System.assert(expt.getMessage()!=null);
        }
        test.stopTest();
    }

}