/** 
* This  class is for application number generaton and loan number generation
* Date               User               Change 
* 8/20/2021          PwC               Initial Version
* 
* This is test class for WS_eTranService class.
*/

@isTest
public with sharing class WS_eTranServiceTest {
    
    @TestSetup
    static voId makeData(){
        
        EtranCredential__c etran = new EtranCredential__c(TECH_CLSUsername__c = 'TestUserName',TECH_CLSPassword__c = 'TestPassword', TECH_SFUsername__c = userinfo.getUserName());
        insert etran;
        
        LLC_BI__Application__c application = new LLC_BI__Application__c(nPortal__Artifact_Id__c = 'eTran Application', nSBA__Form_159_Business_Name_of_Agent__c = 'JJ Enterprises');
        insert application;
        
        cm_Industry_Code__c naics = new cm_Industry_Code__c(Name = '123456'); //Updated to cm_Industry_Code__c by Jayanth from E2E NAICS
        insert naics;
        
        Account business = new Account(
            Name = 'eTran Business',
            BillingCity='test',
            BillingPostalCode='test',
            BillingState='test',
            BillingStreet='test',
            //LLC_BI__Tax_Identification_Number_PE__c = '134534234',
            LLC_BI__Tax_Identification_Number_PE__c = '994534123',
            nSBA__Prior_SBA_Loan__c=false,
            cm_Industry_Code__c = naics.Id,
            //SELECT_Your_Business_Entity_Type__c ='LLC',
            NumberOfEmployees=200,
            Phone='123456789',
            ShippingCity='test',
            ShippingPostalCode='test1',
            ShippingState='test',
            ShippingStreet='test',
            Type='Trust',
            recordtypeId = [SELECT Id FROM RecordType WHERE SobjectType = 'Account' And DeveloperName = 'IndustriesBusiness' LIMIT 1].Id
        );
        insert business;
		
        //Id prsnAccountRecTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('PersonAccount').getRecordTypeId();        
        Account indivIdual = new Account(
            Name = 'eTran IndivIdual',
            //E2E_Last_Name__c = 'IndivIdual',
            //LLC_BI__SS__pc ='445654567',
/*            nSBA__Veteran_Status__pc='4',
            nSBA__Gender__pc='M',
            nSBA__US_Citizen__pc=true,*/
            recordtypeId = [SELECT Id FROM RecordType WHERE SobjectType = 'Account' And DeveloperName = 'Individual' LIMIT 1].Id
           // recordtypeId = prsnAccountRecTypeId
        );
        insert indivIdual;


            Account indivIdual1 = new Account(
            FirstName = 'eTran',
            LastName = 'IndivIdual',
            //E2E_Last_Name__c = 'IndivIdual',
            LLC_BI__SS__pc ='445654567',
            Type = 'Individual',    
            recordtypeId = [SELECT Id FROM RecordType WHERE SobjectType = 'Account' And DeveloperName = 'PersonAccount' LIMIT 1].Id
           // recordtypeId = prsnAccountRecTypeId
        );
        insert indivIdual1;
        
        // New Added by Jayanth for test coverage
        LLC_BI__Connection_Role__c conRole = new LLC_BI__Connection_Role__c(
            Name = 'Owner',
            LLC_BI__Sort_Order__c = 0
        );
        insert conRole;  
        
        LLC_BI__Connection__c con = new LLC_BI__Connection__c(
                LLC_BI__Connected_To__c = indivIdual1.Id,
                LLC_BI__Ownership_Percent__c = 100.00,
                LLC_BI__Connected_From__c = business.Id,
                //E2E_Role__c,
            	LLC_BI__Connection_Role__c = conRole.Id
        ); 
        insert con;
        
        Contact contact = new Contact(
            LastName = 'eTran Contact',
            AccountId = indivIdual.Id,
            FirstName='test',
            phone = '8905219766',
            //OwnershipPercentage__c = 100,
            LLC_BI__Home_Address__c='test',
            LLC_BI__Home_City__c='test',
            LLC_BI__Home_State__c='test',
            LLC_BI__Home_Zipcode__c='test',
            LLC_BI__Primary_Contact__c = true
        );
        insert contact;
        
        LLC_BI__Branch__c pcg = new LLC_BI__Branch__c(Name = 'Test PCG', LLC_BI__Branch_Id__c = 'Test Id', LLC_BI__lookupKey__c ='asaa76453', LLC_BI__State__c ='AK');
        insert pcg;
        
        LLC_BI__Product_Package__c productPackge = new LLC_BI__Product_Package__c(LLC_BI__Account__c = business.Id, Name = 'Test Product Package', CF_Line_Of_Business__c = 'SBA');
        insert productPackge;
        
        LLC_BI__Loan__c loan = new LLC_BI__Loan__c(
            Name = 'eTran Loan',
            LLC_BI__Application__c = application.Id,
            LLC_BI__Account__c = business.Id,
            LLC_BI__Amount__c=10000,
            LLC_BI__Amortized_Term_Months__c=24,
            LLC_BI__InterestRate__c=0.05,
            LLC_BI__SBA_Guarantee__c=1,
            LLC_BI__Monthly_Payment__c=500,
            LLC_BI__Rate_Ceiling__c = 0.10,
            LLC_BI__Rate_Floor__c = 0.005,
            LLC_BI__Interest_Rate_Adjustment_Frequency__c='Annual',
            LLC_BI__Product_Package__c = productPackge.Id);
        insert loan;
        
        LLC_BI__Legal_Entities__c legalEntityBorrower = new LLC_BI__Legal_Entities__c(LLC_BI__Account__c = business.Id, LLC_BI__Loan__c = loan.Id, LLC_BI__Borrower_Type__c = 'Borrower');
        insert legalEntityBorrower;
        //LLC_BI__Legal_Entities__c legalEntityIndi = new LLC_BI__Legal_Entities__c(LLC_BI__Account__c = indivIdual1.Id, LLC_BI__Loan__c = loan.Id);
        //insert legalEntityIndi;
        
        nSBA__Use_Of_Proceeds__c uop = new nSBA__Use_Of_Proceeds__c(
            nSBA__Proceed_Type_Code__c = '1',
            nSBA__Loan_Proceed_Type_Code__c = 'A',
            nSBA__Proceed_Amount__c = 10000.00,
            nSBA__Proceed_Other_Type_Text__c = 'Soem test',
            nSBA__Purchase_Agreement_Date__c = System.today(),
            nSBA__Application__c = application.Id);
        insert uop;
        
		//New code for coverage
        List<nSBA__Injections__c> listOfInjectionRecord = new List<nSBA__Injections__c>();
        nSBA__Injections__c inj1 = new nSBA__Injections__c(
            nSBA__Injection_Other_Description__c = 'Some Test',
            nSBA__Injection_Type_Code__c = '9',
            nSBA__Application__c = application.Id);
            listOfInjectionRecord.add(inj1);
           
        nSBA__Injections__c inj2 = new nSBA__Injections__c(
            nSBA__Injection_Other_Description__c = 'Some Test',
            nSBA__Injection_Type_Code__c = '7',
            nSBA__Application__c = application.Id);
            listOfInjectionRecord.add(inj2);
        
         nSBA__Injections__c inj5 = new nSBA__Injections__c(
            nSBA__Injection_Other_Description__c = 'Some Test',
            nSBA__Injection_Type_Code__c = '4',
            nSBA__Application__c = application.Id);
            listOfInjectionRecord.add(inj5);
        
         nSBA__Injections__c inj3 = new nSBA__Injections__c(
            nSBA__Injection_Other_Description__c = 'Some Test',
            nSBA__Injection_Type_Code__c = '5',
            nSBA__Application__c = application.Id);
            listOfInjectionRecord.add(inj3);
        
         nSBA__Injections__c inj4 = new nSBA__Injections__c(
            nSBA__Injection_Other_Description__c = 'Some Test',
            nSBA__Injection_Type_Code__c = '6',
            nSBA__Application__c = application.Id);
            listOfInjectionRecord.add(inj4);
        
        nSBA__Injections__c inj6 = new nSBA__Injections__c(
            nSBA__Injection_Other_Description__c = 'Some Test',
            nSBA__Injection_Type_Code__c = '3',
            nSBA__Application__c = application.Id);
            listOfInjectionRecord.add(inj6);
        
        nSBA__Injections__c inj7 = new nSBA__Injections__c(
            nSBA__Injection_Other_Description__c = 'Some Test',
            nSBA__Injection_Type_Code__c = '2',
            nSBA__Application__c = application.Id);
            listOfInjectionRecord.add(inj7);
        
        nSBA__Injections__c inj8 = new nSBA__Injections__c(
            nSBA__Injection_Other_Description__c = 'Some Test',
            nSBA__Injection_Type_Code__c = '1',
            nSBA__Application__c = application.Id);
            listOfInjectionRecord.add(inj8);
        insert listOfInjectionRecord;
      //  insert inj;
        
        nSBA__Unavailable_Credit_Information__c uci = new nSBA__Unavailable_Credit_Information__c(
            nSBA__Reason_Code__c = '1',
            nSBA__Reason_Comment__c= 'Some Text',
            nSBA__Associated_Loan_Application__c = application.Id);
        insert uci;
        
        List<nSBA__Change_Of_Ownership__c> changeOfOwnershipList = new List<nSBA__Change_Of_Ownership__c>();
        nSBA__Change_Of_Ownership__c coo1 = new nSBA__Change_Of_Ownership__c(nSBA__Broker_Commission__c = 50,nSBA__Application__c = application.Id, nSBA__Total_Other_Assets__c = 100.05);
        changeOfOwnershipList.add(coo1);
        
        nSBA__Change_Of_Ownership__c coo2 = new nSBA__Change_Of_Ownership__c(nSBA__Broker_Commission__c = 50,nSBA__Application__c = application.Id, nSBA__Total_Other_Assets__c = 100.05, nSBA__Non_Complete_Value__c = 50.05);
        changeOfOwnershipList.add(coo2);
        
        nSBA__Change_Of_Ownership__c coo3 = new nSBA__Change_Of_Ownership__c(nSBA__Broker_Commission__c = 50,nSBA__Application__c = application.Id, nSBA__Total_Other_Assets__c = 0.0);
        changeOfOwnershipList.add(coo3);
        
        nSBA__Change_Of_Ownership__c coo4 = new nSBA__Change_Of_Ownership__c(nSBA__Broker_Commission__c = 50,nSBA__Application__c = application.Id);
        changeOfOwnershipList.add(coo4);
        
        insert changeOfOwnershipList;
      //  insert coo;
        
        LLC_BI__Collateral_Type__c testCollateralType = new LLC_BI__Collateral_Type__c(Name = 'Test Collateral Type',LLC_BI__Advance_Rate__c = 0.4);
        insert testCollateralType;
        
        LLC_BI__Collateral__c testCollateral = new LLC_BI__Collateral__c();
        testCollateral.RecordTypeId = Schema.SObjectType.LLC_BI__Collateral__c.getRecordTypeInfosByDeveloperName().get('Collateral_Mgmt_UCC').getRecordTypeId();
        testCollateral.LLC_BI__Life_Insurance_Policy_Number__c = '1234567890';
        testCollateral.LLC_BI__Collateral_Type__c = testCollateralType.Id;
        insert testCollateral;
        
        LLC_BI__Loan_Collateral_Aggregate__c testLCA = new LLC_BI__Loan_Collateral_Aggregate__c();
        insert testLCA;
        
        LLC_BI__Loan_Collateral2__c testCollateralPledged = new LLC_BI__Loan_Collateral2__c();
        testCollateralPledged.LLC_BI__Loan__c = loan.Id;
        testCollateralPledged.LLC_BI__Collateral__c = testCollateral.Id;
        testCollateralPledged.LLC_BI__Loan_Collateral_Aggregate__c = testLCA.Id;
        insert testCollateralPledged;
    }
    
    @isTest
    public static voId testOrigScore() {
        
        LLC_BI__Application__c application = [SELECT ID, nPortal__Artifact_Id__c FROM LLC_BI__Application__c WHERE nPortal__Artifact_Id__c = 'eTran Application'];
        system.assertEquals('eTran Application', application.nPortal__Artifact_Id__c);   
        Contact con = [Select Id from Contact limit 1];
        con.phone = '1234567890';
        con.LLC_BI__Primary_Contact__c = true;
        update con;
        
        Test.setMock(HttpCalloutMock.class, new etranOrigScore());
        WS_eTranServiceInvocableRequest input = new WS_eTranServiceInvocableRequest();
        input.appId = application.Id;
        input.method = 'OrigScore';
        test.startTest();
        
        WS_eTranService service1 = new WS_eTranService();
        service1.input = input;
        service1.main();
        
        test.stopTest();
    }    
        // Newly Added Method
 /*   @isTest
    public static voId testOrigScore1() {
        
        
        LLC_BI__Application__c application = [SELECT ID, nPortal__Artifact_Id__c FROM LLC_BI__Application__c WHERE nPortal__Artifact_Id__c = 'eTran Application'];
        system.assertEquals('eTran Application', application.nPortal__Artifact_Id__c);   
        Contact con = [Select Id from Contact limit 1];
        con.phone = '1234567890';
        con.LLC_BI__Primary_Contact__c = true;
        update con;
        
       Test.setMock(HttpCalloutMock.class, new etranOrigScore());
        
     //   test.startTest();
        WS_eTranServiceInvocableRequest input = new WS_eTranServiceInvocableRequest();
      //  input.appId = application.Id;
     //   input.method = 'OrigScore';
       
        test.startTest();
        
        WS_eTranService service1 = new WS_eTranService();
        service1.input = input;
        service1.main();
        
        test.stopTest();
    }
    */
    @isTest
    public static voId testResponse() {
        
        String json='{"AuthErrorNmb":"0","AuthErrorText":"Login Successful.","Synopsis":["TestData","TestData2"],"App":[{"LoanAppNmb":"429404","Results":{"LoanAppNm":"Antonio Cable Corporation","LoanAppRqstAmt":"$700,000.00","LoanAppPrtLoanNmb":"","LoanAppPrtAppNmb":"a3J590000008PRrEAM","LoanAppRecvDt":"08/04/2021 07:10:30","LoanAppEtranEmailAdr":"shruthi.aipanjiguli@unionbank.com","LoanAppAppvDt":"08/04/2021 07:11:55","LoanAppSBAAppvAmt":"$700,000.00","LoanNmb":"8971795004","LoanGntyFeeAmt":"$25,850.00","LoanGntyFeeExplainTxt":"","LoanGntyPercent":"90","LoanAppFundDt":"2021-08-04 07:11:55.055","LoanAppStatCd":"FD","BusDUNSNmb":"NO-REPORT","LiquIdCreditScore":""}}]}';
        test.startTest();
        
        WS_eTranServiceResponseWrapper resWrap = new WS_eTranServiceResponseWrapper();
        resWrap.ResponseData = json;
        resWrap.responseDataObject = resWrap.deserializeResponseData();
        resWrap.getSynopsis();
        resWrap.getApplicationNumber();
        system.assertEquals('429404', resWrap.getApplicationNumber());  
        resWrap.getErrors();
        resWrap.getResponseResults();
        test.stopTest();
    }
    
    @isTest
    public static voId testResponseErro() {
        LLC_BI__Application__c application = [SELECT ID, nPortal__Artifact_Id__c FROM LLC_BI__Application__c WHERE nPortal__Artifact_Id__c = 'eTran Application'];
        system.assertEquals('eTran Application', application.nPortal__Artifact_Id__c);   
        
        String ErrorJson='';
        test.startTest();
        
        WS_eTranServiceResponseWrapper resWrap = new WS_eTranServiceResponseWrapper();
        resWrap.ResponseData = ErrorJson;
        resWrap.responseDataObject = resWrap.deserializeResponseData();
        resWrap.getSynopsis();
        resWrap.getApplicationNumber();
        resWrap.getErrors();
        resWrap.getResponseResults();
        
        test.stopTest();
    }
    
    @isTest
    public static voId testResponseErroV2() {
        LLC_BI__Application__c application = [SELECT ID, nPortal__Artifact_Id__c FROM LLC_BI__Application__c WHERE nPortal__Artifact_Id__c = 'eTran Application'];
        system.assertEquals('eTran Application', application.nPortal__Artifact_Id__c);   
        
        String json='{"AuthErrorNmb":"0","AuthErrorText":"Login Successful.","Synopsis":["TestData","TestData2"]}';
        test.startTest();
        
        WS_eTranServiceResponseWrapper resWrap = new WS_eTranServiceResponseWrapper();
        resWrap.ResponseData = json;
        resWrap.responseDataObject = resWrap.deserializeResponseData();
        resWrap.getErrors();
        test.stopTest();
    }
    
    @isTest
    public static voId testOrigUpdate() {
        
        LLC_BI__Application__c application = [SELECT ID, nPortal__Artifact_Id__c FROM LLC_BI__Application__c WHERE nPortal__Artifact_Id__c = 'eTran Application'];
        system.assertEquals('eTran Application', application.nPortal__Artifact_Id__c);   
        
        test.startTest();
        Test.setMock(HttpCalloutMock.class, new etranOrigScore());
        WS_eTranServiceInvocableRequest input = new WS_eTranServiceInvocableRequest();
        input.appId = application.Id;
        input.method = 'OrigUpdate';
        
        list<WS_eTranServiceInvocableResponse> outputs = WS_eTranServiceInvocable.main(new list<WS_eTranServiceInvocableRequest>{input});
        
        test.stopTest();
    }
    
    @isTest
    public static voId testValIdateInput() { 
        list<String> fields = new list<string>{'Name','Type'};
            WS_eTranServiceInvocableResponse output = new WS_eTranServiceInvocableResponse();
        Account a = new Account(Name='Test');
        system.assertEquals('Test', a.name);  
        WS_eTranServiceHelper.valIdateInput('Account',a, fields, output,'Please navigate to Etran Required Fields route and populate the required fields.','Navigate');
    }
    
    @isTest
    public static voId testEtranObjectUpload() { 
        test.startTest();
          WS_eTranObjectUpload.SharedEntryPointResponse_element testInsta =new WS_eTranObjectUpload.SharedEntryPointResponse_element();
        test.stopTest();
         
    }
    
   @isTest
    public static voId testEtranServiceResponseWrapper() { 
        test.startTest();
          WS_eTranServiceResponseWrapper.ResponseData testInsta =new WS_eTranServiceResponseWrapper.ResponseData();
        test.stopTest();
         
    } 
    
    //Test class for WS_eTranTwofactorAuth
    @isTest
    public static voId testEtranTwoFactorAuth() { 
        EtranCredential__c etran = new EtranCredential__c();
        etran.TECH_CLSUsername__c = 'TestUserName';
        etran.TECH_CLSPassword__c = 'TestPassword';
        etran.TECH_SFUsername__c = userinfo.getUserName();
        insert etran;
        system.assertEquals('TestUserName', etran.TECH_CLSUsername__c);
        LLC_BI__Loan__c loan = [SELECT Id FROM LLC_BI__Loan__c LIMIT 1];
        test.startTest();
        Test.setMock(HttpCalloutMock.class, new etranTwoFactorAuth());
        WS_eTranServiceInvocableRequest input = new WS_eTranServiceInvocableRequest();
        input.appId = loan.Id;
        input.method = '';
        WS_eTranTwofactorAuth.pinCallout(new List<WS_eTranServiceInvocableRequest>{input});
        test.stopTest();
        //system.assert(output.errors != null);
    }
    
    public class etranTwoFactorAuth implements HttpCalloutMock{
        public HttpResponse respond(HTTPRequest req){
            HttpResponse res = new HttpResponse();
            res.setStatus('Success');
            res.setStatusCode(200);
            res.setBody('{"ErrorMessageTechnical":"","PINForAppToAppUsersOnly":"","Trace":"Trace: AuthFROMStruct, REST, bef pre, aft pre Yes, have user info, have user info, have calc parms, have pin, pin saved, sent E, sent S, done.","ResponseData":"Please check your email and/or cell phone to retrieve the PIN. ","Successful":"Yes","ErrorMessageEnglish":"","PINEXPIRATIONDATE":"July, 01 2021 01:56:40"}');
            return res;
        }
    }
    
    public class etranObjectUploadMock implements HttpCalloutMock{
        public HttpResponse respond(HTTPRequest req){
            HttpResponse res = new HttpResponse();
            res.setStatus('Success');
            res.setStatusCode(200);
            res.setBody('Map_x:[apex_schema_type_info=(http://xml.apache.org/xml-soap, true, false), field_order_type_info=(item), item=(mapItem:[apex_schema_type_info=(http://xml.apache.org/xml-soap, true, false), field_order_type_info=(key, value), key=ErrorMessageTechnical, key_type_info=(key, http://xml.apache.org/xml-soap, null, 1, 1, true), value=, value_type_info=(value, http://xml.apache.org/xml-soap, null, 1, 1, true)], mapItem:[apex_schema_type_info=(http://xml.apache.org/xml-soap, true, false), field_order_type_info=(key, value), key=PasswordUpdateRequired, key_type_info=(key, http://xml.apache.org/xml-soap, null, 1, 1, true), value=No, value_type_info=(value, http://xml.apache.org/xml-soap, null, 1, 1, true)], mapItem:[apex_schema_type_info=(http://xml.apache.org/xml-soap, true, false), field_order_type_info=(key, value), key=ResponseData, key_type_info=(key, http://xml.apache.org/xml-soap, null, 1, 1, true), value=<SBA_Etran_Response>'+
                        '<Synopsis>Synopsis of Document Upload: File successfully uploaded. User Logged in,User role permitted,ValId user for this system,file written to DB</Synopsis>'+
                        '<App LoanAppNmb="428361">'+
                        '<Results>'+
                        '<DocumentName>Exposure.PNG</DocumentName>'+
                        '<DocumentSize>  0.09MB</DocumentSize>'+
                        '<LoanAppNm>Digital Arts &amp; Design</LoanAppNm>'+
                        '<LoanAppRqstAmt>10000</LoanAppRqstAmt>'+
                        '<LoanAppSBAGntyPct>25.000</LoanAppSBAGntyPct>'+
                        '<LoanGntyFeeAmt>37.5</LoanGntyFeeAmt>'+
                        '<LoanAppNmb>428361</LoanAppNmb>'+
                        '<PrcsMethodText>SBA Express Program</PrcsMethodText>'+
                        '</Results>'+
                        '</App>'+
                        '</SBA_Etran_Response>'+
                        ', value_type_info=(value, http://xml.apache.org/xml-soap, null, 1, 1, true)], mapItem:[apex_schema_type_info=(http://xml.apache.org/xml-soap, true, false), field_order_type_info=(key, value), key=ErrorMessageEnglish, key_type_info=(key, http://xml.apache.org/xml-soap, null, 1, 1, true), value=, value_type_info=(value, http://xml.apache.org/xml-soap, null, 1, 1, true)]), item_type_info=(item, http://xml.apache.org/xml-soap, null, 0, -1, false)]');
            return res;
        }
    }
    
 /*   public class etranOrigScore implements HttpCalloutMock{
        public HttpResponse respond(HTTPRequest req){
            HttpResponse res = new HttpResponse();
            res.setStatus('Success');
            res.setStatusCode(200);
            res.setBody('{"ErrorMessageTechnical":"","PasswordUpdateRequired":"13","ErrorMessageEnglish":"","ResponseData":"{\"AuthErrorNmb\":\"0\",\"AuthErrorText\":\"Login Successful.\",\"Synopsis\":[\"TestData","TestData2\"],\"App\":[{\"LoanAppNmb\":\"429404\",\"Results\":{\"LoanAppNm\":\"Antonio Cable Corporation\",\"LoanAppRqstAmt\":\"$700,000.00\",\"LoanAppPrtLoanNmb\":\"\",\"LoanAppPrtAppNmb\":\"a3J590000008PRrEAM\",\"LoanAppRecvDt\":\"08/04/2021 07:10:30\",\"LoanAppEtranEmailAdr\":\"shruthi.aipanjiguli@unionbank.com\",\"LoanAppAppvDt\":\"08/04/2021 07:11:55\",\"LoanAppSBAAppvAmt\":\"$700,000.00\",\"LoanNmb\":\"8971795004\",\"LoanGntyFeeAmt\":\"$25,850.00\",\"LoanGntyFeeExplainTxt\":\"\",\"LoanGntyPercent\":\"90\",\"LoanAppFundDt\":\"2021-08-04 07:11:55.055\",\"LoanAppStatCd\":\"FD\",\"BusDUNSNmb\":\"NO-REPORT\",\"LiquIdCreditScore\":\"\"}}]}"}');
            return res;
        }
    }
*/
    public class etranOrigScore implements HttpCalloutMock{
        public HttpResponse respond(HTTPRequest req){
            HttpResponse res = new HttpResponse();
            res.setStatus('Success');
            res.setStatusCode(200);
           res.setBody('{"ErrorMessageTechnical":"","PasswordUpdateRequired":"No","ErrorMessageEnglish":"","ResponseData":"{\"AuthErrorNmb\":\"0\",\"AuthErrorText\":\"Login Successful.\",\"Synopsis\":[\"Synopsis of OrigScore Web Service (XML) processing, SBA TEST DATABASE:\",\"The file was of acceptable size and type, so it was accepted by the SBAs server.\",\"LoanAppETranSeqNmb :861212. It was saved to the SBA database as a transaction history.\",\"It \\\"deserialized\\\" correctly, which allowed its 1 loan application(s) to be processed.\",\"Processing application 1 of 1 in the file.\",\"Passed \\\"presave validation\\\".\",\"Saved to SBA test database as application number 431698.\",\"Status set to Awaiting Reviewer Assignment.\",\"Not validated, as requested.\",\"Most recent credit score on file for this app"],\"App\":[{\"LoanAppNmb\":\"431698\",\"Results\":{\"LoanAppNm\":\"TESTBUS97\",\"LoanAppRqstAmt\":\"$250,000.00\",\"LoanAppPrtLoanNmb\":\"\",\"LoanAppPrtAppNmb\":\"a0i750000004glEAAQ\",\"LoanAppRecvDt\":\"\",\"LoanAppEtranEmailAdr\":\"bikku.kumar.sharma@pwc.com\",\"LoanAppAppvDt\":\"\",\"LoanAppSBAAppvAmt\":\"\",\"LoanNmb\":\"\",\"LoanGntyFeeAmt\":\"\",\"LoanGntyFeeExplainTxt\":\"\",\"LoanGntyPercent\":\"75\",\"LoanAppFundDt\":\"\",\"LoanAppStatCd\":\"IP\",\"BusDUNSNmb\":\"804735132\",\"LiquidCreditScore\":\"\"}}]}"}');
            return res;
        }
    }
    @isTest
    public static voId testEtranDocumentUpload() { 
        LLC_BI__Loan__c loan = [SELECT Id, LLC_BI__Product_Package__c, name  FROM LLC_BI__Loan__c WHERE name='eTran Loan' LIMIT 1];
        system.assertEquals('eTran Loan', loan.name);
        LLC_BI__Application__c app = [SELECT Id FROM LLC_BI__Application__c LIMIT 1];
        Account account = [SELECT Id FROM Account WHERE name ='eTran Business' LIMIT 1];
        LLC_BI__Collateral__c collateral = [SELECT Id FROM LLC_BI__Collateral__c LIMIT 1];
        
        LLC_BI__DocManager__c DocManager = new LLC_BI__DocManager__c(Name='llc_bi__loan__c',LLC_BI__namespacePrefix__c='LLC_BI');
        insert DocManager;
        
        LLC_BI__DocManager__c DocManager1 = new LLC_BI__DocManager__c(Name='Account',LLC_BI__namespacePrefix__c='LLC_BI');
        insert DocManager1;
        
        LLC_BI__DocManager__c DocManager2 = new LLC_BI__DocManager__c(Name='Document',LLC_BI__namespacePrefix__c='LLC_BI');
        insert DocManager2;
        
        LLC_BI__DocType__c docType = new LLC_BI__DocType__c(Name = 'Loan Forgiveness Portal Documents', LLC_BI__docManager__c = DocManager.Id);
        insert docType;
        
        LLC_BI__DocType__c docType1 = new LLC_BI__DocType__c(Name = 'Loan Forgiveness Portal Documents',LLC_BI__docManager__c = DocManager1.Id);
        insert docType1;
        
        LLC_BI__DocType__c docType2 = new LLC_BI__DocType__c( Name = 'Loan Forgiveness Portal Documents',LLC_BI__docManager__c = DocManager2.Id);
        insert docType2;
        
        LLC_BI__ClosingChecklist__c closingCheckListRec=new LLC_BI__ClosingChecklist__c(Name = 'Loan Forgiveness Portal Documents',LLC_BI__docType__c=docType.Id);
        insert closingCheckListRec;
        
        LLC_BI__ClosingChecklist__c closingCheckListRec1=new LLC_BI__ClosingChecklist__c(Name = 'Loan Forgiveness Portal Documents',LLC_BI__docType__c=docType1.Id);
        insert closingCheckListRec1;
        
        LLC_BI__ClosingChecklist__c closingCheckListRec2=new LLC_BI__ClosingChecklist__c(Name = 'Loan Forgiveness Portal Documents',LLC_BI__docType__c=docType2.Id);
        insert closingCheckListRec2;
        
        LLC_BI__LLC_LoanDocument__c loanDocument=new LLC_BI__LLC_LoanDocument__c();
        loanDocument.LLC_BI__Loan__c=loan.Id;
        loanDocument.Name='testPPPLoanDoc';
        loanDocument.LLC_BI__DocType__c=docType.Id;
        loanDocument.LLC_BI__Loan__c = loan.Id;
        loanDocument.LLC_BI__closingChecklist__c = closingCheckListRec.Id;
        loanDocument.EtranDocStatus__c = 'Ready for eTran';
        loanDocument.NDOC__fileName__c = 'TestFile';
        insert loanDocument;  
        
        LLC_BI__AccountDocument__c accountDoument = new LLC_BI__AccountDocument__c();
        accountDoument.LLC_BI__Account__c = account.Id;
        accountDoument.Name = 'test7AGAccountDoc';
        accountDoument.LLC_BI__DocType__c=docType1.Id;
        accountDoument.NDOC__Closing_Checklist__c = closingCheckListRec1.Id;
        accountDoument.EtranDocStatus__c = 'Ready for eTran';
        accountDoument.NDOC__fileName__c = 'TestFile23';
        insert accountDoument ;
        
        
        LLC_BI__Document_Store__c docStore= new LLC_BI__Document_Store__c(LLC_BI__Ready_For_Esignature__c = true);
        insert docStore;
        
        LLC_BI__Document_Store_Index__c  docIndex = new LLC_BI__Document_Store_Index__c(LLC_BI__Document_Store__c = docStore.Id);
        insert docIndex;
        
        LLC_BI__Document_Placeholder__c docPlaceholder = new LLC_BI__Document_Placeholder__c();
        docPlaceholder.NDOC__Account__c = account.Id;
        docPlaceholder.LLC_BI__External_Id__c = loan.LLC_BI__Product_Package__c;
        docPlaceholder.name = 'Test7AGDocument';
        docPlaceholder.LLC_BI__DocType__c=docType2.Id;
        docPlaceholder.LLC_BI__Closing_Checklist__c = closingCheckListRec2.Id;
        docPlaceholder.EtranDocStatus__c = 'Ready for eTran';
        docPlaceholder.NDOC__File_Name__c = 'TestFile332';
        docPlaceholder.NDOC__Collateral_Mgmt__c = collateral.Id;
        docPlaceholder.LLC_BI__Document_Store_Index__c = docIndex.Id;
        insert docPlaceholder; 
        
        ContentVersion contentVersionInsert = new ContentVersion(Title = 'Test',PathOnClient = 'Test.jpg',VersionData = Blob.valueOf('Test Content Data'),IsMajorVersion = true);
        insert contentVersionInsert;
        
        ContentVersion contentVersionInsert1 = new ContentVersion(Title = 'Test1',PathOnClient = 'Test1.jpg',VersionData = Blob.valueOf('Test Content Data'),IsMajorVersion = true);
        insert contentVersionInsert1;
        
        ContentVersion contentVersionInsert2 = new ContentVersion(Title = 'Test12',PathOnClient = 'Test12.jpg',VersionData = Blob.valueOf('Test Content Data'),IsMajorVersion = true);
        insert contentVersionInsert2;
        
        // Test INSERT
        ContentVersion contentVersionSELECT = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Id = :contentVersionInsert.Id LIMIT 1];
        ContentVersion contentVersionSELECT1 = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Id = :contentVersionInsert1.Id LIMIT 1];
        ContentVersion contentVersionSELECT2 = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Id = :contentVersionInsert2.Id LIMIT 1];
        
        loanDocument.LLC_BI__attachmentId__c=contentVersionSELECT.ContentDocumentId;
        loanDocument.LLC_BI__reviewStatus__c = 'Approved';
        update loanDocument;
        
        accountDoument.LLC_BI__attachmentId__c = contentVersionSELECT1.ContentDocumentId;
        accountDoument.LLC_BI__reviewStatus__c = 'Approved';
        update accountDoument;
        
        docPlaceholder.NDOC__Attachment_Id__c = contentVersionSELECT2.ContentDocumentId;
        docPlaceholder.LLC_BI__Review_Status__c = 'Approved';
        update docPlaceholder; 
        
        EtranCredential__c etran = new EtranCredential__c(TECH_CLSUsername__c = 'TestUserName',TECH_CLSPassword__c = 'TestPassword', TECH_SFUsername__c = userinfo.getUserName());
        insert etran;
        
        test.startTest();
        Test.setMock(HttpCalloutMock.class, new etranObjectUploadMock());
        WS_eTranServiceInvocableRequest input = new WS_eTranServiceInvocableRequest();
        input.appId = app.Id;
        input.method = 'LoanApp';
        // Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        WS_etranDocumentUploadHelper.main(new List<WS_eTranServiceInvocableRequest>{input});
        test.stopTest();
    }
    
    // To increase code coverage Jayanth 07/22/22
        @isTest
    public static voId testEtranDocumentUploadException() { 
        LLC_BI__Loan__c loan = [SELECT Id, LLC_BI__Product_Package__c, name  FROM LLC_BI__Loan__c WHERE name='eTran Loan' LIMIT 1];
        system.assertEquals('eTran Loan', loan.name);
        LLC_BI__Application__c app = [SELECT Id FROM LLC_BI__Application__c LIMIT 1];
        Account account = [SELECT Id FROM Account WHERE name ='eTran Business' LIMIT 1];
        LLC_BI__Collateral__c collateral = [SELECT Id FROM LLC_BI__Collateral__c LIMIT 1];
        
        LLC_BI__DocManager__c DocManager = new LLC_BI__DocManager__c(Name='llc_bi__loan__c',LLC_BI__namespacePrefix__c='LLC_BI');
        insert DocManager;
        
        LLC_BI__DocManager__c DocManager1 = new LLC_BI__DocManager__c(Name='Account',LLC_BI__namespacePrefix__c='LLC_BI');
        insert DocManager1;
        
        LLC_BI__DocManager__c DocManager2 = new LLC_BI__DocManager__c(Name='Document',LLC_BI__namespacePrefix__c='LLC_BI');
        insert DocManager2;
        
        LLC_BI__DocType__c docType = new LLC_BI__DocType__c(Name = 'Loan Forgiveness Portal Documents', LLC_BI__docManager__c = DocManager.Id);
        insert docType;
        
        LLC_BI__DocType__c docType1 = new LLC_BI__DocType__c(Name = 'Loan Forgiveness Portal Documents',LLC_BI__docManager__c = DocManager1.Id);
        insert docType1;
        
        LLC_BI__DocType__c docType2 = new LLC_BI__DocType__c( Name = 'Loan Forgiveness Portal Documents',LLC_BI__docManager__c = DocManager2.Id);
        insert docType2;
        
        LLC_BI__ClosingChecklist__c closingCheckListRec=new LLC_BI__ClosingChecklist__c(Name = 'Loan Forgiveness Portal Documents',LLC_BI__docType__c=docType.Id);
        insert closingCheckListRec;
        
        LLC_BI__ClosingChecklist__c closingCheckListRec1=new LLC_BI__ClosingChecklist__c(Name = 'Loan Forgiveness Portal Documents',LLC_BI__docType__c=docType1.Id);
        insert closingCheckListRec1;
        
        LLC_BI__ClosingChecklist__c closingCheckListRec2=new LLC_BI__ClosingChecklist__c(Name = 'Loan Forgiveness Portal Documents',LLC_BI__docType__c=docType2.Id);
        insert closingCheckListRec2;
        
        LLC_BI__LLC_LoanDocument__c loanDocument=new LLC_BI__LLC_LoanDocument__c();
        loanDocument.LLC_BI__Loan__c=loan.Id;
        loanDocument.Name='testPPPLoanDoc';
        loanDocument.LLC_BI__DocType__c=docType.Id;
        loanDocument.LLC_BI__Loan__c = loan.Id;
        loanDocument.LLC_BI__closingChecklist__c = closingCheckListRec.Id;
        loanDocument.EtranDocStatus__c = 'Ready for eTran';
        loanDocument.NDOC__fileName__c = 'TestFile';
        insert loanDocument;  
        
        LLC_BI__AccountDocument__c accountDoument = new LLC_BI__AccountDocument__c();
        accountDoument.LLC_BI__Account__c = account.Id;
        accountDoument.Name = 'test7AGAccountDoc';
        accountDoument.LLC_BI__DocType__c=docType1.Id;
        accountDoument.NDOC__Closing_Checklist__c = closingCheckListRec1.Id;
        accountDoument.EtranDocStatus__c = 'Ready for eTran';
        accountDoument.NDOC__fileName__c = 'TestFile23';
        insert accountDoument ;
        
        
        LLC_BI__Document_Store__c docStore= new LLC_BI__Document_Store__c(LLC_BI__Ready_For_Esignature__c = true);
        insert docStore;
        
        LLC_BI__Document_Store_Index__c  docIndex = new LLC_BI__Document_Store_Index__c(LLC_BI__Document_Store__c = docStore.Id);
        insert docIndex;
        
        LLC_BI__Document_Placeholder__c docPlaceholder = new LLC_BI__Document_Placeholder__c();
        docPlaceholder.NDOC__Account__c = account.Id;
        docPlaceholder.LLC_BI__External_Id__c = loan.LLC_BI__Product_Package__c;
        docPlaceholder.name = 'Test7AGDocument';
        docPlaceholder.LLC_BI__DocType__c=docType2.Id;
        docPlaceholder.LLC_BI__Closing_Checklist__c = closingCheckListRec2.Id;
        docPlaceholder.EtranDocStatus__c = 'Ready for eTran';
        docPlaceholder.NDOC__File_Name__c = 'TestFile332';
        docPlaceholder.NDOC__Collateral_Mgmt__c = collateral.Id;
        docPlaceholder.LLC_BI__Document_Store_Index__c = docIndex.Id;
        insert docPlaceholder; 
        
        ContentVersion contentVersionInsert = new ContentVersion(Title = 'Test',PathOnClient = 'Test.jpg',VersionData = Blob.valueOf('Test Content Data'),IsMajorVersion = true);
        insert contentVersionInsert;
        
        ContentVersion contentVersionInsert1 = new ContentVersion(Title = 'Test1',PathOnClient = 'Test1.jpg',VersionData = Blob.valueOf('Test Content Data'),IsMajorVersion = true);
        insert contentVersionInsert1;
        
        ContentVersion contentVersionInsert2 = new ContentVersion(Title = 'Test12',PathOnClient = 'Test12.jpg',VersionData = Blob.valueOf('Test Content Data'),IsMajorVersion = true);
        insert contentVersionInsert2;
        
        // Test INSERT
        ContentVersion contentVersionSELECT = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Id = :contentVersionInsert.Id LIMIT 1];
        ContentVersion contentVersionSELECT1 = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Id = :contentVersionInsert1.Id LIMIT 1];
        ContentVersion contentVersionSELECT2 = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Id = :contentVersionInsert2.Id LIMIT 1];
        
        loanDocument.LLC_BI__attachmentId__c=contentVersionSELECT.ContentDocumentId;
        loanDocument.LLC_BI__reviewStatus__c = 'Approved';
        update loanDocument;
        
        accountDoument.LLC_BI__attachmentId__c = contentVersionSELECT1.ContentDocumentId;
        accountDoument.LLC_BI__reviewStatus__c = 'Approved';
        update accountDoument;
        
        docPlaceholder.NDOC__Attachment_Id__c = contentVersionSELECT2.ContentDocumentId;
        docPlaceholder.LLC_BI__Review_Status__c = 'Approved';
        update docPlaceholder; 
        
        EtranCredential__c etran = new EtranCredential__c(TECH_CLSUsername__c = 'TestUserName',TECH_CLSPassword__c = 'TestPassword', TECH_SFUsername__c = userinfo.getUserName());
        insert etran;
        
        test.startTest();
        Test.setMock(HttpCalloutMock.class, new etranObjectUploadMock());
        WS_eTranServiceInvocableRequest input = new WS_eTranServiceInvocableRequest();
        input.appId = app.Id;
        input.method = 'LoanApp';
        
        WS_etranDocumentUploadHelper.main(new List<WS_eTranServiceInvocableRequest>{input});  // to produce exception
        test.stopTest();
    }
    
}