/**
 * @description TM_TreasuryGoalHandlerTest description
 */ 
@isTest(SeeAllData=FALSE) 
private class TM_TreasuryGoalHandlerTest {
    //current Year
    private static String year = '2022';
    /**
     * @description treasuryGoalTestMethod description
     */ 
    static testMethod void treasuryGoalTestMethod(){
        //insert treasury goal record
        Treasury_Goals__c goal = new Treasury_Goals__c(TM_of_New_Commercial_Relationships__c=10, TM_of_New_Core_Treasury_Products_Sold__c=10, TM_New_Money_Commercial_Deposit_s__c=10, TM_New_Money_Till_Date__c=10, TM_New_Commercial_Relationships_Till__c=10, TM_New_Core_Treasury_Products_Sold_Till__c=10, TM_Fiscal_Year__c=year, TM_Treasury_Solutions_Officer__c = UserInfo.getUserId(), TM_Active__c = true);
        insert goal;
        test.startTest();
        try {
            //insert record
            Treasury_Goals__c goal2 = new Treasury_Goals__c(TM_of_New_Commercial_Relationships__c=10, TM_of_New_Core_Treasury_Products_Sold__c=10, TM_New_Money_Commercial_Deposit_s__c=10, TM_New_Money_Till_Date__c=10, TM_New_Commercial_Relationships_Till__c=10, TM_New_Core_Treasury_Products_Sold_Till__c=10, TM_Fiscal_Year__c=year, TM_Treasury_Solutions_Officer__c = UserInfo.getUserId(),TM_Active__c = true);
            insert goal2;
        } catch (Exception expt) {
            //catch error
            System.assert(expt.getMessage()!=null);
        }
        
        test.stopTest();
    }

    /**
     * @description treasuryGoalTestMethod2 description
     */ 
    static testMethod void treasuryGoalTestMethod2(){
        //insert treasury goal record
        // Treasury_Goals__c goal = new Treasury_Goals__c(TM_of_New_Commercial_Relationships__c=10, TM_of_New_Core_Treasury_Products_Sold__c=10, TM_New_Money_Commercial_Deposit_s__c=10, TM_New_Money_Till_Date__c=10, TM_New_Commercial_Relationships_Till__c=10, TM_New_Core_Treasury_Products_Sold_Till__c=10, TM_Fiscal_Year__c=year, TM_Treasury_Solutions_Officer__c = UserInfo.getUserId(), TM_Active__c = true);
        // insert goal;
        test.startTest();
        try {
            //insert record
            Treasury_Goals__c goal2 = new Treasury_Goals__c(TM_of_New_Commercial_Relationships__c=10, TM_of_New_Core_Treasury_Products_Sold__c=10, TM_New_Money_Commercial_Deposit_s__c=10, TM_New_Money_Till_Date__c=10, TM_New_Commercial_Relationships_Till__c=10, TM_New_Core_Treasury_Products_Sold_Till__c=10, TM_Fiscal_Year__c=year, TM_Treasury_Solutions_Officer__c = UserInfo.getUserId(),TM_Active__c = false);
            insert goal2;
            // update record
            goal2.TM_Active__c = true;
            update goal2;
        } catch (Exception expt) {
            //catch error
            System.assert(expt.getMessage()!=null);
        }
        
        test.stopTest();
    }
}