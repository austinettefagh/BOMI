/** 
 * This is Cancel Loan Application Test class
 * Date               User               Change 
 * 8/20/2021          PwC               Initial Version
 * 
 * This is test class for WS_eTranApplicationWithdraw class.
*/

@isTest
public  class WS_eTranApplicationWithdrawTest {
    @TestSetup
    static void makeData(){
        
        EtranCredential__c etran = new EtranCredential__c();
        etran.TECH_CLSUsername__c = 'TestUserName';
        etran.TECH_CLSPassword__c = 'TestPassword';
        etran.TECH_SFUsername__c = userinfo.getUserName();
        insert etran;
        
        LLC_BI__Application__c application = new LLC_BI__Application__c(
            nPortal__Artifact_Id__c = 'eTran Application',
            nSBA__Application_Number__c = '4563321',
            LLC_BI__Requested_Amount__c = 6000);
        insert application;
        
        LLC_BI__Loan__c loan = new LLC_BI__Loan__c(
            Name = 'eTran Loan',
            LLC_BI__Application__c = application.Id,
            LLC_BI__Amount__c=10000,
            LLC_BI__Amortized_Term_Months__c=24,
            LLC_BI__InterestRate__c=0.05,
            LLC_BI__SBA_Guarantee__c=1,
            LLC_BI__Monthly_Payment__c=500);
        insert loan;
    }
    
    @isTest
    public static void testCancelLoan() {
        
        LLC_BI__Application__c application = [SELECT Id, nSBA__Application_Number__c, LLC_BI__Requested_Amount__c, nPortal__Artifact_Id__c FROM LLC_BI__Application__c WHERE nPortal__Artifact_Id__c = 'eTran Application'];
		system.assertEquals('eTran Application', application.nPortal__Artifact_Id__c);                
        Test.setMock(HttpCalloutMock.class, new etranCancelApplicationMock());
        WS_eTranServiceInvocableRequest input = new WS_eTranServiceInvocableRequest();
        input.appId = application.id;
  
        test.startTest();
        WS_eTranApplicationWithdraw.cancelApplicationCallout(new List<WS_eTranServiceInvocableRequest>{input});
        test.stopTest();
    }
    
    public class etranCancelApplicationMock implements HttpCalloutMock{
        public HttpResponse respond(HTTPRequest req){
            WS_eTranApplicationWithdraw.etranStatusResponse resp = new WS_eTranApplicationWithdraw.etranStatusResponse();
            resp.ErrorMessageEnglish = '';
            resp.ErrorMessageTechnical = '';
            resp.PasswordUpdateRequired = 'No';
            resp.ResponseData = '<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<SBA_Etran_Response>\n\t<AuthErrorNmb>0</AuthErrorNmb>\n\t<AuthErrorText>Login Successful.</AuthErrorText>\n\t<App LoanAppNmb=\"429605\">\n\t\t<Results>\n\t\t\t<LoanAppNm>Business tue test</LoanAppNm>\n\t\t\t<LoanAppRqstAmt>6000.0000</LoanAppRqstAmt>\n\t\t\t<LoanAppPrtLoanNmb></LoanAppPrtLoanNmb>\n\t\t\t<LoanAppPrtAppNmb>a0if0000006HSA8AAO</LoanAppPrtAppNmb>\n\t\t\t<LoanAppRecvDt></LoanAppRecvDt>\n\t\t\t<LoanAppEtranEmailAdr>satish.perikala@pwc.com</LoanAppEtranEmailAdr>\n\t\t\t<LoanAppAppvDt></LoanAppAppvDt>\n\t\t\t<LoanAppSBAAppvAmt>6000.0000</LoanAppSBAAppvAmt>\n\t\t\t<LoanNmb></LoanNmb>\n\t\t\t<LoanGntyFeeAmt></LoanGntyFeeAmt>\n\t\t\t<LoanGntyFeeExplainTxt/>\n\t\t\t<LoanGntyPercent></LoanGntyPercent>\n\t\t\t<LoanAppFundDt></LoanAppFundDt>\n\t\t\t<LoanAppStatCd>WD</LoanAppStatCd>\n\t\t\t<BusDUNSNmb>804735132</BusDUNSNmb>\n\t\t\t<LiquidCreditScore>196</LiquidCreditScore>\n\t\t</Results>\n\t\t</App>\n</SBA_Etran_Response>\n';
            
            HttpResponse res = new HttpResponse();
            res.setStatus('Success');
            res.setStatusCode(200);
            res.setBody(Json.serialize(resp));
            return res;
        }
    }
}