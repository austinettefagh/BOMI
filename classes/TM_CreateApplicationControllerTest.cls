/**
 * @description Test class for TM_CreateApplicationController
 */ 
@isTest (SeeAllData=FALSE)
public class TM_CreateApplicationControllerTest {
    // Account IndustriesBusiness Record Type Id
    private static String accRecordTypeId = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosByDeveloperName().get('IndustriesBusiness').getRecordTypeId();
    // Opportunity Treasury Record Type Id
    private static String oppRecordTypeId = Schema.getGlobalDescribe().get('Opportunity').getDescribe().getRecordTypeInfosByDeveloperName().get('TM_Track_Treasury_Products_Sold').getRecordTypeId();
    /********************************************************************************************************
    Method name : setupTestData
    Parameters  : none
    return      : void
    **********************************************************************************************************/     
    @testSetup
    static void setupTestData(){
        test.startTest();
        Account acc = new Account(Name = 'Smith', RecordTypeId = accRecordTypeId);
        insert acc;
        Opportunity objOpp = new Opportunity(Name = 'Smith Opportunity',StageName = 'Identify',CloseDate = System.today(), AccountId = acc.Id, RecordTypeId = oppRecordTypeId);
        insert objOpp;
        test.stopTest();
    }

    /**
     * @description setupTestData description
     * 
     */ 
    static testMethod void testgetOppDetails(){
        
        test.StartTest();
        List<Opportunity> opportunityList  =  [SELECT Id, AccountId from Opportunity WHERE Id!= null];
        System.assertEquals(true,opportunityList.size()>0);
        List<TM_CreateApplicationController.ProductChildWrappers> childList = new List<TM_CreateApplicationController.ProductChildWrappers>();
        TM_CreateApplicationController.ProductChildWrappers achWapper = new TM_CreateApplicationController.ProductChildWrappers();
        achWapper.type = 'ACH Companies';
        //for ACH Companies
        achWapper.achName = 'Test ACH Names';
        achWapper.achOffsetAcct = 'Test ACH Offset Account';
        achWapper.achAdditional = 'Test ACH achAdditional';
        achWapper.reACHLimit = '244';
        achWapper.achSameDay = 'Yes';
        achWapper.achFrequency = 'Daily';
        achWapper.achCreditsDebits = 'Credits only';
        achWapper.achTransaction = 'Payroll';
        achWapper.achNote = '';
        childList.add(achWapper);
        //for RDC Scanner
        TM_CreateApplicationController.ProductChildWrappers scannerWapper = new TM_CreateApplicationController.ProductChildWrappers();
        scannerWapper.type = 'Scanner';
        scannerWapper.scannerIsStock = 'Yes';
        scannerWapper.scannerSerialNum = 'Number134';
        childList.add(scannerWapper);
        //for RDC Profit Stars Account Access
        TM_CreateApplicationController.ProductChildWrappers profitWapper = new TM_CreateApplicationController.ProductChildWrappers();
        profitWapper.type = 'Profit Stars Account Access';
        profitWapper.psAcctName = 'Profit Account';
        profitWapper.psAcctNumber = 'Number123';
        childList.add(profitWapper);
        //for Product User
        TM_CreateApplicationController.ProductChildWrappers userWapper = new TM_CreateApplicationController.ProductChildWrappers();
        userWapper.type = 'Product User';
        userWapper.adminName = 'Test Admin Name';
        userWapper.adminEmail = 'test@test.com';
        userWapper.adminPerDayLimit = '123';
        userWapper.adminWorkNum = '222223';
        userWapper.adminCellNum = '22222';
        userWapper.adminBankingAccess = 'Yes';
        userWapper.adminPerWireLimit = '123';
        userWapper.adminAcctAccess = '';
        userWapper.adminAuthorized = '';
        childList.add(userWapper);
        //for Product Account
        TM_CreateApplicationController.ProductChildWrappers accountWapper = new TM_CreateApplicationController.ProductChildWrappers();
        accountWapper.type = 'Product Account';
        accountWapper.prodAcctPrimaryAcct = 'acct primary';
        accountWapper.prodAcctSecondaryAcct = 'acct secondary';
        accountWapper.prodAcctPegBalance = 'pro balance';
        accountWapper.prodAcctAccountNumber = '1872JHUSGS';
        accountWapper.prodAcctAccountDailyLimit = '10';
        childList.add(accountWapper);
        List<TM_CreateApplicationController.AppilicationProductWrapper> productList = new List<TM_CreateApplicationController.AppilicationProductWrapper>();
        TM_CreateApplicationController.AppilicationProductWrapper prodWapper = new TM_CreateApplicationController.AppilicationProductWrapper();
        prodWapper.childWrappers = childList;
        // Wrapper Info
        prodWapper.productLine = 'Treasury Solutions';
        prodWapper.productType = 'Payable Solutions';
        prodWapper.product = 'ACH Origination';
        prodWapper.fees = 'Standard';
        prodWapper.isBillPayUser = 'Yes';
        prodWapper.acctNumStr = '432235';
        prodWapper.exceptionPricing = '11.123';
        prodWapper.exExpirationDate = null;
        prodWapper.waiveExpirationDate = null;
        prodWapper.billAcctNum = 'Test acct num';
        prodWapper.billInstructions = 'Test Instrucation';
        prodWapper.dailyDepositAmount = '123';
        prodWapper.singleTransactionAmount = '321';
        prodWapper.dailyCheckCount = '5';
        prodWapper.isHaveScanner = '';
        prodWapper.accountId = opportunityList[0].AccountId;
        prodWapper.expandAddMoreCIF = 'Test CIF';
        prodWapper.requestedLimit = '';
        prodWapper.dualControlProcedures = '';
        prodWapper.dualNotes = '';
        prodWapper.isCreditProcessing = '';
        prodWapper.transactionType = '';
        prodWapper.exLstContName = '';
        prodWapper.exLstContPhone = '1234';
        prodWapper.acctNumEnrolled = '';
        prodWapper.positivePayFilterLst = '';
        prodWapper.sampleIssuedCheckFile = '';
        prodWapper.numOriginators = '123';
        prodWapper.bizName = 'enty and title';
        prodWapper.transactionNote = 'JLIEWFNLSKDFJIOWHELRH'; 
        productList.add(prodWapper);       
        
        TM_CreateApplicationController.getOppDetails(opportunityList[0].Id);
        TM_CreateApplicationController.saveApplicationProduct(opportunityList[0].Id, opportunityList[0].AccountId, JSON.serialize(productList));
        test.StopTest(); 
    }

}