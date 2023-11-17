/** 
 * This is get loan number Test class
 * Date               User               Change 
 * 8/20/2021          PwC               Initial Version
 * 
 * This is test class for WS_BatchToGetLoanNumber class.
*/
@isTest
public class WS_BatchToGetLoanNumberTest {
	  @TestSetup
    static voId makeData(){
        LLC_BI__Application__c application = new LLC_BI__Application__c(nPortal__Artifact_Id__c = 'eTran Application', nSBA__Application_Number__c ='33425543', nSBA__SBA_Date_Application_Received__c = (system.today()-10));
        insert application;
    }
    
    public class eTranStatusResponse implements HttpCalloutMock{
        public HttpResponse respond(HTTPRequest req){
            HttpResponse res = new HttpResponse();
            res.setStatus('Success');
            res.setStatusCode(200);
            res.setBody('{"ErrorMessageTechnical":"","PasswordUpdateRequired":"Unknown","ResponseData":"<?xml version=\\"1.0\\" encoding=\\"UTF-8\\"?>'+
						'<SBA_ETran_OrigStat_Response>'+
					'<AuthErrorNmb>0</AuthErrorNmb>'+
                    '<AuthErrorText>Login Successful</AuthErrorText>'+
					'<LoanAppStatus>In Review Reviewer 1</LoanAppStatus>'+ 
					'<LoanAppNmb>429643</LoanAppNmb>'+ 
					'<LoanAppNm>Business tue test</LoanAppNm>'+
					'<LoanAppRqstAmt>6000.00</LoanAppRqstAmt>'+
					'<LoanAppRecvDt>2021-08-19 06:35:57.0</LoanAppRecvDt>'+
					'<LoanAppAppvDt>2021-08-19 06:35:57.0</LoanAppAppvDt>'+
					'<LoanAppSBAAppvAmt>6000.00</LoanAppSBAAppvAmt>'+
					'<LoanNmb>88752652</LoanNmb>'+
					'<LoanGntyFeeAmt>450.00</LoanGntyFeeAmt>'+ 
					'<LoanAppFundDt></LoanAppFundDt>'+ 
					'<SBAOfcCd></SBAOfcCd>'+ 
					'<ZipCd5></ZipCd5>'+
					'</SBA_ETran_OrigStat_Response>","ErrorMessageEnglish":"Unknown"}');
            return res;
        }
    }
    
    public class eTranStatusResponseErrorMessageTech implements HttpCalloutMock{
        public HttpResponse respond(HTTPRequest req){
            HttpResponse res = new HttpResponse();
            res.setStatus('Success');
            res.setStatusCode(200);
            res.setBody('{"ErrorMessageTechnical":"PasswordUpdateRequired","PasswordUpdateRequired":"Unknown","ResponseData":"<?xml version=\\"1.0\\" encoding=\\"UTF-8\\"?>'+
						'<SBA_ETran_OrigStat_Response>'+
					'<AuthErrorNmb>0</AuthErrorNmb>'+
                    '<AuthErrorText>Login Successful</AuthErrorText>'+
					'<LoanAppStatus>In Review Reviewer 1</LoanAppStatus>'+ 
					'<LoanAppNmb>429643</LoanAppNmb>'+ 
					'<LoanAppNm>Business tue test</LoanAppNm>'+
					'<LoanAppRqstAmt>6000.00</LoanAppRqstAmt>'+
					'<LoanAppRecvDt>2021-08-19 06:35:57.0</LoanAppRecvDt>'+
					'<LoanAppAppvDt></LoanAppAppvDt>'+
					'<LoanAppSBAAppvAmt></LoanAppSBAAppvAmt>'+
					'<LoanNmb></LoanNmb>'+
					'<LoanGntyFeeAmt></LoanGntyFeeAmt>'+ 
					'<LoanAppFundDt></LoanAppFundDt>'+ 
					'<SBAOfcCd></SBAOfcCd>'+ 
					'<ZipCd5></ZipCd5>'+
					'</SBA_ETran_OrigStat_Response>","ErrorMessageEnglish":"Unknown"}');
            return res;
        }
    }
    
    @isTest
    public static voId testEtranLoanStatus() { 
        EtranCredential__c etran = new EtranCredential__c();
        etran.TECH_CLSUsername__c = 'TestUserName';
        etran.TECH_CLSPassword__c = 'TestPassword';
        etran.TECH_SFUsername__c = userinfo.getUserName();
        insert etran;
        system.assertEquals('TestUserName', etran.TECH_CLSUsername__c);
        LLC_BI__Application__c application = [SELECT Id FROM LLC_BI__Application__c LIMIT 1];
        test.startTest();
        Test.setMock(HttpCalloutMock.class, new eTranStatusResponse());
        WS_BatchToGetLoanNumberSchedular.getLoanNumber();
        WS_BatchToGetLoanNumber batch = new WS_BatchToGetLoanNumber();
        database.executebatch(batch, 1);
        test.stopTest();
    }
        @isTest
    public static voId testEtranLoanStatusError() { 
    	EtranCredential__c etran = new EtranCredential__c();
        etran.TECH_CLSUsername__c = 'TestUserName';
        etran.TECH_CLSPassword__c = 'TestPassword';
        etran.TECH_SFUsername__c = userinfo.getUserName();
        insert etran;
        system.assertEquals('TestUserName', etran.TECH_CLSUsername__c);
        LLC_BI__Application__c application = [SELECT Id FROM LLC_BI__Application__c LIMIT 1];
        test.startTest();
        Test.setMock(HttpCalloutMock.class, new eTranStatusResponseErrorMessageTech());
        WS_BatchToGetLoanNumberSchedular.getLoanNumber();
        WS_BatchToGetLoanNumber batch = new WS_BatchToGetLoanNumber();
        database.executebatch(batch, 1);
        test.stopTest();
	}
}