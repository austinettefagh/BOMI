/** 
 * Batch apex to fetch SBA Loan number from ETran 
 * Date               User               Change 
 * 8/20/2021          PwC               Initial Version
 * 
 * Fetches SBA Loan for the loans that have an application number and were submitted more than 7 days ago
*/
global class WS_BatchToGetLoanNumber implements Database.Batchable<sObject>, Database.AllowsCallouts{

    CM_EtranConfigurationSetting__mdt metadata = [SELECT TECH_Endpoint__c, TECH_SoftwareVendorName__c, TECH_SoftwareVendorCode__c FROM CM_EtranConfigurationSetting__mdt 
                                                  					WHERE DeveloperName = 'eTran_Configuration' LIMIT 1 ];

    EtranCredential__c eCreds = [SELECT Id, TECH_CLSPassword__c, TECH_CLSPin__c, TECH_CLSUsername__c, TECH_SFUsername__c FROM EtranCredential__c 
                                                                      WHERE TECH_SFUsername__c =: UserInfo.getUserName() LIMIT 1];
    	
    public String username = eCreds.TECH_CLSUsername__c;
    public String password = eCreds.TECH_CLSPassword__c;
    public String pin = eCreds.TECH_CLSPin__c;
    public String endpoint = metadata.TECH_Endpoint__c;
    public String vendorCode = metadata.TECH_SoftwareVendorCode__c;
    public String vendorName = metadata.TECH_SoftwareVendorName__c;

    public class WS_BatchRequestwrapper {
        public String CLSUsername;
        public String CLSPassword;
        public String CLSPIN;
        public String SoftwareVendorName;
        public String SoftwareVendorCode;
        public String MethodNamePhysical;
        public String ApplicationNumber;                               
        public WS_BatchRequestwrapper(String method,String UserName, String Password, String Pin, String SftVenName, String SftVenCode, String appNumber) {
            CLSUsername = UserName;
            CLSPassword = Password;
            CLSPIN = Pin;
            SoftwareVendorName = SftVenName;
            SoftwareVendorCode = SftVenCode;
            MethodNamePhysical = method; 
            ApplicationNumber  = appNumber;      
        }
    }

    global Database.QueryLocator start(Database.BatchableContext bc){
        String soqlQuery = 'SELECT Id, nSBA__Application_Number__c, nSBA__SBA_Loan_Number__c, nSBA__SBA_Date_Application_Received__c  FROM LLC_BI__Application__c WHERE nSBA__Application_Number__c !=null AND nSBA__SBA_Loan_Number__c  = null AND nSBA__SBA_Date_Application_Received__c < LAST_N_DAYS:7';
        return Database.getQueryLocator(soqlQuery);
    }

    global void execute(Database.BatchableContext bc, List<LLC_BI__Application__c> applicationRecs){
         for(LLC_BI__Application__c applicationobj : applicationRecs){
                    String Username = username;
                    String Password = password;
                    String Pin = pin;
                    String Method = 'OriginateStatus';
                    String SoftwareVendorCode = vendorCode;
                    String SoftwareVendorName = vendorName;
                    String applicationNumber = applicationobj.nSBA__Application_Number__c;
                    
                    WS_BatchRequestwrapper reqWrapper = new WS_BatchRequestwrapper(Method, Username, Password, Pin, SoftwareVendorName, SoftwareVendorCode, applicationNumber);
                    String requestBody = JSON.serialize(reqWrapper);
                    system.debug('##requestBody'+requestBody);
                    
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
					system.debug('##response'+response);
                    WS_BatchToGetLoanNumberHelper.parseResponseBody(response, applicationobj.Id); 
        }
    }
    
    global void finish(Database.BatchableContext bc){
    }
}