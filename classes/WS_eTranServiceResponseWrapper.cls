/** 
 * This is the eTran Response Wrapper
 * Date               User               Change 
 * 8/20/2021          PwC               Initial Version
 * 
 * This class deserilizes the response and it is sent back to the flow.
*/
public class WS_eTranServiceResponseWrapper {

    public String ErrorMessageTechnical;
    public String PasswordUpdateRequired;
    public String ErrorMessageEnglish;
    public String ResponseData;
    public ResponseData responseDataObject;
    public List<String> ErrorsOutsideAppLoan;
        
    public class ResponseData {
        public String AuthErrorNmb;
        public String AuthErrorText;
        public List<String> Synopsis = new List<String>();
        public List<App> App = new List<App> {new App()};
    }

    public class App {
        public String LoanAppNmb;
        public Results Results = new Results();
        public List<String> Errors = new List<String>();
        public List<String> Trace = new List<String>();
    }

    public class Results {
        public String LoanAppNm;
        public String LoanAppRqstAmt;
        public String LoanAppPrtLoanNmb;
        public String LoanAppPrtAppNmb;
        public String LoanAppRecvDt;
        public String LoanAppEtranEmailAdr;
        public String LoanAppAppvDt;
        public String LoanAppSBAAppvAmt;
        public String LoanNmb;
        public String LoanGntyFeeAmt;
        public String LoanGntyFeeExplainTxt;
        public String LoanGntyPercent;
        public String LoanAppFundDt;
        public String LoanAppStatCd;
        public String BusDUNSNmb;
        public String LiquidCreditScore;
    }
    
    public ResponseData deserializeResponseData(){
        if (responseDataObject == null && String.isNotBlank(ResponseData)) {
            //Replacement is needed due to broken JSON structure returned by SBA catweb2, which fails to deserialize
            responseDataObject = (ResponseData) JSON.deserialize((ResponseData).replace('\n\t],\n]}', '\n\t]}'), ResponseData.class);
        }
        return responseDataObject;
    }
    
    
    public class eTranResponseResults {
        public String sbaLoanNumber;
        public String applicationReceivedDate;
        public String applicationApprovedDate;
        public String applicationFundedDate;
        public String liquidCreditScore;
        public String dunsNumber;
        public String LoanApplicationApprovalAmount;
        public String LoanGuarnteeFeeAmount;
        public String LoanApplicationStatusCode;


        eTranResponseResults (Results results) {
            dunsNumber = results.BusDUNSNmb;
            liquidCreditScore = results.LiquidCreditScore;
            applicationReceivedDate = results.LoanAppRecvDt;
            applicationApprovedDate = results.LoanAppAppvDt;
            applicationFundedDate = results.LoanAppFundDt;
            sbaLoanNumber = results.LoanNmb;
            LoanApplicationApprovalAmount = results.LoanAppSBAAppvAmt;
            LoanGuarnteeFeeAmount = results.LoanGntyFeeAmt;
            LoanApplicationStatusCode = results.LoanAppStatCd;
        }
    }

    public List<String> getSynopsis(){
        deserializeResponseData();
        if (responseDataObject != null) {
            return responseDataObject.Synopsis;
        }
        return null;
    }

    public List<String> getErrors(){
        deserializeResponseData();
        if (responseDataObject != null && responseDataObject.App != null && !responseDataObject.App.isEmpty()) {
            return responseDataObject.App[0].Errors;
        }else if(responseDataObject != null && (responseDataObject.App == null || responseDataObject.App.isEmpty()))
        {
            List<String> errorList = new List<String>();
            if(responseDataObject.AuthErrorNmb != '0'){
               errorList.add(responseDataObject.AuthErrorText);
            }
            /*if(ErrorsOutsideAppLoan != Null && !ErrorsOutsideAppLoan.isEmpty()){
                errorList.addAll(ErrorsOutsideAppLoan);
            }*/
            return errorList;
        }
        return null;
    }
    
    public String getApplicationNumber(){
        deserializeResponseData();
        if (responseDataObject != null && responseDataObject.App != null && !responseDataObject.App.isEmpty()) {
            return responseDataObject.App[0].LoanAppNmb;
        }
        return null;
    }

    public eTranResponseResults getResponseResults()   {
        deserializeResponseData();
        if (responseDataObject != null && responseDataObject.App != null
            && !responseDataObject.App.isEmpty() && responseDataObject.App[0].Results != null) {
            return new eTranResponseResults(responseDataObject.App[0].Results);
        }
        return null;
    }
}