/**
 * @description Test class for TM_RefreshTreasuryGoal
 */ 
@isTest (SeeAllData=FALSE)
public class TM_RefreshTreasuryGoalTest {
    private static String accRecordTypeId = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosByDeveloperName().get('IndustriesBusiness').getRecordTypeId();
    private static String depositRecordTypeId = Schema.getGlobalDescribe().get('Opportunity').getDescribe().getRecordTypeInfosByDeveloperName().get('TM_Track_Deposit_Pipeline').getRecordTypeId();
    private static String treasuryRecordTypeId = Schema.getGlobalDescribe().get('Opportunity').getDescribe().getRecordTypeInfosByDeveloperName().get('TM_Track_Treasury_Products_Sold').getRecordTypeId();
    /********************************************************************************************************
    Method name : setupTestData
    Parameters  : none
    return      : void
    **********************************************************************************************************/   
    @testSetup
    static void setupTestData(){
        // get TSO Profile Id
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'Treasury Sales Officer' LIMIT 1];
        test.startTest();
        //insert user record
		User user = new user();
		user.Username='standarduser' + DateTime.now().getTime() + '@test.com';
		user.FirstName='Test';
		user.LastName='User';
		user.Email='useremail@test.com';
		user.Alias = 'Tcode';
		user.TimeZoneSidKey = 'GMT';
		user.LocaleSidKey = 'en_US';
		user.EmailEncodingKey = 'UTF-8';
		user.ProfileID = profileId.Id;
		user.LanguageLocaleKey = 'en_US';
        insert user;
        //insert treasuryGoal record
        Treasury_Goals__c treasuryGoal = new Treasury_Goals__c(TM_Treasury_Solutions_Officer__c = user.Id, Name = 'New test');
        insert treasuryGoal;
        //insert acc record
        Account acc = new Account(Name = 'Smith', RecordTypeId = accRecordTypeId, CIF__c = '123', AnnualRevenue = 2000000, OwnerId = user.Id);
        insert acc;
        //insert oppty records
        List<Opportunity> opps = new List<Opportunity>();
        Opportunity depositOpp = new Opportunity(Name = 'Smith Opportunity2',StageName = 'Closed Won',CloseDate = System.today(), AccountId = acc.Id, RecordTypeId = depositRecordTypeId, TM_New_Money__c = 2000000, OwnerId = user.Id);
        opps.add(depositOpp);
        Opportunity treasuryOpp = new Opportunity(Name = 'Smith Opportunity3',StageName = 'Closed Won',CloseDate = System.today(), AccountId = acc.Id, RecordTypeId = treasuryRecordTypeId, TM_Projected_Annual_Treasury_Fee_Income__c = 2000000, OwnerId = user.Id);
        opps.add(treasuryOpp);
        insert opps;
        test.stopTest();
    }

    /**
     * @description testrefreshGoal description
     * 
     */ 
    static testMethod void testrefreshGoal(){
        
        test.StartTest();
        //get treasuryGoal info
        List<Treasury_Goals__c> treasuryGoal  =  [SELECT Id from Treasury_Goals__c WHERE Id!= null];
        System.assertEquals(true,treasuryGoal.size()>0);
        TM_RefreshTreasuryGoal.refreshGoal(treasuryGoal[0].Id);
        test.stopTest();
    }

    /**
     * @description testrefreshGoal2 description
     * 
     */ 
    static testMethod void testrefreshGoal2(){
        
        test.StartTest();
        //get treasuryGoal info
        List<Treasury_Goals__c> treasuryGoal  =  [SELECT Id from Treasury_Goals__c WHERE Id!= null];
        System.assertEquals(true,treasuryGoal.size()>0);
        TM_RefreshTreasuryGoal.refreshGoal('');
        test.stopTest();
    }
}