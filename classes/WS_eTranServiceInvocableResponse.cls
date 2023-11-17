/** 
 * This is the invocable response class
 * Date               User               Change 
 * 8/20/2021          PwC               Initial Version
 * 
 * This class has the output variables , passed to the flow.
*/
public class WS_eTranServiceInvocableResponse {
	@AuraEnabled @InvocableVariable(label='Response Synopsis')
	public String synopsis;
	@AuraEnabled @InvocableVariable(label='Error List')
	public String errors = '';
	@AuraEnabled @InvocableVariable(label='Liquid Credit Score')
	public String liquidCreditScore;
	@AuraEnabled @InvocableVariable(label='SBA Application Number')
	public String applicationNumber;
	@AuraEnabled @InvocableVariable(label='SBA Loan Authorization Number')
	public String sbaLoanNumber;
	@AuraEnabled @InvocableVariable(label='DUNS Number')
	public String dunsNumber;
	@AuraEnabled @InvocableVariable(label='Application Received Date')
	public String applicationReceivedDate;
	@AuraEnabled @InvocableVariable(label='Application Approved Date')
	public String applicationApprovedDate;
	@AuraEnabled @InvocableVariable(label='Application Funded Date')
	// Added New below
	public String applicationFundedDate;
	@AuraEnabled @InvocableVariable(label='SBA Application Approved Amount')
	public String loanApplicationApprovedAmount;
	@AuraEnabled @InvocableVariable(label='Loan Guarantee Fees Amount')
	public String LoanGuaranteeFeeAmount;
	@AuraEnabled @InvocableVariable(label='Loan Application Status')
	public String LoanApplicationStatus;
	
}