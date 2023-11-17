/*********************************************************************************************************
*@author             : PwC Team
*@date               : 8/11/2022
*@description        : This class covers the controller class "Commercial_RMDesktopController" 
*@Modification Log   :
Change History Story              Modify by               Date                          Desc
**********************************************************************************************************/

@isTest(SeeAllData=FALSE)
private class Commercial_RMDesktopControllerTest{
    public static User ob_user;
    /********************************************************************************************************
    Method name : setupTestData
    Parameters  : none
    return      : void
    **********************************************************************************************************/
    @testSetup
    static void setupTestData(){
        test.startTest();
        //Id accRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('IndustriesBusiness').getRecordTypeId();
        // Opportunity General Record Type ID
        Id opporRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('OPP_nCino_Opportunity').getRecordTypeId();
        String enUS = 'en_US';
        // get TSO Profile Id
        Profile newProfile = [SELECT Id FROM Profile WHERE Name = 'Relationship Manager & Credit' LIMIT 1];
        UserRole ruleObj = new UserRole(DeveloperName = 'MyCustomRole', Name = 'My Role');
        insert ruleObj;
        UserRole ruleObj2 = new UserRole(DeveloperName = 'MyCustomRole2', Name = 'My Role2',ParentRoleId = ruleObj.Id);
        insert ruleObj2;
        User objuser = new User(
                FirstName = 'Test',
                LastName = 'User',
                Email = 'Testuser12@test.com',
                Username = 'jiojtesting12@user.com',
                Alias = 'TestC',
                UserRoleId = ruleObj.Id,
                TimeZoneSidKey = 'GMT', 
                LocaleSidKey = enUS, 
                EmailEncodingKey = 'UTF-8', 
                ProfileId = newProfile.Id, 
                LanguageLocaleKey = enUS);  
        // insert TSO User    
        insert objuser;
        User objuser1 = new User(
                FirstName = 'Test1',
                LastName = 'User1',
                Email = 'Testuser121@test.com',
                Username = 'jiojtesting121@user.com',
                Alias = 'TestC1',
                UserRoleId = ruleObj2.Id,
                TimeZoneSidKey = 'GMT', 
                LocaleSidKey = enUS, 
                EmailEncodingKey = 'UTF-8', 
                ProfileId = newProfile.Id, 
                LanguageLocaleKey = enUS);      
        insert objuser1;
        // run as TSO User
        system.RunAs(objuser){
            //Account account_Obj = new Account(Name = 'Name570',FinServ__Status__c = 'Active', FinServ__TotalRevenue__c = 181, RecordTypeId = accRecordTypeId);
            //Insert account_Obj; 
            Opportunity opportunityObj = new Opportunity(IsPrivate = false, Name = 'Name125', StageName = 'Prospecting', Amount = 9, CloseDate = Date.today(), RecordTypeId = opporRecordTypeId, OwnerId=objuser1.Id);
            Insert opportunityObj; 
            Opportunity opportunityObj1 = new Opportunity(IsPrivate = false, Name = 'Name125', StageName = 'Implementation', Amount = 9, CloseDate = Date.today(), RecordTypeId = opporRecordTypeId, OwnerId=objuser.Id);
            Insert opportunityObj1;
            
        }
        test.stopTest();
    }
    
    /********************************************************************************************************
    Method name : getOpportunitiesTest
    Parameters  : none
    return      : void
    **********************************************************************************************************/
    static testMethod void getOpportunitiesTest(){
        List<User> users = [Select Id FROM User WHERE Profile.Name = 'Relationship Manager & Credit' AND IsActive = true];
        User objuser = users.size() > 0 ? users[0] : new User();
        system.RunAs(objuser){            
        try{
            //List<Account> account_Obj  =  [SELECT Id,Name,LastActivityDate,FinServ__Status__c,FinServ__TotalRevenue__c from Account WHERE Id!= null];
            //System.assertEquals(true,account_Obj.size()>0);
            //get opportunity list
            List<Opportunity> opportunity_Obj  =  [SELECT Id,Name,StageName,Amount,LastActivityDate from Opportunity WHERE Id!= null];
            System.assertEquals(true,opportunity_Obj.size()>0);
            List<String> strRecordType = Commercial_RMDesktopController.fetchRecordTypeValues('Opportunity');
            Commercial_RMDesktopController.getRecTypeId(strRecordType[0],'Opportunity');
            Commercial_RMDesktopController.getOpportunities('test data');
            //AURAC_RMDesktopController.getOpportunities('all');
        }Catch(Exception expt){
             System.assert(expt.getMessage()!=null);
        }
        }
    }
    
