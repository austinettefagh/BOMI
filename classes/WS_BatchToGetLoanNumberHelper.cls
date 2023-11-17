/** 
 * Helper Class for get loan number batch 
 * Date               User               Change 
 * 8/20/2021          PwC               Initial Version
 * 
 * This is the response wrapper class for originate status callout and it updates status back to application Record.
*/
public without sharing class WS_BatchToGetLoanNumberHelper {

    public class etranStatusResponse {
    	public String ErrorMessageTechnical;
        public String PasswordUpdateRequired;
        public String ErrorMessageEnglish;
        public String ResponseData;
    }
    
    public static void parseResponseBody(HttpResponse response, String applicationId) {
        list<sObject> objectToUpdate = new  list<sObject> ();
        if (response.getStatusCode() == 200) {
            system.debug('##Response:'+response.getBody());
        	etranStatusResponse responseWrapper = (etranStatusResponse)JSON.deserialize(response.getBody(), etranStatusResponse.class);
            if(String.isNotBlank(responseWrapper.ErrorMessageTechnical)){
               String ErrorMessageTechnical  = responseWrapper.ErrorMessageTechnical;
                LLC_BI__Application__c loanApplication = [SELECT Id, nSBA__SBA_Loan_Number__c FROM LLC_BI__Application__c WHERE Id =: applicationId];
                loanApplication.Validation_Errors__c = ErrorMessageTechnical;
                objectToUpdate.add(loanApplication);
            }else{
                //output.synopsis = responseWrapper.ResponseData;
             String sbaLoanNumber = parseXMLResponse(responseWrapper.ResponseData, applicationId);
            }
        }else{
            // this is needs to mapped
                String errors = response.getStatusCode() + ': ' + response.getStatus() + ' - ' + response.getBody();
                LLC_BI__Application__c loanApplication = [SELECT Id, nSBA__SBA_Loan_Number__c FROM LLC_BI__Application__c WHERE Id =: applicationId];
                loanApplication.Validation_Errors__c = errors;
                objectToUpdate.add(loanApplication);
        }

        if(!objectToUpdate.isempty()){
            try{
                update objectToUpdate;
            }catch(DmlException e) {
                System.debug('The following exception has occurred: ' + e.getMessage());
            }
        }
    }

    public static String parseXMLResponse(String xmlResp, String applicationId){
        Dom.Document doc = new Dom.Document();
        doc.load(xmlResp);
        //Retrieve the root element for this document.
        Dom.XMLNode address = doc.getRootElement();
        String loanAppStatus = address.getChildElement('LoanAppStatus', null).getText();
        String LoanAppRecvDt = address.getChildElement('LoanAppRecvDt', null).getText();
        String LoanAppAppvDt = address.getChildElement('LoanAppAppvDt', null).getText();
        String LoanAppSBAAppvAmt = address.getChildElement('LoanAppSBAAppvAmt', null).getText();
        String LoanGntyFeeAmt = address.getChildElement('LoanGntyFeeAmt', null).getText();
        String loanNumber = address.getChildElement('LoanNmb', null).getText();
        LLC_BI__Application__c loanApplication = [SELECT Id, nSBA__SBA_Loan_Number__c FROM LLC_BI__Application__c WHERE Id =: applicationId];
        if(loanAppStatus !=null && loanAppStatus != ''){
            loanApplication.CF_App_SBA_Status__c = loanAppStatus;
        }
        if(LoanAppRecvDt !=null && LoanAppRecvDt != ''){
            String appRecvdDate = LoanAppRecvDt.substring(0,10);
            Date recvdDate = Date.valueOf(appRecvdDate);
            loanApplication.nSBA__SBA_Date_Application_Received__c = recvdDate;
        }
        if(LoanAppAppvDt !=null && LoanAppAppvDt != ''){
            String approvedDate = LoanAppAppvDt.substring(0,10);
            Date apprvdDate = Date.valueOf(approvedDate);
            loanApplication.nSBA__Loan_Authorization_Approval_Date__c = apprvdDate;
        } 
        if(LoanAppSBAAppvAmt !=null && LoanAppSBAAppvAmt != ''){
            Integer approvedAmount = Integer.ValueOf(LoanAppSBAAppvAmt);
            loanApplication.nSBA__Original_Amount__c = approvedAmount;
        }
        if(LoanGntyFeeAmt !=null && LoanGntyFeeAmt != ''){
            Integer loanGuanteFeeAmount = Integer.ValueOf(LoanGntyFeeAmt);
            loanApplication.nSBA__Total_SBA_Guaranty_Fee__c = loanGuanteFeeAmount;
        }
        if(loanNumber !=null && loanNumber != ''){
            loanApplication.nSBA__SBA_Loan_Number__c = loanNumber;
        }
        try{
            if (Schema.sObjectType.LLC_BI__Application__c.isUpdateable() && 
                Schema.sObjectType.LLC_BI__Application__c.fields.CF_App_SBA_Status__c.isUpdateable() && //Jayanth updated from PPP
                Schema.sObjectType.LLC_BI__Application__c.fields.nSBA__SBA_Date_Application_Received__c.isUpdateable() &&
                Schema.sObjectType.LLC_BI__Application__c.fields.nSBA__Loan_Authorization_Approval_Date__c.isUpdateable() &&
                Schema.sObjectType.LLC_BI__Application__c.fields.nSBA__Original_Amount__c.isUpdateable() &&
                Schema.sObjectType.LLC_BI__Application__c.fields.nSBA__Total_SBA_Guaranty_Fee__c.isUpdateable() &&
                Schema.sObjectType.LLC_BI__Application__c.fields.nSBA__SBA_Loan_Number__c.isUpdateable()){

                    update loanApplication;
            }
        }catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
        return loanNumber;
    }
}