/** 
 * This is the two faactor Authentication class
 * Date               User               Change 
 * 8/20/2021          PwC               Initial Version
 * 
 * This class executed for generating the 4 digit pin from SBA Etran endpoint. Class is invoked by the Etran Interaction button from Loan Object.
*/
public without sharing class WS_eTranTwofactorAuth {
    
    @InvocableMethod(label='eTranTwoFactorAuth')
    public static list<WS_eTranServiceInvocableResponse> pinCallout (list<WS_eTranServiceInvocableRequest> inputVar) {
        input = inputVar[0];
        twoFactorAuthCallout(input, output);
        return new list<WS_eTranServiceInvocableResponse> {output};
            }
    
    public String MethodNamePhysical;
    public String CLSUsername;
    public String CLSPassword;
    // INPUT VARS
    public static WS_eTranServiceInvocableRequest input;
    // OUTPUT VARS
    public static WS_eTranServiceInvocableResponse output = new WS_eTranServiceInvocableResponse();
    
    public WS_eTranTwofactorAuth(String method,String UserName, String Password) {
        CLSUsername = UserName;
        CLSPassword = Password;
        MethodNamePhysical = method;        	
    }
    
    public class etranPinResponse {
        public String ErrorMessageTechnical;
        public String PasswordUpdateRequired;
        public String ErrorMessageEnglish;
        public String ResponseData;
        public String Successful;
    }
    
    public static WS_eTranServiceInvocableResponse twoFactorAuthCallout(WS_eTranServiceInvocableRequest input, WS_eTranServiceInvocableResponse output){
        
        CM_EtranConfigurationSetting__mdt metadata = [SELECT TECH_EndpointPINAuth__c FROM CM_EtranConfigurationSetting__mdt WHERE DeveloperName = 'eTran_Configuration' LIMIT 1 ];
        String endpoint = metadata.TECH_EndpointPINAuth__c;
        
        WS_eTranTwofactorAuth requestWrapper = new WS_eTranTwofactorAuth(input.method, input.username, input.password);
        String requestBody = JSON.serialize(requestWrapper);
        
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setTimeout(120000);
        req.setMethod('POST');
        req.setEndpoint(endpoint);
        req.setHeader('CONTENT-TYPE','application/json');
        req.setHeader('Accept','application/json');
        req.setHeader('CONNECTION','close');
        req.setHeader('VERSION','HTTP/1.1');
        req.setBody(requestBody);
        HttpResponse response = http.send(req);

        if (response.getStatusCode() == 200) {
            etranPinResponse responseWrapper = (etranPinResponse)JSON.deserialize(response.getBody(), etranPinResponse.class);
            if(responseWrapper.Successful == 'No' || String.isBlank(responseWrapper.Successful)){
                output.errors = responseWrapper.ErrorMessageTechnical;
            }else{
                output.synopsis = responseWrapper.ResponseData;
            }
        }else{
            output.errors = response.getStatusCode() + ': ' + response.getStatus() + ' - ' + response.getBody();
        }
        return output; 
    }
}