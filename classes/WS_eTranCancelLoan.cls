/** 
 * This is Cancel Loan  class
 * Date               User               Change 
 * 8/20/2021          PwC               Initial Version
 * 
 * This class makes eTran call to cancel the loan application which is having the loan number
*/
public without sharing class WS_eTranCancelLoan {
    
	@InvocableMethod(label='eTranCancelLoan')
    public static list<WS_eTranServiceInvocableResponse> statusCallout (list<WS_eTranServiceInvocableRequest> inputVar) {
        input = inputVar[0];
        cancelLoanCallout(input, output);
        return new list<WS_eTranServiceInvocableResponse> {output};
    }
    
    // INPUT VARS
    public static WS_eTranServiceInvocableRequest input;
    // OUTPUT VARS
    public static WS_eTranServiceInvocableResponse output = new WS_eTranServiceInvocableResponse();
    
    public class etranCancelRequest {
        public String MethodNamePhysical;
        public String CLSUsername;
        public String CLSPassword;
        public String CLSPIN;
        public String RequestData;
        public String RequestedAmount;
        public String LocationId;
        public String FormatOut = 'JSON';
        public String FormatIn = 'JSON';
        public String EMail;
        public String SoftwareVendorCode;
        public String SoftwareVendorName;
        public String ApplicationNumber;
        public etranCancelRequest(CM_EtranConfigurationSetting__mdt metadata, EtranCredential__c cred, String AppNum, String loanNum){
            MethodNamePhysical = 'Servicing2';
            CLSUsername = cred.TECH_CLSUsername__c;
            CLSPassword = cred.TECH_CLSPassword__c;
            CLSPIN = cred.TECH_CLSPin__c;
            SoftwareVendorCode = metadata.TECH_SoftwareVendorCode__c;
            SoftwareVendorName = metadata.TECH_SoftwareVendorName__c;
            ApplicationNumber = AppNum;
			RequestData requestDataObject = new RequestData();
            requestDataObject.SBALoan[0].Loan[0].LoanApplicNmb = AppNum;
            requestDataObject.SBALoan[0].Loan[0].LoanNmb = loanNum;
            RequestData = JSON.serialize(requestDataObject);
            //RequestedAmount = String.valueOf(loan.LLC_BI__Amount__c);
            LocationId  = metadata.TECH_LocationId__c;
            EMail = UserInfo.getUserEmail();
        }
    }
    
    private class RequestData {
        private String version = '6.4';
        private List<SBALoan> SBALoan;
       	RequestData () {
            SBALoan = new List<SBALoan>{new SBALoan()};
        }
    }
    
    private class SBALoan {
        private List<Loan> Loan;
        private string action = 'cancel';
        SBALoan (){
            Loan = new List<Loan>{new Loan()};
        }
    }
    
    private class Loan {
        private string action = 'update';
        private string LoanApplicNmb;
        private string LoanNmb;
    }
    
    public static WS_eTranServiceInvocableResponse cancelLoanCallout(WS_eTranServiceInvocableRequest input, 
                                                                        WS_eTranServiceInvocableResponse output){
        CM_EtranConfigurationSetting__mdt metadata = [
                SELECT TECH_Endpoint__c, TECH_SoftwareVendorName__c, TECH_SoftwareVendorCode__c, TECH_LocationId__c
                FROM CM_EtranConfigurationSetting__mdt WHERE DeveloperName = 'eTran_Configuration'
                LIMIT 1 ];
        
       	EtranCredential__c cred = [
                SELECT Id, TECH_CLSUsername__c, TECH_CLSPassword__c, TECH_CLSPin__c
            	FROM EtranCredential__c  WHERE TECH_SFUsername__c = :UserInfo.getUserName() LIMIT 1];
        
        LLC_BI__Application__c application = [SELECT Id, nSBA__Application_Number__c, nSBA__SBA_Loan_Number__c FROM LLC_BI__Application__c WHERE Id = :input.appId];
                                                                            
        String endpoint = metadata.TECH_Endpoint__c;
		etranCancelRequest requestWrapper = new etranCancelRequest(metadata, cred, application.nSBA__Application_Number__c, application.nSBA__SBA_Loan_Number__c);
        String requestBody = JSON.serialize(requestWrapper);
                                                                            
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setTimeout(120000);
        req.setMethod('POST');
        req.setEndpoint(endpoint);
        req.setHeader('CONTENT-TYPE','application/json');
        req.setHeader('ACCEPT','application/json');
        req.setHeader('CONNECTION','close');
        req.setHeader('VERSION','HTTP/1.1');
        req.setBody(requestBody);
        system.debug('##request:'+req.getBody());
        HttpResponse response = http.send(req);
        if (response.getStatusCode() == 200) {
            system.debug('##Response:'+response.getBody());
            WS_eTranCancelLoanResponseWrapper responseWrapper = (WS_eTranCancelLoanResponseWrapper)JSON.deserialize(response.getBody(), WS_eTranCancelLoanResponseWrapper.class);
            system.debug('responseWrapper'+responseWrapper);
            if(String.isNotBlank(responseWrapper.ResponseData)){
                WS_eTranCancelLoanResponseWrapper.ResponseData_cls resResult = (WS_eTranCancelLoanResponseWrapper.ResponseData_cls) JSON.deserialize((responseWrapper.ResponseData).replace('\n\t],\n]}', '\n\t]}'), WS_eTranCancelLoanResponseWrapper.ResponseData_cls.class);			
                WS_eTranCancelLoanResponseWrapper.SBALoan SBALoanResult = new WS_eTranCancelLoanResponseWrapper.SBALoan();
                
                if(resResult.SBALoan.size() > 0) 
                    SBALoanResult = resResult.SBALoan[0];
                String errorList = '';
                
                if(SBALoanResult.Errors != null ) //Added to fix the null pointer exception in case of successful cancellation
                {
                    if (SBALoanResult.Errors.size() > 0) {
                        for (String e : SBALoanResult.Errors) {
                            errorList += e + '\n\n';
                        }
                        output.errors = errorList;
                    }
                 }
                WS_eTranCancelLoanResponseWrapper.Results resultData = SBALoanResult.Results;
                String resultInd = resultData.ResultInd;
                if(String.isNotBlank(responseWrapper.ErrorMessageTechnical)){
                    output.errors = responseWrapper.ErrorMessageTechnical;
                }else if(resultInd == 'F'){
                    output.errors = errorList;
                }
                else{
                    output.synopsis = 'Cancelled Sucessfully';
            	}
        	}
        }else{
                output.errors = response.getStatusCode() + ': ' + response.getStatus() + ' - ' + response.getBody();
            }
        return output; 
    }
}