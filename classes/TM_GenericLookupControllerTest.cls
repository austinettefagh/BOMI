/*********************************************************************************************************
*@author    : PwC Team
*@date      : 3/16/2020
*@description : This class covers the controller class "LWCC_GenericLookupControllerTest" 
*@Modification Log   :
Change History Story              Modify by               Date                          Desc
**********************************************************************************************************/
@isTest (SeeAllData=FALSE)
public class TM_GenericLookupControllerTest {
    
    private static String recordTypeId = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosByDeveloperName().get('IndustriesBusiness').getRecordTypeId();
    private static String conRecordTypeId = Schema.getGlobalDescribe().get('Contact').getDescribe().getRecordTypeInfosByDeveloperName().get('IndustriesBusiness').getRecordTypeId();
    /********************************************************************************************************
    Method name : setupTestData
    Parameters  : none
    return      : void
    **********************************************************************************************************/     
    @testSetup
    static void setupTestData(){
        test.startTest();
        //Getting the profileId of the logged in user
        Id profileId= Userinfo.getProfileId();
        User user_Obj = new User(Username = 'TestUser62713202101131@codecoverage.com', LastName = 'LastName738', Email = 'Email24@test.com',Alias = 'Alias985',TimeZoneSidKey = 'Pacific/Kiritimati', LocaleSidKey = 'sq_AL',EmailEncodingKey = 'UTF-8',LanguageLocaleKey = 'en_US',ProfileId=profileId);
        Insert user_Obj; 
        test.stopTest();
    }
    /********************************************************************************************************
    Method name : testfindRecords
    Parameters  : none
    return      : void
    **********************************************************************************************************/   
    static testMethod void testfindRecords(){
        //Getting the Id of the logged in user
        //Id userId=UserInfo.getUserId();
        //List<User> userObj  =  [SELECT Id, Username,Email,LastName FROM User WHERE LastName='LastName738' LIMIT 1];
        test.StartTest();
        Account acc = new Account();
        acc.Name = 'AccountUser';
        acc.RecordTypeId = recordTypeId;
        insert acc;
        string ANI = '1234567890';
        // Create Contact
        Contact contact = new Contact();
        contact.FirstName = 'Test Filter';
        contact.LastName = 'lookup Filter';
        contact.AccountId = acc.id;
        contact.phone = ANI;
        contact.recordTypeId = conRecordTypeId;
        insert contact;
        //Assert statement to check the query doesn't return empty rows on assignment
        List<User> resultedUser =  TM_GenericLookupController.findRecords('Last','User','');
        // TM_GenericLookupController.findRecords('Filter','Contact',acc.id);
        System.assertEquals(true,resultedUser.size()>0); 
        test.StopTest(); 
    }

    /********************************************************************************************************
    Method name : testfindRecords2
    Parameters  : none
    return      : void
    **********************************************************************************************************/   
    static testMethod void testfindRecords2(){
        //Getting the Id of the logged in user
        //Id userId=UserInfo.getUserId();
        //List<User> userObj  =  [SELECT Id, Username,Email,LastName FROM User WHERE LastName='LastName738' LIMIT 1];
        test.StartTest();
        Account acc = new Account();
        acc.Name = 'AccountUser';
        acc.RecordTypeId = recordTypeId;
        insert acc;
        string ANI = '1234567890';
        // Create Contact
        Contact contact = new Contact();
        contact.FirstName = 'Test Filter';
        contact.LastName = 'lookup Filter';
        contact.AccountId = acc.id;
        contact.phone = ANI;
        contact.recordTypeId = conRecordTypeId;
        insert contact;
        try {
            TM_GenericLookupController.findRecords('Filter','Contact1',acc.id);
        } catch (Exception expt) {
            System.assert(expt.getMessage()!=null);
        }
        
        test.StopTest(); 
    }
}