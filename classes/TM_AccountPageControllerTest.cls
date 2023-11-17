/**
 * @description test class for TM_AccountPageController description
 * 
 */ 
@isTest (SeeAllData=FALSE)
public class TM_AccountPageControllerTest {
    // IndustriesBusiness Account Record Type
    private static String accRecordTypeId = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosByDeveloperName().get('IndustriesBusiness').getRecordTypeId();
    // Loan Opportunity Record Type
    private static String loanRecordTypeId = Schema.getGlobalDescribe().get('Opportunity').getDescribe().getRecordTypeInfosByDeveloperName().get('OPP_nCino_Opportunity').getRecordTypeId();
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
        Account acc = new Account(Name = 'Smith', RecordTypeId = accRecordTypeId, BillingStreet = 'test', BillingCity = 'test', BillingState = 'test', BillingPostalCode = '123', AnnualRevenue = 2000000);
        insert acc;
        // insert oppty records
        List<Opportunity> opps = new List<Opportunity>();
        Opportunity loanOpp = new Opportunity(Name = 'Smith Opportunity1',StageName = 'Closed Won',CloseDate = System.today(), AccountId = acc.Id, RecordTypeId = loanRecordTypeId, Loan_Amount__c = 2000000);
        opps.add(loanOpp);
        Opportunity depositOpp = new Opportunity(Name = 'Smith Opportunity2',StageName = 'Closed Won',CloseDate = System.today(), AccountId = acc.Id, RecordTypeId = depositRecordTypeId, TM_Anticipated_Deposit_Amount__c = 2000000);
        opps.add(depositOpp);
        Opportunity treasuryOpp = new Opportunity(Name = 'Smith Opportunity3',StageName = 'Closed Won',CloseDate = System.today(), AccountId = acc.Id, RecordTypeId = treasuryRecordTypeId, TM_Projected_Annual_Treasury_Fee_Income__c = 2000000);
        opps.add(treasuryOpp);
        insert opps;
        test.stopTest();
    }

    /**
     * @description testgetOppDetails description
     * 
     */ 
    static testMethod void testgetOppDetails(){
        
        test.StartTest();
        List<Account> accList  =  [SELECT Id from Account WHERE Id!= null];
        System.assertEquals(true,accList.size()>0);
        TM_AccountPageController.getAccountDetails(accList[0].Id);
        test.stopTest();
    }
}