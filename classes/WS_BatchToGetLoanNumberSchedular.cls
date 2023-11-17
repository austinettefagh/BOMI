/** 
 * Invocble class for the Batch Apex 
 * Date               User               Change 
 * 8/20/2021          PwC               Initial Version
 * 
 * This class is invoked by the flow and it executes the batch apex to get the loan number
*/
public class WS_BatchToGetLoanNumberSchedular{

    @InvocableMethod(label='Get Batch loan Number')
    public static void getLoanNumber(){
        WS_BatchToGetLoanNumber batch = new WS_BatchToGetLoanNumber();
        database.executebatch(batch, 1);
    }
}