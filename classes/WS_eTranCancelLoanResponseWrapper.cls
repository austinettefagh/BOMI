/** 
 * This is Cancel Loan  response wrapper
 * Date               User               Change 
 * 8/20/2021          PwC               Initial Version
 * 
 * This class parses the response of cancel loan callout
*/

public class WS_eTranCancelLoanResponseWrapper {

    public String ErrorMessageTechnical;
    public String PasswordUpdateRequired;
    public String ErrorMessageEnglish;
    public String ResponseData;
    public ResponseData_cls responseDataObject;
        
    public class ResponseData_cls {
        public String AuthErrorNmb;
        public String AuthErrorText;
        public List<String> Synopsis = new List<String>();
        public List<SBALoan> SBALoan = new List<SBALoan> {new SBALoan()};
    }

    public class SBALoan {
        public String LoanAppNmb;
        public Results Results = new Results();
        public List<String> Errors = new List<String>();
    }

    public class Results {
        public String ResultInd;
    }
    
    public WS_eTranCancelLoanResponseWrapper(){
        responseDataObject = new ResponseData_cls();
        if (responseDataObject == null && String.isNotBlank(ResponseData)) {
            //Replacement is needed due to broken JSON structure returned by SBA catweb2, which fails to deserialize
            responseDataObject = (ResponseData_cls) JSON.deserialize((ResponseData).replace('\n\t],\n]}', '\n\t]}'), ResponseData_cls.class);
        }
    }
}