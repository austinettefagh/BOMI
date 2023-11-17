/** 
 * This is the invocable request class
 * Date               User               Change 
 * 8/20/2021          PwC               Initial Version
 * 
 * This class has the input variables , passed from the flow.
*/

public class WS_eTranServiceInvocableRequest {
	@AuraEnabled @InvocableVariable(label='Application Id')
	public String appId;
	@AuraEnabled @InvocableVariable(label='Method')
	public String method;
    @AuraEnabled @InvocableVariable(label='UserName')
	public String username;
    @AuraEnabled @InvocableVariable(label='Password')
	public String password;
}