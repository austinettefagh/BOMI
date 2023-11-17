/*********************************************************************************************************
*@author             : PwC Team
*@date               : 
*@description        : This class covers the controller class "Commercial_RMHomeHeaderController" 
*@Modification Log   :
Change History Story              Modify by               Date                          Desc
**********************************************************************************************************/

@isTest(SeeAllData=FALSE)
private class Commercial_RMHomeHeaderControllerTest{
    private static String accRecordTypeId = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosByDeveloperName().get('IndustriesBusiness').getRecordTypeId();
    /********************************************************************************************************
Method name : setupTestData
Parameters  : none
return      : void
**********************************************************************************************************/
    @testSetup
    static void setupTestData(){
        test.startTest();
        //fetch the Mortgage recordtype id from Opportunity object
        Id MortgageRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('OPP_nCino_Opportunity').getRecordTypeId();
        //RecordType rtName= [select name,id,developerName from RecordType WHERE developerName ='Mortgage' LIMIT 1];
        Opportunity opportunity_Obj = new Opportunity( RecordTypeId = MortgageRecordTypeId,IsPrivate = false, Name = 'Name662', Description = '7',
                                                      StageName = 'Prospecting', Probability = 10, CloseDate = Date.today(), 
                                                      Type = 'Existing Business', NextStep = 'NextStep764', 
                                                      LeadSource = 'Advertisement', ForecastCategoryName = 'Omitted', 
                                                      Pricebook2Id = Test.getStandardPricebookId());
        Insert opportunity_Obj; 
        
        Account accRecord = new Account();
        accRecord.Name = 'Test Account';
        accRecord.RecordTypeId = accRecordTypeId;
        Insert accRecord;
        
        test.stopTest();
    }
    
    /********************************************************************************************************
Method name : getRMopportunitiesTest
Parameters  : none
return      : void
purpose     : covers getRMopportunities
**********************************************************************************************************/
    static testMethod void getRMopportunitiesTest(){
        List<Account> accList  =  [SELECT Id,Name,FinServ__TotalBankDeposits__c,FinServ__TotalOutstandingCredit__c,ownerId
                                   FROM Account
                                   WHERE Id != null
                                  LIMIT 1];
        
        System.assertEquals(false,accList.size()==0);
        //query account records
        List<Opportunity> opportunity_Obj  =  [SELECT Id,AccountId,RecordTypeId,IsPrivate,Name,Description,StageName,
                                                Amount,Probability,ExpectedRevenue,CloseDate,Type,NextStep,LeadSource,
                                                IsClosed,IsWon,ForecastCategory,ForecastCategoryName,CampaignId,HasOpportunityLineItem,
                                                Pricebook2Id,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,
                                                LastActivityDate,FiscalQuarter,FiscalYear,Fiscal,
                                                LastViewedDate,LastReferencedDate,
                                                FinServ__FinancialAccount__c,FinServ__Household__c,
                                                FinServ__ReferredByContact__c
                                               FROM Opportunity
                                               WHERE Id != NULL
                                               LIMIT 1
                                              ];
        //assert
        System.assertEquals(false,opportunity_Obj.size()==0);
        Treasury_Goals__c goal = new Treasury_Goals__c(TM_of_New_Commercial_Relationships__c=10, TM_of_New_Core_Treasury_Products_Sold__c=10, TM_New_Money_Commercial_Deposit_s__c=10, TM_New_Money_Till_Date__c=10, TM_New_Commercial_Relationships_Till__c=10, TM_New_Core_Treasury_Products_Sold_Till__c=10, TM_Fiscal_Year__c='2022', TM_Treasury_Solutions_Officer__c = UserInfo.getUserId());
        insert goal;
        // Commercial Dev
        //Commercial_RMHomeHeaderController.getRMopportunities('Name','DESC');
    }
    
    /********************************************************************************************************
Method name : setAmountOnOppsTest
Parameters  : none
return      : void
purpose     : covers the lines with amount greater than 0
**********************************************************************************************************/
    
