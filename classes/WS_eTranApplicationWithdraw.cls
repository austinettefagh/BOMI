/** 
 * This is Cancel Loan Application class
 * Date               User               Change 
 * 8/20/2021          PwC               Initial Version
 * 
 * This class makes eTran call to cancel the loan application generated without having the loan number
*/
public with sharing class WS_eTranApplicationWithdraw {

    @InvocableMethod(label='eTranApplicationWithdraw')
    public static list<WS_eTranServiceInvocableResponse> cancelApplicationCallout (list<WS_eTranServiceInvocableRequest> inputVar) {
        input = inputVar[0];
        getStatusCallout(input, output);
        return new list<WS_eTranServiceInvocableResponse> {output};
    }
    
    // INPUT VARS
    public static WS_eTranServiceInvocableRequest input;
    // OUTPUT VARS
    public static WS_eTranServiceInvocableResponse output = new WS_eTranServiceInvocableResponse();
    
    public class etranApplicationWithdraw {
        public String MethodNamePhysical;
        public String CLSUsername;
        public String CLSPassword;
        public String CLSPIN;
        public String SoftwareVendorCode;
        public String SoftwareVendorName;
        public String ApplicationNumber;
        public String Email;
        public String LocationId;
        public String RequestedAmount;
        public etranApplicationWithdraw(CM_EtranConfigurationSetting__mdt metadata, EtranCredential__c cred, LLC_BI__Application__c app, LLC_BI__Loan__c loan ){
            MethodNamePhysical = 'OrigWithdraw';
            CLSUsername = cred.TECH_CLSUsername__c;
            CLSPassword = cred.TECH_CLSPassword__c;
            CLSPIN = cred.TECH_CLSPin__c;
            SoftwareVendorCode = metadata.TECH_SoftwareVendorCode__c;
            SoftwareVendorName = metadata.TECH_SoftwareVendorName__c;
            ApplicationNumber = app.nSBA__Application_Number__c;
            Email = metadata.TECH_Email__c;
            LocationId = metadata.TECH_LocationId__c;
            RequestedAmount = String.valueOf(loan.LLC_BI__Amount__c);
            
        }
    }
    
    public class etranStatusResponse {
    	public String ErrorMessageTechnical;
        public String PasswordUpdateRequired;
        public String ErrorMessageEnglish;
        public String ResponseData;
    }

    public static WS_eTranServiceInvocableResponse getStatusCallout(WS_eTranServiceInvocableRequest input, 
                                                                        WS_eTranServiceInvocableResponse output){
        CM_EtranConfigurationSetting__mdt metadata = [SELECT TECH_Endpoint__c, TECH_SoftwareVendorName__c, TECH_SoftwareVendorCode__c, TECH_LocationId__c, TECH_Email__c
                                                            FROM CM_EtranConfigurationSetting__mdt WHERE DeveloperName = 'eTran_Configuration' LIMIT 1 ];
        
       	EtranCredential__c cred = [SELECT Id, TECH_CLSUsername__c, TECH_CLSPassword__c, TECH_CLSPin__c
            	                         FROM EtranCredential__c  WHERE TECH_SFUsername__c =: Userinfo.getUserName() LIMIT 1];
        
        LLC_BI__Application__c application = [SELECT Id, nSBA__Application_Number__c 
                                                    FROM LLC_BI__Application__c WHERE Id =: input.appId];

        LLC_BI__Loan__c loanRecord = [SELECT Id, LLC_BI__Amount__c FROM LLC_BI__Loan__c 
                                                WHERE LLC_BI__Application__c =: input.appId ];                                           

        String endpoint = metadata.TECH_Endpoint__c;

		etranApplicationWithdraw requestWrapper = new etranApplicationWithdraw(metadata,cred,application, loanRecord );
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
        system.debug('##Response'+response);
        if (response.getStatusCode() == 200) {
            system.debug('##Response:'+response.getBody());
        	etranStatusResponse responseWrapper = (etranStatusResponse)JSON.deserialize(response.getBody(), etranStatusResponse.class);
            if(String.isNotBlank(responseWrapper.ErrorMessageTechnical)){
                output.errors = responseWrapper.ErrorMessageTechnical;
            }else{
                output.LoanApplicationStatus = parseXMLResponse(responseWrapper.ResponseData);
            }
        }else{
                output.errors = response.getStatusCode() + ': ' + response.getStatus() + ' - ' + response.getBody();
            }
        return output; 
    }
    
    public static String parseXMLResponse(String xmlResp){
        Dom.Document doc = new Dom.Document();
        doc.load(xmlResp);
        //Retrieve the root element for this document.
        Dom.XMLNode address = doc.getRootElement();
        Dom.XMLNode App = address.getChildElement('App', null);
        Dom.XMLNode Results = App.getChildElement('Results', null);
        String LoanAppStatCd = Results.getChildElement('LoanAppStatCd', null).getText();
        return LoanAppStatCd;
    }
}