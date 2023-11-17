/**
 * @description TM_CreateApplicationController
 */ 
public without sharing class TM_CreateApplicationController {
    /**
     * @description getOppDetails description
     * @param  oppId oppId description
     * @return       return description
     */ 
    @AuraEnabled(cacheable=true)
    public static OppOrtunityWrapper getOppDetails(Id oppId){
        // System.debug('oppId--'+oppId);
        if (oppId == null) {
            return null;
        }
        try {
            // get opportunity info
            Opportunity oppRecord = [SELECT Id, AccountId,RecordTypeId, (SELECT Id, UnitPrice, Quantity, TotalPrice, Product2Id, Product2.Name, Product2.TM_Product__c, Product2.TM_Product_Line__c, Product2.TM_Product_Type__c FROM OpportunityLineItems), (SELECT Id FROM Applications__r) FROM Opportunity WHERE Id = :oppId];
            // get account info
            Account accRecord = [SELECT Id, Name, LLC_BI__Tax_Identification_Number__c,LLC_BI__Tax_Identification_Number_PE__c, CIF__c, Business_Cell_Phone__c, LLC_BI__Naics_Code__c, Relationship_Manager__c, Billing_Address__c, CF_Type__c, TM_Treasury_Officer__c,FinServ__LastFourDigitSSN__pc, TM_Treasury_Officer__r.Name,RecordType.Name FROM Account WHERE Id = :oppRecord.AccountId];
            // opportunity product info
            List<OpportunityLineItem> opptyProducts = oppRecord.OpportunityLineItems;
            // get all price for product
            List<PricebookEntry> pricebookEntry = [SELECT Id, Product2Id, Product2.Name, UnitPrice FROM PricebookEntry WHERE IsActive = true];
            // check if has an application for this product
            Boolean isHasAppProd = false;
            if (oppRecord.Applications__r.size() > 0) {
                isHasAppProd = true;
            }
            // for (OpportunityLineItem item : oppRecord.OpportunityLineItems) {
            //     Product2 prod = new Product2();
            //     prod.Id = item.Product2Id;
            //     prod.Name = item.Product2.Name;
            //     prod.TM_Product__c = item.Product2.TM_Product__c;
            //     prod.TM_Product_Line__c = item.Product2.TM_Product_Line__c;
            //     prod.TM_Product_Type__c = item.Product2.TM_Product_Type__c;
            //     products.add(prod);
            // }
            // List<Product2> products = [SELECT Id, Name FROM Product2];
            // List<Map<String,String>> productOptions = new List<Map<String,String>>();
            // for (Product2 prod : products) {
            //     Map<String, String> prodMap = new Map<String, String>();
            //     prodMap.put('label', prod.Name);
            //     prodMap.put('value', prod.Id);
            //     productOptions.add(prodMap);
            // }
            OppOrtunityWrapper wrapper = new OppOrtunityWrapper(oppRecord, accRecord, opptyProducts, pricebookEntry, isHasAppProd);
            return wrapper;
        } catch (Exception ex) {
            // throw exception
            throw new AuraHandledException(System.Label.TM_StdErrorMessage);
        }
    }

    /**
     * @description saveApplicationProduct description
     * @param  oppId    oppId description
     * @param  accId    accId description
     * @param  appProds appProds description
     */ 
    @AuraEnabled
    public static void saveApplicationProduct(String oppId, String accId, String appProds){
        Savepoint sp = Database.setSavepoint();
        try {
            // System.debug('appProds--'+appProds);
            // System.debug(JSON.deserializeUntyped(appProds) instanceof List<Object>);
            Opportunity opp = [SELECT Id,Name FROM Opportunity WHERE Id = :oppId];
            List<AppilicationProductWrapper> prods = (List<AppilicationProductWrapper>)JSON.deserialize(appProds, List<AppilicationProductWrapper>.class);
            // System.debug('appProds type--'+prods);
            TM_Application__c app = new TM_Application__c();
            app.Name = opp.Name;
            app.TM_Account__c = accId;
            app.TM_Opportunity__c = oppId;
            insert app;
            List<TM_Treasury_Application_Product__c> newProds = new List<TM_Treasury_Application_Product__c>();
            Map<Integer, List<ProductChildWrappers>> childMap = new  Map<Integer, List<ProductChildWrappers>>();
            Map<String, List<ProductChildWrappers>> prodId2childMap = new  Map<String, List<ProductChildWrappers>>();
            Integer num = 0;
            for (AppilicationProductWrapper wrapper : prods) {
                // create new treasury application
                TM_Treasury_Application_Product__c prod = new TM_Treasury_Application_Product__c();
                // product line
                prod.TM_Product_Line__c = wrapper.productLine;
                // product type
                prod.TM_Product_Type__c = wrapper.productType;
                // product
                prod.TM_Product__c = wrapper.product;
                prod.Name = opp.Name + ' - ' + wrapper.product;
                prod.TM_Fees__c = wrapper.fees;
                prod.TM_Is_existing_retail_BillPay_user__c = wrapper.isBillPayUser;
                prod.TM_Account_Number__c = wrapper.acctNumStr;
                if (wrapper.exceptionPricing != null && wrapper.exceptionPricing != '') {
                    // Pricing (Decimal)
                    prod.TM_Exception_Pricing__c = Decimal.valueOf(wrapper.exceptionPricing);
                }
                if (wrapper.exExpirationDate != null && wrapper.exExpirationDate != '') {
                    // String convert to Date
                    prod.TM_Exception_Expiration_Date__c = Date.valueOf(wrapper.exExpirationDate);
                }
                if (wrapper.waiveExpirationDate != null && wrapper.waiveExpirationDate != '') {
                    // String convert to Date
                    prod.TM_Waive_Expiration_Date__c = Date.valueOf(wrapper.waiveExpirationDate);
                }
                prod.TM_Billing_Account_Number__c = wrapper.billAcctNum;
                prod.TM_Billing_Instructions__c = wrapper.billInstructions;
                prod.TM_Daily_Deposit_Amount__c = wrapper.dailyDepositAmount;
                prod.TM_Single_Transaction_Amount__c = wrapper.singleTransactionAmount;
                prod.TM_Daily_Check_Count__c = wrapper.dailyCheckCount;
                // if (wrapper.dailyDepositAmount != null && wrapper.dailyDepositAmount != '') {
                //     // Daily Deposit Amount (Decimal)
                //     prod.TM_Daily_Deposit_Amount__c = Decimal.valueOf(wrapper.dailyDepositAmount);
                // }
                // if (wrapper.singleTransactionAmount != null && wrapper.singleTransactionAmount != '') {
                //     // Daily Deposit Amount (Decimal)
                //     prod.TM_Single_Transaction_Amount__c = Decimal.valueOf(wrapper.singleTransactionAmount);
                // }
                // if (wrapper.dailyCheckCount != null && wrapper.dailyCheckCount != '') {
                //     // Daily Deposit Amount (Decimal)
                //     prod.TM_Daily_Check_Count__c = Decimal.valueOf(wrapper.dailyCheckCount);
                // }
                prod.TM_Customer_have_scanner__c = wrapper.isHaveScanner;
                if (wrapper.accountId != null && wrapper.accountId != '') {
                    prod.TM_Account__c = wrapper.accountId;
                }
                prod.TM_Additional_Accounts_CIF__c = wrapper.expandAddMoreCIF;
                // if (wrapper.requestedLimit != null && wrapper.requestedLimit != '') {
                //     // String convert to Decimal
                //     prod.TM_Requested_limit__c = Decimal.valueOf(wrapper.requestedLimit);
                // }
                prod.TM_Requested_limit__c = wrapper.requestedLimit;
                prod.TM_Dual_control_procedures__c = wrapper.dualControlProcedures;
                prod.TM_Dual_control_procedures_Notes__c = wrapper.dualNotes;
                prod.TM_Have_credit_card_processing__c = wrapper.isCreditProcessing;
                prod.TM_Transaction_type__c = wrapper.transactionType;
                prod.TM_Exceptions_Contact_Name__c = wrapper.exLstContName;
                prod.TM_Exceptions_Contact_Phone__c = wrapper.exLstContPhone;
                prod.TM_Account_Numbers_Enrolled__c = wrapper.acctNumEnrolled;
                prod.TM_Upload_Positive_Pay_Filter_List__c = wrapper.positivePayFilterLst;
                prod.TM_Upload_sample_check__c = wrapper.sampleIssuedCheckFile;
                // if (wrapper.numOriginators != null && wrapper.numOriginators != '') {
                    // String convert to Decimal
                    prod.TM_Number_of_Originators__c = wrapper.numOriginators;
                // }
                // create child info
                if (wrapper.childWrappers != null) {
                    // System.debug('wrapper.childWrappers--'+wrapper.childWrappers);
                    childMap.put(num, wrapper.childWrappers);
                }
                prod.TM_Entity_Signer_Names_and_Titles__c = wrapper.bizName;
                prod.TM_Custom_Transaction_type__c = wrapper.transactionNote;
                prod.TM_Treasury_Application__c = app.Id;
                newProds.add(prod);
                num++;
            }
            // System.debug('newProds--'+newProds);
            insert newProds;
            if (childMap.keySet().size() > 0) {
                for (Integer index : childMap.keySet()) {
                    // bind application product Id to child info
                    prodId2childMap.put(newProds[index].Id, childMap.get(index));
                }
                TM_CreateApplicationController.createChildProduct(prodId2childMap);
            }
            
        } catch (Exception ex) {
            Database.rollback(sp);
            // throw exception
            throw new AuraHandledException(System.Label.TM_StdErrorMessage);
        } 
    }

    /**
     * @description createChildProduct description
     * @param  prodId2childMap prodId2childMap description
     */ 
    public static void createChildProduct(Map<String, List<ProductChildWrappers>> prodId2childMap){
        List<TM_Treasury_Product_ACH_Companies__c> newACHCompanies = new List<TM_Treasury_Product_ACH_Companies__c>();
        List<TM_Treasury_Product_RDC_Scanner__c> newRDCScanners = new List<TM_Treasury_Product_RDC_Scanner__c>();
        List<TM_ProductProfitstarsAccountAccess__c> newRDCPSAAs = new List<TM_ProductProfitstarsAccountAccess__c>();
        List<TM_Treasury_Application_Product_User__c> newprodUsers = new List<TM_Treasury_Application_Product_User__c>();
        List<TM_Treasury_Application_Product_Account__c> newprodAccs = new List<TM_Treasury_Application_Product_Account__c>();
        for (String prodId : prodId2childMap.keySet()) {
            for (ProductChildWrappers childWrapper : prodId2childMap.get(prodId)) {
                if ('ACH Companies'.equals(childWrapper.type)) {
                    // create ACH info
                    TM_Treasury_Product_ACH_Companies__c achCompanies = new TM_Treasury_Product_ACH_Companies__c();
                    achCompanies.Name = childWrapper.achName;
                    achCompanies.TM_Treasury_Application_Product__c = prodId;
                    // if (childWrapper.reACHLimit != null && childWrapper.reACHLimit != '') {
                    //     // String convert to Decimal
                    //     achCompanies.TM_Requested_ACH_Limit__c = Decimal.valueOf(childWrapper.reACHLimit);
                    // }
                    achCompanies.TM_Requested_ACH_Limit__c = childWrapper.reACHLimit;
                    achCompanies.TM_Offset_account__c = childWrapper.achOffsetAcct;
                    achCompanies.TM_Additional_Offset_account__c = childWrapper.achAdditional;
                    achCompanies.TM_Same_Day_ACH__c = childWrapper.achSameDay;
                    achCompanies.TM_Frequency__c = childWrapper.achFrequency;
                    achCompanies.TM_Credits_Debits__c = childWrapper.achCreditsDebits;
                    achCompanies.TM_Transaction_Type__c = childWrapper.achTransaction;
                    achCompanies.TM_Other_Transaction_Type__c = childWrapper.achNote;
                    newACHCompanies.add(achCompanies);
                }else if ('Scanner'.equals(childWrapper.type)) {
                    // create RDC info
                    TM_Treasury_Product_RDC_Scanner__c rdcScanner = new TM_Treasury_Product_RDC_Scanner__c();
                    rdcScanner.TM_Is_scanner_in_stock__c = childWrapper.scannerIsStock;
                    // if (childWrapper.serialNumber != null && childWrapper.serialNumber != '') {
                        rdcScanner.TM_Serial_Number__c = childWrapper.scannerSerialNum;
                    // }
                    rdcScanner.TM_Treasury_Application_Product__c = prodId;
                    newRDCScanners.add(rdcScanner);
                }else if ('Profit Stars Account Access'.equals(childWrapper.type)) {
                    //Create Profitstars Account Access info
                    TM_ProductProfitstarsAccountAccess__c rdcPSAA = new TM_ProductProfitstarsAccountAccess__c();
                    rdcPSAA.Name = childWrapper.psAcctName;
                    rdcPSAA.TM_Account_Name__c = childWrapper.psAcctName;
                    rdcPSAA.TM_Account_Number__c = childWrapper.psAcctNumber;
                    rdcPSAA.TM_Treasury_Application_Product__c = prodId;
                    newRDCPSAAs.add(rdcPSAA);
                }else if ('Product User'.equals(childWrapper.type)) {
                    //Create product user info
                    TM_Treasury_Application_Product_User__c prodUser = new TM_Treasury_Application_Product_User__c();
                    prodUser.Name = childWrapper.adminName;
                    prodUser.TM_Email_Address__c = childWrapper.adminEmail;
                    // if (childWrapper.adminPerDayLimit != null && childWrapper.adminPerDayLimit != '') {
                    //     // String convert to Decimal
                    //     prodUser.TM_Per_day_limit__c = Decimal.valueOf(childWrapper.adminPerDayLimit);
                    // }
                    prodUser.TM_Work_Phone_Number__c = childWrapper.adminWorkNum;
                    prodUser.TM_Cell_Phone_Number__c = childWrapper.adminCellNum;
                    prodUser.TM_Online_Banking_Access__c = childWrapper.adminBankingAccess;
                    // if (childWrapper.adminPerWireLimit != null && childWrapper.adminPerWireLimit != '') {
                    //     // String convert to Decimal
                    //     prodUser.TM_Per_Wire_Limit__c = Decimal.valueOf(childWrapper.adminPerWireLimit);
                    // }
                    prodUser.TM_Per_day_limit__c = childWrapper.adminPerDayLimit;
                    prodUser.TM_Per_Wire_Limit__c = childWrapper.adminPerWireLimit;
                    prodUser.TM_Account_Access__c = childWrapper.adminAcctAccess;
                    prodUser.TM_Authorized_to__c = childWrapper.adminAuthorized;
                    // prodUser.TM_Authorized_to__c = childWrapper.authorizedLst;
                    prodUser.TM_Treasury_Application_Product__c = prodId;
                    newprodUsers.add(prodUser);
                }else if ('Product Account'.equals(childWrapper.type)) {
                    //Create product user info
                    TM_Treasury_Application_Product_Account__c prodAcc = new TM_Treasury_Application_Product_Account__c();
                    // prodAcc.Name = childWrapper.prodAcctPrimaryAcct;
                    // if (childWrapper.prodAcctAccountDailyLimit != null && childWrapper.prodAcctAccountDailyLimit != '') {
                    //     // String convert to Decimal
                    //     prodAcc.TM_Account_Daily_Limit__c = Decimal.valueOf(childWrapper.prodAcctAccountDailyLimit);
                    // }
                    prodAcc.TM_Account_Daily_Limit__c = childWrapper.prodAcctAccountDailyLimit;
                    prodAcc.TM_Account_Number__c = childWrapper.prodAcctAccountNumber;
                    prodAcc.TM_Peg_Balance__c = childWrapper.prodAcctPegBalance;
                    prodAcc.TM_Primary_Child_Account__c = childWrapper.prodAcctPrimaryAcct;
                    prodAcc.TM_Secondary_Parent_Account__c = childWrapper.prodAcctSecondaryAcct;
                    prodAcc.TM_Treasury_Application_Product__c = prodId;
                    if (childWrapper.prodAcctPrimaryAcct != null && childWrapper.prodAcctPrimaryAcct != '') {
                        prodAcc.Name = childWrapper.prodAcctPrimaryAcct;
                    }else if (childWrapper.prodAcctAccountNumber != null && childWrapper.prodAcctAccountNumber != '') {
                        prodAcc.Name = childWrapper.prodAcctAccountNumber;
                    }
                    newprodAccs.add(prodAcc);
                }
            }
        }
        // insert ACH info
        if (newACHCompanies.size() > 0) {
            insert newACHCompanies;
        }
        // insert RDC Scanner info
        if (newRDCScanners.size() > 0) {
            insert newRDCScanners;
        }
        // insert RDC info
        if (newRDCPSAAs.size() > 0) {
            insert newRDCPSAAs;
        }
        // insert User info
        if (newprodUsers.size() > 0) {
            insert newprodUsers;
        }
        // insert Accounts info
        if (newprodAccs.size() > 0) {
            insert newprodAccs;
        }
    }

    /**
     * @description OppOrtunity Wrapper
     */ 
    public class OppOrtunityWrapper{
        @AuraEnabled public Opportunity oppRecord;
        @AuraEnabled public Account accRecord;
        // @AuraEnabled public List<Map<String,String>> productOptions;
        @AuraEnabled public List<OpportunityLineItem> opptyProducts;
        @AuraEnabled public List<PricebookEntry> pricebookEntry;
        @AuraEnabled public Boolean hasAppProd;

        /**
         * @description OppOrtunityWrapper description
         * @param  oppRecord      oppRecord description
         * @param  accRecord      accRecord description
         * @param  opptyProducts  opptyProducts description
         * @param  pricebookEntry pricebookEntry description
         * @param  hasAppProd     hasAppProd description
         * @return                return description
         */ 
        public OppOrtunityWrapper(Opportunity oppRecord, Account accRecord, List<OpportunityLineItem> opptyProducts, List<PricebookEntry> pricebookEntry, Boolean hasAppProd){
            this.oppRecord = oppRecord;
            this.accRecord = accRecord;
            this.opptyProducts = opptyProducts;
            this.pricebookEntry = pricebookEntry;
            this.hasAppProd = hasAppProd;
        }
    }

    /**
     * @description AppilicationProduct Wrapper
     */
    public class AppilicationProductWrapper{
        // Wrapper Info
        public String productLine;
        public String productType;
        public String product;
        public String fees;
        public String isBillPayUser;
        public String acctNumStr;
        public String exceptionPricing;
        public String exExpirationDate;
        public String waiveExpirationDate;
        public String billAcctNum;
        public String billInstructions;
        public String dailyDepositAmount;
        public String singleTransactionAmount;
        public String dailyCheckCount;
        public String isHaveScanner;
        public String accountId;
        public String expandAddMoreCIF;
        public String requestedLimit;
        public String dualControlProcedures;
        public String dualNotes;
        public String isCreditProcessing;
        public String transactionType;
        public String exLstContName;
        public String exLstContPhone;
        public String acctNumEnrolled;
        public String positivePayFilterLst;
        public String sampleIssuedCheckFile;
        public String numOriginators;
        public String bizName;
        public String transactionNote;
        public List<ProductChildWrappers> childWrappers;
    }

    /**
     * @description ProductChild Wrapper
     */
    public class ProductChildWrappers{
        public String type;
        public String name;

        //for ACH Companies
        public String achName;
        public String achOffsetAcct;
        public String achAdditional;
        public String reACHLimit;
        public String achSameDay;
        public String achFrequency;
        public String achCreditsDebits;
        public String achTransaction;
        public String achNote;

        //for RDC Scanner
        public String scannerIsStock;
        public String scannerSerialNum;

        //for RDC Profit Stars Account Access
        public String psAcctName;
        public String psAcctNumber;

        //for Product User
        public String adminName;
        public String adminEmail;
        public String adminPerDayLimit;
        public String adminWorkNum;
        public String adminCellNum;
        public String adminBankingAccess;
        public String adminPerWireLimit;
        public String adminAcctAccess;
        public String adminAuthorized;

        //for Product Account
        public String prodAcctPrimaryAcct;
        public String prodAcctSecondaryAcct;
        public String prodAcctPegBalance;
        public String prodAcctAccountNumber;
        public String prodAcctAccountDailyLimit;

    }
}