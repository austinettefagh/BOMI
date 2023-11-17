@isTest
public class ncno_CoverCTSnapshotTriggers {
    private static String accRecordTypeId = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosByDeveloperName().get('IndustriesBusiness').getRecordTypeId();
	@isTest
    public static void testSSTriggers()
    {  
      nforce.BeanRegistry.getInstance().registerBean(
            ClassTypeProvider.class.getName(),
            nFORCE.ClassTypeProvider.class,
            ClassTypeProvider.class,
            null,
            true
        );
        nforce.BeanRegistry.getInstance().registerBean(
            'nFORCE.EnqueueSnapshot',
            nforce.ACrossPackageService.class,
            mockEnqueueSnapshotService.class
        );
        Id MortgageRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('OPP_nCino_Opportunity').getRecordTypeId();
        Opportunity opportunity_Obj = new Opportunity( RecordTypeId = MortgageRecordTypeId,IsPrivate = false, Name = 'Name662', Description = '7',
                                                      StageName = 'Prospecting', Probability = 10, CloseDate = Date.today(), 
                                                      Type = 'Existing Business', NextStep = 'NextStep764', 
                                                      LeadSource = 'Advertisement', ForecastCategoryName = 'Omitted', 
                                                      Pricebook2Id = Test.getStandardPricebookId());
        Insert opportunity_Obj; 
        
        Account accRecord = new Account();
        accRecord.Name = 'Test Account';
        accRecord.RecordTypeId = accRecordTypeId;
        Insert accRecord;      
       
        LLC_BI__Deposit__c dep = new LLC_BI__Deposit__c();
        dep.LLC_BI__Account__c = accRecord.Id;
        dep.LLC_BI__Amount__c = 8675309;
        
        insert dep;
        
        LLC_BI__Deposit__c dep2 = new LLC_BI__Deposit__c();
        dep2.LLC_BI__Account__c = accRecord.Id;
        dep2.LLC_BI__Amount__c = 8675309;
        
        insert dep2;
        
      	LLC_BI__Product_Feature__c pf = new LLC_BI__Product_Feature__c();
        pf.LLC_BI__Is_Automated_Clearing_House_Service__c = true;
        pf.LLC_BI__Is_Reconciliation_Service__c = true;
        insert pf;
 		
        LLC_BI__Product_Line__c productLine = new LLC_BI__Product_Line__c(
            Name = 'TestPL',
            LLC_BI__lookupKey__c = '213452345',
            LLC_BI__Product_Object__c = LLC_BI__Loan__c.sObjectType.getDescribe().getLocalName()
        );        
        insert productLine;
        
        LLC_BI__Product_Type__c productType = new LLC_BI__Product_Type__c(
            Name = 'TestPT',
            LLC_BI__lookupKey__c = '34563456',
            LLC_BI__Usage_Type__c = 'Loan',
            LLC_BI__Product_Line__c = productLine.Id
        );
        insert productType;        
        LLC_BI__Product__c product = new LLC_BI__Product__c(
                Name = 'TestP',
                LLC_BI__lookupKey__c = 'asdf',
                LLC_BI__Product_Feature__c = pf.Id,
                LLC_BI__Product_Type__c = productType.Id
        );
        insert product;  
        
		LLC_BI__Product__c productDT2 = [SELECT ID FROM LLC_BI__Product__c LIMIT 1];
        LLC_BI__Treasury_Service__c ts = new LLC_BI__Treasury_Service__c();
        ts.LLC_BI__Relationship__c = accRecord.Id;
        ts.LLC_BI__Product_Reference__c = product.Id;
        insert ts;
            
        CO_Treasury_Product_Fraud_Solutions__c ctp = new CO_Treasury_Product_Fraud_Solutions__c();
        ctp.CF_Account_Name__c = accRecord.Id;
        ctp.CF_Active__c =true;
        ctp.CF_Deposit_Account_Name__c = dep.Id;
        ctp.CF_Treasury_Service__c = ts.Id;
        insert ctp;
        
        TM_Treasury_Product_ACH_Companies__c tca = new TM_Treasury_Product_ACH_Companies__c();
        tca.CF_Active__c = true;
        tca.CF_Offset_Account__c = dep.Id;
        tca.CF_Treasury_Service__c = ts.Id;
        insert tca;
        
        CO_Treasury_Product_Wire_Accounts__c ctpw = new CO_Treasury_Product_Wire_Accounts__c();
        ctpw.CF_Account_Number__c = dep.Id;
        ctpw.CF_Treasury_Service__c = ts.Id;
		insert ctpw;
        
        CO_Temporary_Limit_Changes__c ctlc = new CO_Temporary_Limit_Changes__c();
        ctlc.CF_Relationship_Name__c =  accRecord.Id;
        ctlc.CF_Treasury_Service_Name__c = ts.Id;
        
        insert ctlc;
        
		//Added 08/28 to cover CT_SetupInformationTrigger
        CO_Treasury_Product_Management_Solutions__c ctsit = new CO_Treasury_Product_Management_Solutions__c();
        ctsit.CF_Account_Name__c =  accRecord.Id;
        ctsit.CF_Treasury_Service__c = ts.Id;
        
        insert ctsit;
        
        CO_Treasury_Product_RDC_Lockbox__c ctsif = new CO_Treasury_Product_RDC_Lockbox__c();
        ctsif.CF_Treasury_Service__c = ts.Id;
        
        insert ctsif;
        // End 08/28
        
        CO_Sweep_Setup__c css = new CO_Sweep_Setup__c();
        css.CF_Active__c = true;
        css.CF_Primary_Child_Account__c  = dep.Id;
        css.CF_Secondary_Parent_Account__c  = dep2.Id;
        insert css;
        Test.startTest();
         
        ctp.CF_Payee_Name_Verification__c = 'Yes';
        Database.update(ctp);
        
        tca.TM_Credits_Debits__c = 'Credits only';
        Database.update(tca);
            
        ctpw.CF_Account_Daily_Limit__c = 12313;
        Database.update(ctpw);
        
        ctlc.CF_Approval_Status__c = 'Approver 1 Approved';
        Database.update(ctlc);
        
        css.CF_Active__c = false;
        Database.update(css);
        
        ctsit.CF_Active__c = false;
        Database.update(ctsit);
        
        ctsif.CF_Active__c = false;
        Database.update(ctsif);
        
        Test.stopTest();
    }
    
}