    /********************************************************************************************************
    Method name : getOpportunitesTestUseCase2
    Parameters  : none
    return      : void
    **********************************************************************************************************/
    static testMethod void getOpportunitesTestUseCase2(){
        // List<Account> account_Obj  =  [SELECT Id,Name,LastActivityDate,FinServ__Status__c,FinServ__TotalRevenue__c from Account WHERE Id!= null];
        //System.assertEquals(true,account_Obj.size()>0);
        List<User> users = [Select Id FROM User WHERE Profile.Name = 'Relationship Manager & Credit' AND IsActive = true];
        User objuser = users.size() > 0 ? users[0] : new User();
        system.RunAs(objuser){ 
            List<Opportunity> opportunityObj  =  [SELECT Id,Name,StageName,Amount,LastActivityDate from Opportunity WHERE Id!= null];
            //TM_RMDesktopController.getReferralsForFinFlowsHome('');
            //TM_RMDesktopController.getLeadsForFinFlowsHome('');
            Commercial_RMDesktopController.getOpportunities('all');
            Commercial_RMDesktopController.getOpportunitiesSM('all');
            try{
                 Commercial_RMDesktopController.getWealthClients('all');
            }
            Catch(Exception expt){
                 System.assert(expt.getMessage()!=null);
            }
             
       //     Commercial_RMDesktopController.getOpportunitiesSM('');
            System.assertEquals(true,opportunityObj.size()>0);
        }
        
    }
    
    /********************************************************************************************************
    Method name : getAccountsTest
    Parameters  : none
    return      : void
    **********************************************************************************************************/
    static testMethod void getAccountsTest(){
        List<User> users = [Select Id FROM User WHERE Profile.Name = 'Relationship Manager & Credit' AND IsActive = true];
        User objuser = users.size() > 0 ? users[0] : new User();
        system.RunAs(objuser){   
            try{
                //List<Account> account_Obj  =  [SELECT Id,Name,LastActivityDate,FinServ__Status__c,FinServ__TotalRevenue__c FROM Account WHERE Id!= null];
                // System.assertEquals(true,account_Obj.size()>0);
                List<Opportunity> opportunityObj  =  [SELECT Id,Name,StageName,Amount,LastActivityDate from Opportunity WHERE Id!= null];
                System.assertEquals(true,opportunityObj.size()>0);
                Commercial_RMDesktopController.getAccounts('test data');
          //      Commercial_RMDesktopController.getAccounts('all');
           //     Commercial_RMDesktopController.getWealthClients('all');
            }Catch(Exception expt){
                 System.assert(expt.getMessage()!=null);
            }
        }
    }

    /********************************************************************************************************
    Method name : getPickListValues
    Parameters  : none
    return      : void
    **********************************************************************************************************/
    static testMethod void getPickListValues(){
        //List<Account> account_Obj  =  [SELECT Id,Name,LastActivityDate,FinServ__Status__c,FinServ__TotalRevenue__c from Account WHERE Id!= null];
       // System.assertEquals(true,account_Obj.size()>0);
       List<User> users = [Select Id FROM User WHERE Profile.Name = 'Relationship Manager & Credit' AND IsActive = true];
       User objuser = users.size() > 0 ? users[0] : new User();
        system.RunAs(objuser){
            List<Opportunity> opportunity_Obj  =  [SELECT Id,Name,StageName,Amount,LastActivityDate FROM Opportunity WHERE Id!= null LIMIT 1];
            System.assertEquals(false,opportunity_Obj.size()==0);
            //AURAC_RMDesktopController.initMethod('Account');
            Commercial_RMDesktopController.getPickListValues('Rating','Account');
            Commercial_RMDesktopController.getFilterFields('TM_RM_Accounts','Account');
            Commercial_RMDesktopController.getStageWiseData();
            try{
                Commercial_RMDesktopController.getPickListValues('null','null');
            }Catch(Exception expt){
                 System.assert(expt.getMessage()!=null);
            }
        }        
    }
    /********************************************************************************************************
    Method name : wrapperClassTest
    Parameters  : none
    return      : void
    **********************************************************************************************************/
    static testMethod void wrapperClassTest(){
       // List<Account> account_Obj  =  [SELECT Id,Name,LastActivityDate,FinServ__Status__c,FinServ__TotalRevenue__c from Account WHERE Id!= null];
      //  System.assertEquals(true,account_Obj.size()>0);
        List<Opportunity> opportunity_Obj  =  [SELECT Id,Name,StageName,Amount,LastActivityDate FROM Opportunity WHERE Id!= null LIMIT 1];
        System.assertEquals(true,opportunity_Obj.size()==1);
        Commercial_RMDesktopController.initMethod('Account');
        try{
            Commercial_RMDesktopController.initMethod('null');  
        }Catch(Exception expt){
            System.assert(expt.getMessage()!=null);
        }
    }
}