@isTest
public class CT_TestClass_For_TS_Classes {
/** 
* 8/18/2023 PwC - Jayanth - This test class should cover the TS Triggers inserted as part of ncino community instructions.
* 
*/
  
@TestSetup
    static voId makeData(){
        
        LLC_BI__Deposit__c vDep = new LLC_BI__Deposit__c(Name='Test Deposit');
        insert vDep;

        CO_Sweep_Setup__c vSweep = new CO_Sweep_Setup__c(CF_Primary_Child_Account__c = vDep.id,CF_Secondary_Parent_Account__c =vDep.Id ,CF_Peg_Balance__c = 55.00);
        insert vSweep;
		
    }
    
    @isTest
    public static voId testDeleteSweep() {
                     
        test.startTest();
       	CO_Sweep_Setup__c vSweepFind = [SELECT ID, CF_Peg_Balance__c FROM CO_Sweep_Setup__c WHERE CF_Peg_Balance__c = 55.00];
        system.assertEquals(55.00, vSweepFind.CF_Peg_Balance__c);   
		vSweepFind.CF_Peg_Balance__c = 66.00;
		delete vSweepFind;        
        test.stopTest();
    }    

}