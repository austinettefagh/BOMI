/** 
* This is get cancel loan Test class
* Date               User               Change 
* 8/20/2021          PwC               Initial Version
* 
* This is test class for WS_eTranCancelLoan class.
*/
@isTest
public without sharing class WS_eTranCancelLoanTest {
    @TestSetup
    static void makeData(){
        
        EtranCredential__c etran = new EtranCredential__c();
        etran.TECH_CLSUsername__c = 'TestUserName';
        etran.TECH_CLSPassword__c = 'TestPassword';
        etran.TECH_SFUsername__c = userinfo.getUserName();
        insert etran;
        
        LLC_BI__Application__c application = new LLC_BI__Application__c(
            nPortal__Artifact_Id__c = 'eTran Application'
        );
        insert application;
        
        cm_Industry_Code__c naics = new cm_Industry_Code__c(Name = '112112 - Cattle Feedlots'); // Added by Jayanth (replaced E2E NAICS)
        insert naics;
        
        Account business = new Account(
            Name = 'eTran Business',
            BillingCity='test',
            BillingPostalCode='test',
            BillingState='test',
            BillingStreet='test',
           // LLC_BI__Tax_Identification_Number_PE__c = '134534234', //Jayanth commented
            Tax_ID__c = '494534234',
            nSBA__Prior_SBA_Loan__c=false,
            cm_Industry_Code__c = naics.Id,
            Select_Your_Business_Entity_Type__c ='LLC',
            NumberOfEmployees=200,
            Phone='123456789',
            ShippingCity='test',
            ShippingPostalCode='test1',
            ShippingState='test',
            ShippingStreet='test',
            Type='Corporation');
        insert business;
        Account individual = new Account(
            Name = 'eTran Individual',
            //E2E_Last_Name__c = 'Individual',
            Tax_ID__c ='445654567',
            recordtypeId = [Select Id From RecordType Where SobjectType = 'Account' And DeveloperName = 'IndivIdual' Limit 1].Id
        );
        insert individual;
        Contact contact = new Contact(
            LastName = 'eTran Contact',
            AccountId = individual.Id,
            FirstName='test',
            phone = '8905219766',
            //OwnershipPercentage__c = 100,
            LLC_BI__Home_Address__c='test',
            LLC_BI__Home_City__c='test',
            LLC_BI__Home_State__c='test',
            LLC_BI__Home_Zipcode__c='test'
        );
        insert contact;
        
        LLC_BI__Product_Package__c testCreditProfile = new LLC_BI__Product_Package__c();
        testCreditProfile.Name = 'Test Credit Profile';
        insert testCreditProfile;
        
        LLC_BI__Loan__c loan = new LLC_BI__Loan__c(
            Name = 'eTran Loan',
            LLC_BI__Product_Package__c = testCreditProfile.Id,
            LLC_BI__Application__c = application.Id,
            LLC_BI__Account__c = business.Id,
            LLC_BI__Amount__c=10000,
            LLC_BI__Amortized_Term_Months__c=24,
            LLC_BI__InterestRate__c=0.05,
            LLC_BI__SBA_Guarantee__c=1,
            LLC_BI__Monthly_Payment__c=500);
        insert loan;
        
        LLC_BI__Legal_Entities__c legalEntityBorrower = new LLC_BI__Legal_Entities__c(LLC_BI__Account__c = business.id, LLC_BI__Loan__c = loan.id);
        insert legalEntityBorrower;
        LLC_BI__Legal_Entities__c legalEntityIndi = new LLC_BI__Legal_Entities__c(LLC_BI__Account__c = individual.id, LLC_BI__Loan__c = loan.id);
        insert legalEntityIndi;
        
        nSBA__Use_Of_Proceeds__c uop = new nSBA__Use_Of_Proceeds__c(
            nSBA__Proceed_Type_Code__c = '1',
            nSBA__Loan_Proceed_Type_Code__c = 'A',
            nSBA__Proceed_Amount__c = 10000.00,
            nSBA__Proceed_Other_Type_Text__c = 'Soem test',
            nSBA__Purchase_Agreement_Date__c = System.today(),
            nSBA__Application__c = application.Id);
        insert uop;
        
        nSBA__Injections__c inj = new nSBA__Injections__c(
            nSBA__Injection_Other_Description__c = 'Some Test',
            nSBA__Injection_Type_Code__c = '9',
            nSBA__Application__c = application.Id);
        insert inj;
        
        nSBA__Unavailable_Credit_Information__c uci = new nSBA__Unavailable_Credit_Information__c(
            nSBA__Reason_Code__c = '1',
            nSBA__Reason_Comment__c= 'Some Text',
            nSBA__Associated_Loan_Application__c = application.Id);
        insert uci;
        
        nSBA__Change_Of_Ownership__c coo = new nSBA__Change_Of_Ownership__c(
            nSBA__Broker_Commission__c = 50,
            nSBA__Application__c = application.Id);
        insert coo;
        
        LLC_BI__Collateral_Type__c testCollateralType = new LLC_BI__Collateral_Type__c();
        testCollateralType.Name = 'Test Collateral Type';
        testCollateralType.LLC_BI__Advance_Rate__c = 0.4;
        insert testCollateralType;
        
        LLC_BI__Collateral__c testCollateral = new LLC_BI__Collateral__c();
        testCollateral.RecordTypeId = Schema.SObjectType.LLC_BI__Collateral__c.getRecordTypeInfosByDeveloperName().get('Collateral_Mgmt_UCC').getRecordTypeId();
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
    public static void testCancelLoan() {
        
        LLC_BI__Application__c application = [SELECT ID, nPortal__Artifact_Id__c FROM LLC_BI__Application__c WHERE nPortal__Artifact_Id__c = 'eTran Application'];
        system.assertEquals('eTran Application', application.nPortal__Artifact_Id__c);   
        Contact con = [Select Id from Contact limit 1];
        con.phone = '1234567890';
        update con;
        
        Test.setMock(HttpCalloutMock.class, new etranObjectUploadMock());
        WS_eTranServiceInvocableRequest input = new WS_eTranServiceInvocableRequest();
        input.appId = application.id;
        input.method = 'CancelLoan';
        test.startTest();
        
        WS_eTranCancelLoan.statusCallout(new List<WS_eTranServiceInvocableRequest>{input});
        
        test.stopTest();
    }
    
    public class etranObjectUploadMock implements HttpCalloutMock{
        public HttpResponse respond(HTTPRequest req){
            WS_eTranCancelLoanResponseWrapper wrap = new WS_eTranCancelLoanResponseWrapper();
            wrap.ErrorMessageTechnical = '';
            wrap.ErrorMessageEnglish = '';
            wrap.PasswordUpdateRequired = 'No';
            wrap.ResponseData = '{"AuthErrorNmb":"0","AuthErrorText":"Login Successful.",'+
                '"Synopsis":["Synopsis of Web Service (XML) processing, SBA TEST DATABASE:","The file was of acceptable size and type, so it was accepted by the SBAs server.","LoanETranSeqNmb :312039. It was saved to the SBAs database as a transaction history.","It deserialized correctly, which allowed its 1 loan servicing request(s) to be processed.","Failed presave validation. (Cannot be saved to the SBAs database.)"],'+
                '"SBALoan":[{"LoanAppNmb":"428281",'+
                '"Results":{"ResultInd":"F","LoanAppNm":"B-DNA","LoanNmb":"8963855009","LoanGntyFeeAmt":"","LoanGntyFeeExplainTxt":"","LoanGntyPercent":"22","LoanAppStatCd":""},'+
                '"Errors":["Errors occurred in loan 1 of 1:","ERROR. Loan is already cancelled."]}]}';
            String jsonrep = JSON.serialize(wrap);
            
            HttpResponse res = new HttpResponse();
            res.setStatus('Success');
            res.setStatusCode(200);
            res.setBody(jsonrep);
            return res;
        }
    }
    
    /*@isTest
    public static void testGetStatus() {
        
        LLC_BI__Application__c application = [SELECT ID, nPortal__Artifact_Id__c FROM LLC_BI__Application__c WHERE nPortal__Artifact_Id__c = 'eTran Application'];
        system.assertEquals('eTran Application', application.nPortal__Artifact_Id__c);   
        Contact con = [Select Id from Contact limit 1];
        con.phone = '1234567890';
        update con;
        
        Test.setMock(HttpCalloutMock.class, new etranGetStatusMock());
        WS_eTranServiceInvocableRequest input = new WS_eTranServiceInvocableRequest();
        input.appId = application.id;
        input.method = 'OriginateStatus';
        test.startTest();
        
        WS_eTranGetStatus.statusCallout(new List<WS_eTranServiceInvocableRequest>{input});
        
        test.stopTest();
    }
    
    public class etranGetStatusMock implements HttpCalloutMock{
        public HttpResponse respond(HTTPRequest req){
            WS_eTranGetStatus.etranStatusResponse resp = new WS_eTranGetStatus.etranStatusResponse();
            resp.ErrorMessageEnglish = '';
            resp.ErrorMessageTechnical = '';
            resp.PasswordUpdateRequired = 'No';
            resp.ResponseData = '<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<SBA_ETran_OrigStat_Response>\n\t<AuthErrorNmb>0</AuthErrorNmb>\n\t<AuthErrorText>Login Successful</AuthErrorText>\n\t<LoanAppStatus>Application In-Process</LoanAppStatus>\n\t<LoanAppNmb>429523</LoanAppNmb>\n\t<LoanAppNm>ATI MACHINERY, INC. - Integration SIT Testing - 7/27/2021</LoanAppNm>\n\t<LoanAppRqstAmt>450000.00</LoanAppRqstAmt>\n\t<LoanAppRecvDt></LoanAppRecvDt>\n\t<LoanAppAppvDt></LoanAppAppvDt>\n\t<LoanAppSBAAppvAmt></LoanAppSBAAppvAmt>\n\t<LoanNmb></LoanNmb>\n\t<LoanGntyFeeAmt></LoanGntyFeeAmt>\n\t<LoanAppFundDt></LoanAppFundDt>\n\t<SBAOfcCd></SBAOfcCd>\n\t<SBAOfc1Nm></SBAOfc1Nm>\n\t<SBAOfc2Nm></SBAOfc2Nm>\n\t<SBAOfcStrNm></SBAOfcStrNm>\n\t<SBAOfcStr2Nm></SBAOfcStr2Nm>\n\t<SBAOfcCtyNm></SBAOfcCtyNm>\n\t<SBAOfcTypCd></SBAOfcTypCd>\n\t<StCd></StCd>\n\t<ZipCd4></ZipCd4>\n\t<ZipCd5></ZipCd5>\n</SBA_ETran_OrigStat_Response>\n';

            HttpResponse res = new HttpResponse();
            res.setStatus('Success');
            res.setStatusCode(200);
            res.setBody(Json.serialize(resp));
            return res;
        }
    } */
}