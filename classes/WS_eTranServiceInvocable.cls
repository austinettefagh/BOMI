/** 
 * This is the invocable main Class
 * Date               User               Change 
 * 8/20/2021          PwC               Initial Version
 * 
 * This class invoked by the flow and this passes the input to apex and also return the data from apex to flow
*/

public class WS_eTranServiceInvocable {
    @InvocableMethod(label='eTran Service')
    public static list<WS_eTranServiceInvocableResponse> main (list<WS_eTranServiceInvocableRequest> input) {
        WS_eTranService service = new WS_eTranService();
        service.input = input[0];
        service.main();
        return new list<WS_eTranServiceInvocableResponse> {service.output};
    }
}