@isTest 
private class Test_AC_Account_Controller {
    static testMethod void testAC_Account_Controller() {
        Opportunity Opp = New Opportunity();
        Opp.CloseDate = Date.valueOf('2022-04-29');
        Opp.Name = 'Test';
        Opp.StageName = 'Identify';
        Account Acc = New Account();
        Acc.Name = 'TestAcc';
        insert Acc;
        Opp.AccountId = Acc.id;
        insert Opp;
        ApexPages.currentPage().getParameters().put('id',Opp.id);
        AC_Account_Controller rec = new AC_Account_Controller();

    }
}