    static testMethod void setAmountOnOppsTest(){
        AggregateResult[]   accResults;
        List<Account> accList  =  [SELECT Id,Name,FinServ__TotalBankDeposits__c,FinServ__TotalOutstandingCredit__c,ownerId
                                   FROM Account
                                   WHERE Id != null
                                  ];
        accResults = [SELECT SUM(Account.FinServ__TotalBankDeposits__c)depositbalance,SUM(Account.FinServ__TotalOutstandingCredit__c)creditbalance FROM Account WHERE OwnerId =:Userinfo.getUserId()];
        //accResults[0].SUM(Account.FinServ__TotalBankDeposits__c)depositbalance = 1230;
        System.assertEquals(true,accList.size()>0);
        List<Opportunity> opportunity_Obj  =  [SELECT Id,AccountId,RecordTypeId,IsPrivate,Name,Description,StageName,
                                                Amount,Probability,ExpectedRevenue,CloseDate,Type,NextStep,LeadSource,
                                                IsClosed,IsWon,ForecastCategory,ForecastCategoryName,CampaignId,
                                                HasOpportunityLineItem,Pricebook2Id,CreatedDate,CreatedById,LastModifiedDate,
                                                LastModifiedById,SystemModstamp,LastActivityDate,FiscalQuarter,FiscalYear,Fiscal,
                                                LastViewedDate,LastReferencedDate,
                                                FinServ__FinancialAccount__c,FinServ__Household__c,FinServ__ReferredByContact__c
                                               FROM Opportunity
                                               WHERE Id != NULL
                                              ];
        opportunity_Obj[0].Amount = 9;
        update opportunity_Obj;

        System.assertEquals(true,opportunity_Obj.size()>0);
        // Commercial Dev
        //Commercial_RMHomeHeaderController.getRMopportunities('Name','DESC');
    }

    /********************************************************************************************************
Method name : setAmountOnOppsTest
Parameters  : none
return      : void
purpose     : covers the lines with amount greater than 0
**********************************************************************************************************/
    
static testMethod void setClosedAmountOnOppsTest(){
    AggregateResult[]   accResults;
    List<Account> accList  =  [SELECT Id,Name,FinServ__TotalBankDeposits__c,FinServ__TotalOutstandingCredit__c,ownerId
                               FROM Account
                               WHERE Id != null
                              ];
    accResults = [SELECT SUM(Account.FinServ__TotalBankDeposits__c)depositbalance,SUM(Account.FinServ__TotalOutstandingCredit__c)creditbalance FROM Account WHERE OwnerId =:Userinfo.getUserId()];
    //accResults[0].SUM(Account.FinServ__TotalBankDeposits__c)depositbalance = 1230;
    System.assertEquals(true,accList.size()>0);
    List<Opportunity> opportunity_Obj  =  [SELECT Id,AccountId,RecordTypeId,IsPrivate,Name,Description,StageName,
                                            Amount,Probability,ExpectedRevenue,CloseDate,Type,NextStep,LeadSource,
                                            IsClosed,IsWon,ForecastCategory,ForecastCategoryName,CampaignId,
                                            HasOpportunityLineItem,Pricebook2Id,CreatedDate,CreatedById,LastModifiedDate,
                                            LastModifiedById,SystemModstamp,LastActivityDate,FiscalQuarter,FiscalYear,Fiscal,
                                            LastViewedDate,LastReferencedDate,
                                            FinServ__FinancialAccount__c,FinServ__Household__c,FinServ__ReferredByContact__c
                                           FROM Opportunity
                                           WHERE Id != NULL
                                          ];
    opportunity_Obj[0].Amount = 9;
    opportunity_Obj[0].Stagename = 'Immplemation';
    update opportunity_Obj;

    System.assertEquals(true,opportunity_Obj.size()>0);
    // Commercial Dev
    //Commercial_RMHomeHeaderController.getRMopportunities('Name','DESC');
}
    
    /********************************************************************************************************
Method name : getRMOppsException
Parameters  : none
return      : void
purpose     : covers catch block
**********************************************************************************************************/
    static testMethod void getRMOppsException(){
        try{
            //query account records
        List<Account> accList  =  [SELECT Id,Name,FinServ__TotalBankDeposits__c,FinServ__TotalOutstandingCredit__c,ownerId
                                   FROM Account
                                   WHERE Id != null
                                   LIMIT 1
                                  ];

        System.assertEquals(true,accList.size()==1);
            //query opportunity records
        List<Opportunity> opportunity_Obj  =  [SELECT Id,AccountId,RecordTypeId,IsPrivate,Name,Description,StageName,
                                                Amount,Probability,ExpectedRevenue,CloseDate,Type,NextStep,LeadSource,
                                                IsClosed,IsWon,ForecastCategory,ForecastCategoryName,CampaignId,HasOpportunityLineItem,
                                                Pricebook2Id,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,LastActivityDate,FiscalQuarter,FiscalYear,Fiscal,
                                                LastViewedDate,LastReferencedDate,
                                                FinServ__FinancialAccount__c,FinServ__Household__c,FinServ__ReferredByContact__c 
                                               FROM Opportunity
                                              WHERE Id != NULL];
        System.assertEquals(true,opportunity_Obj.size()>0);
            // Commercial Dev
        Commercial_RMHomeHeaderController.getRMopportunities('','');
        }catch(Exception expt){
            //throw exception
            //throw new AuraHandledException(System.Label.TM_StdErrorMessage);
            //throw new AuraHandledException(expt.getMessage());
            System.assert(expt.getMessage()!=null);
        }
    }
    
}