/** 
 * This is main eTran Service Class
 * Date               User               Change 
 * 8/20/2021          PwC               Initial Version
 * 
 * This class makes eTran call genearate application number and to update the loan applications
*/

public without sharing class WS_eTranService {
    
    // INPUT VARS
    public WS_eTranServiceInvocableRequest input;
    // OUTPUT VARS
    public WS_eTranServiceInvocableResponse output = new WS_eTranServiceInvocableResponse();
    //REQUEST VARS
    public String endpoint;
    public Integer timeout;
    public String requestBody;
    public HttpResponse response;
    
    public void preRequest() {
        CM_EtranConfigurationSetting__mdt metadata = WS_eTranServiceHelper.getMetadata();
        endpoint = metadata.TECH_Endpoint__c;
        timeout = Integer.valueOf(metadata.TECH_Timeout__c);
        requestBody = WS_eTranServiceHelper.createRequestBody(metadata, input, output);
    }
    
    public void request() {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setTimeout(timeout);
        req.setMethod('POST');
        req.setEndpoint(endpoint);
        req.setHeader('CONTENT-TYPE','application/json');
        req.setHeader('ACCEPT','application/json');
        req.setHeader('CONNECTION','close');
        req.setHeader('VERSION','HTTP/1.1');
        req.setBody(requestBody);
        try {
            system.debug('req');
            response = http.send(req);
        } catch (Exception e) {
            output.errors = e.getTypeName() + ': ' + e.getMessage() + ' - ' + e.getStackTraceString();
        }
    }
    
    public void postRequest() {
        output = WS_eTranServiceHelper.parseResponseBody(response, output);
    }
    
    public void logDetails() {
        ETran_Integration_Log__c logs = new ETran_Integration_Log__c();
        logs.Application__c = this.input.appId;
        logs.Error__c = this.output.errors;
        logs.Synopsis__c = this.output.synopsis;
        insert logs;
    }
    
    public void main() {
        try {
            preRequest();
        } catch (Exception e) {
            output.errors += 'Exception in Pre Request: ' + e.getTypeName() + ': ' + e.getMessage() + ' | ' + e.getStackTraceString() + '\n\n';
        }
        if (String.isBlank(output.errors) || Test.isRunningTest()) {
            try {
                request();
            } catch (Exception e) {
                                   output.errors += 'Exception in Request: ' + e.getTypeName() + ': ' + e.getMessage() + ' | ' + e.getStackTraceString() + '\n\n';
                                  }
        }
        if (String.isBlank(output.errors) || Test.isRunningTest()) {
            try {
                postRequest();
            } catch (Exception e) {
                output.errors += 'Exception in Post Request: ' + e.getTypeName() + ': ' + e.getMessage() + ' | ' + e.getStackTraceString() + '\n\n';
            }
        }
        logDetails();
    }
}