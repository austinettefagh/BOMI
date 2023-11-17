/** 
 * This is main eTran Service Helper class
 * Date               User               Change 
 * 8/20/2021          PwC               Initial Version
 * 
 * This class makes checks the input validation and featches all the records that needs to be sent to eTran
*/

public without sharing class WS_eTranServiceHelper {

    public static list<String> primaryBusinessFields = new list<string>{
            'NumberOfEmployees',
            'nSBA__Business_Age__c',
            'ShippingCity',
            'ShippingPostalCode',
            'ShippingState',
            'ShippingStreet',
            'ShippingCountry',
            //'Tax_ID__c',
            'LLC_BI__Tax_Identification_Number_PE__c', //Replaced above
            //'Select_Your_Business_Entity_Type__c',
            'Type',
            'nSBA__Control_Interest_Type__c'
            };
        
        public static list<String> accountFields = new list<string>{
            'ShippingCity',
            'ShippingPostalCode',
            'ShippingState',
            'ShippingStreet',
            'ShippingCountry',
            //'Tax_ID__c',
            'LLC_BI__Tax_Identification_Number_PE__c', //Replaced above                
            //'Select_Your_Business_Entity_Type__c',
            'Type',
            'nSBA__Control_Interest_Type__c'
    };
    
        public static list<String> pAccountFields = new list<string>{
            'ShippingCity',
            'ShippingPostalCode',
            'ShippingState',
            'ShippingCountry',
            'ShippingStreet',
            'nSBA__Control_Interest_Type__c',
            //'LLC_BI__SS__pc'
            'LLC_BI__SS_PE__pc'
                
                };

    public static list<String> applicationFields = new list<string>{
        'Id'
    };
        
     public static list<String> uopFields = new list<string>{
       // 'nSBA__Proceed_Type_Code__c',
        'nSBA__Loan_Proceed_Type_Code__c'
    };
    
    public static list<String> uciFields = new list<string>{
        'nSBA__Reason_Code__c'
    };

    public static list<String> loanFields = new list<string>{
            'LLC_BI__Amount__c',
            'LLC_BI__Amortized_Term_Months__c',
            'LLC_BI__InterestRate__c',
            'LLC_BI__SBA_Guarantee__c',
            'LLC_BI__Monthly_Payment__c',
            'LLC_BI__Term_Months__c',
            'LLC_BI__Interest_Only_Months__c',
            'nSBA__Base_Interest_Rate__c',
            'Name'
    };

    /* Commented as part of Primary Contacts replacement with Person Accounts
    public static list<String> contactFields = new list<string>{
            'FirstName',
            'LastName',
            //'OwnershipPercentage__c',
            'Phone',
            'nSBA__Veteran_Status__c',
            'nSBA__Gender__c',
            'nSBA__US_Citizen__c'
            };
    --End-- Primary Contacts replacement with Person Accounts*/
        
	// Added this block part of Person Account implementation to replace Contacts
    public static list<String> persAccountsFields = new list<string>{
            'FirstName',
            'LastName',
            //'OwnershipPercentage__c',
            'Phone',
            'nSBA__Veteran_Status__pc',
            'nSBA__Gender__pc',
            'nSBA__US_Citizen__pc'
            };                

    // Added new validation block
    public static list<String> connectionFields = new list<string>{
        'LLC_BI__Ownership_Percent__c'
    };

    public static CM_EtranConfigurationSetting__mdt getMetadata() {
        CM_EtranConfigurationSetting__mdt metadata = new CM_EtranConfigurationSetting__mdt();
        if (Test.isRunningTest()) {
            metadata = new CM_EtranConfigurationSetting__mdt(
                TECH_CLSPassword__c='test',
                TECH_CLSUsername__c='test',
                TECH_EMail__c='test',
                TECH_Endpoint__c='test',
                TECH_FormatIn__c='test',
                TECH_FormatOut__c='test',
                TECH_LenderCntctFirstName__c='test',
                TECH_LenderCntctLastName__c='test',
                TECH_LenderCntctPhnNmb__c='test',
                TECH_LocationId__c='test',
                TECH_SoftwareVendorName__c='test',
                TECH_Version__c='test',
                TECH_Timeout__c=10000,
                TECH_UsePlatformEncryptionFields__c=false,
                TECH_UseServiceAccount__c=true, 
                TECH_LenderCntctFax__c = 'test'
            );
        } else {
            metadata = [
                SELECT
                TECH_CLSPassword__c,
                TECH_CLSUsername__c,
                TECH_EMail__c,
                TECH_Endpoint__c,
                TECH_FormatIn__c,
                TECH_FormatOut__c,
                TECH_LenderCntctFirstName__c,
                TECH_LenderCntctLastName__c,
                TECH_LenderCntctPhnNmb__c,
                TECH_LocationId__c,
                TECH_ACHAccountNumber__c,
                TECH_ACHAccountType__c,
                TECH_BankTaxId__c,
                TECH_RoutingNumber__c,
                TECH_SoftwareVendorName__c,
                TECH_Version__c,
                TECH_Timeout__c,
                TECH_UsePlatformEncryptionFields__c,
                TECH_UseServiceAccount__c,
                TECH_SoftwareVendorCode__c, TECH_CLSPIN__c,
                TECH_LenderCntctTitle__c, 
                TECH_LenderCntctFax__c,
                TECH_Type_of_SBA__c
                FROM
                CM_EtranConfigurationSetting__mdt WHERE DeveloperName = 'eTran_Configuration'
                LIMIT 1
            ];
        }

        return metadata;
    }
        
    public static List<EtranCredential__c> getCredentials(){
        List<EtranCredential__c> etranCred = [
            SELECT Id, TECH_CLSUsername__c, TECH_CLSPassword__c, TECH_CLSPin__c
            FROM EtranCredential__c
            WHERE TECH_SFUsername__c = :UserInfo.getUserName() LIMIT 1];
        
        return etranCred;
    }
        
    public static LLC_BI__Application__c getApp(String Id) {
        LLC_BI__Application__c application = [
            SELECT 
                Id,
                Name, 
                nsba__Business_Acquisition_Asset__c,
                nSBA__Borrower_Injection_Total__c,
                nSBA__Application_Number__c,
                nSBA__Is_Agent_Involved__c,
                nSBA__SBA_Loan_Number__c,
                nSBA__Is_Collateralized__c,
                nSBA__Injection_Indication__c,
                nSBA__Loan_Package_Source__c,
                nSBA__Loan_Packager_Zipcode__c,
                nSBA__Loan_Packager_Street__c,
                nSBA__Loan_Packager_State__c,
                nSBA__Loan_Packager_Name__c,
                nSBA__Loan_Packager_City__c,
                nSBA__Special_Purpose_Loan_Code__c,
                nSBA__Any_Individual_On_Parole_Or_Probation__c,
                nSBA__SBA_Underwriting_required__c,
                nSBA__First_Rate_Adjustment_Date__c,
                nSBA__No_GS13_Government_Employee_10_Pct_Owner__c,    // Added newly 
            	//Added below fields to pass Agent Info
            	nSBA__Form_159_Business_Name_of_Agent__c,
            	nSBA__Form_159_Agent_Contact_Person__c,
            	nsba__Form_159_Agent_Type__c,
                nsba__Total_Compensation_Charged_To_Applicant__c,
                nsba__Form_159_Is_Fee_Paid_By_Applicant__c,
                nsba__Form_159_Service_Type__c,
                nSBA__Form_159_Agent_Business_Street__c,
                nSBA__Form_159_Agent_Business_City__c,
                nSBA__Form_159_Agent_Business_State_2__c,
                nSBA__Form_159_Agent_Business_Zipcode__c,
                nSBA__Form_159_Business_Name_of_Referral_Agent__c,
                CF_Referral_Agent_Contact_Person__c,
                nSBA__Form_159_Referral_Agent_Business_Street__c,
                nSBA__Form_159_Referral_Agent_Business_City__c,
                nSBA__Form_159_Referral_Agent_Business_State__c,
                nSBA__Form_159_Referral_Agent_Business_Zipcode__c,
            	CF_Amount_Paid_by_Applicant__c,
                CF_Amount_Paid_by_SBA_Lender__c,
                nSBA__SBA_Processing_Method__c //Added on 09/08/2022 as requested by Loren
            FROM  
                LLC_BI__Application__c
            WHERE
                Id = :Id
        ];
        return application;
    }

    public static List<nSBA__Use_Of_Proceeds__c> getUseOfProceed(String Id) {
        List<nSBA__Use_Of_Proceeds__c> uopRec = [
            SELECT 
                Id,
                Name,
                nSBA__Proceed_Type_Code__c,
                nSBA__Loan_Proceed_Type_Code__c,  //Eqvivalent to LoanProceedTypeCd__c
                nSBA__Proceed_Amount__c,
                nSBA__Proceed_Other_Type_Text__c,
                nSBA__Purchase_Agreement_Date__c,
                nSBA__Intangible_Asset_Amount__c,
                nSBA__Intangible_Asset_Description__c,
                nSBA__Stockholder_Name__c
            FROM  
                nSBA__Use_Of_Proceeds__c
            WHERE
                nSBA__Application__c = :Id
        ];
        return uopRec;
    }

    public static LLC_BI__Loan__c getLoan(String Id) {
        LLC_BI__Loan__c loan = [
            SELECT 
                Id,
                Name,
                LLC_BI__Account__c,
                LLC_BI__Product_Package__c,
                LLC_BI__Amount__c,
                LLC_BI__Amortized_Term_Months__c,
                LLC_BI__Total_Monthly_Payments__c,
                LLC_BI__InterestRate__c,
                nSBA__ETran_Lender_Contact__c,
                nSBA__ETran_Lender_Contact__r.email,
                nSBA__ETran_Lender_Contact__r.firstName,
                nSBA__ETran_Lender_Contact__r.LastName,
                nSBA__ETran_Lender_Contact__r.fax,
                nSBA__ETran_Lender_Contact__r.mobilephone,
                nSBA__ETran_Lender_Contact__r.phone,
                LLC_BI__Application__r.nSBA__Lender_Service_Provider_Name_Suffix__c,    //Eqvivalent to nSBA__ETran_Lender_Contact__r.suffix
                nSBA__ETran_Lender_Contact__r.title,
                LLC_BI__Application__r.nSBA__Lender_Service_Provider_Middle_Name__c,    //Eqvivalent to nSBA__ETran_Lender_Contact__r.middlename
                LLC_BI__Lookupkey__c,
                LLC_BI__Term_Months__c,
                LLC_BI__Payment_Type__c,
                LLC_BI__Interest_Only_Months__c,
                LLC_BI__Monthly_Payment__c,                                             //Replaced Principal_and_Interest_Payment_Amount__c
                LLC_BI__Rate_Ceiling__c,
                LLC_BI__Rate_Floor__c,
                LLC_BI__Payment_Schedule__c,
                nSBA__Base_interest_Rate__c,
                LLC_BI__Application__r.nSBA__Resubmission__c,                            //Eqvivalent to Resubmission__c which was on account 
                LLC_BI__Application__r.nSBA__Is_EPC_Type_Of_Business_Eligible__c,        //Eqvivalent to Applicant_Business_an_EPC__c which was on account 
                LLC_BI__Application__r.nSBA__Is_OC_Eligible_Small_Business__c,           //Eqvivalent to Applicant_Business_An_OC__c which was on account 
                LLC_BI__Application__r.nSBA__Jobs_Created__c,                            //Eqvivalent to Jobs_Created__c,        
                LLC_BI__Application__r.nSBA__Jobs_Retained__c,                           //Eqvivalent to Jobs_Retained__c,  
                LLC_BI__SBA_Guarantee__c,                                                // Added newly 
                LLC_BI__Pricing_Basis__c,                                                  // Added newly 
            	LLC_BI__Interest_Rate_Adjustment_Frequency__c, //Added by Jayanth for Calendar quarterly
            	//LLC_BI__Payment_Schedule__c, //Added by Jayanth for payment schedule quarterly, etc.
                e2e_Special_Payment_Series_Comments__c                                              
            FROM     
                LLC_BI__Loan__c
            WHERE
                LLC_BI__Application__c = :Id
        ];
        return loan;
    }

    public static List<Account> getAccount(Set<String> Ids) {
        List<Account> account = [
            SELECT 
                Id,
                Name,
                BillingCity,
                BillingPostalCode,
                BillingState,
                BillingStreet,
                ShippingCity,
                ShippingPostalCode,
                ShippingState,
                ShippingStreet,
                //Tax_ID__c,             //replaced TIN__c
            	LLC_BI__Tax_Identification_Number_PE__c, //Replaced Tax_ID__c
                //Select_Your_Business_Entity_Type__c,                //Replaced EntityType__c
            	Type,
                nSBA__No_Member_of_Congress_Owns_10_Percent__c, 
                ShippingCountry,    
                nSBA__Prior_SBA_Loan__c,
                NumberOfEmployees,
                Phone,
                cm_Industry_Code__c,                                 // Eqvivalent to NaicsCode__c, JJ switched this to cm_Industry_Code__c
                cm_Industry_Code__r.name,                             // Eqvivalent to  NaicsCode__r.Name,
                nSBA__Business_Age__c,
                nSBA__Franchise_Code__c,
                nSBA__Franchise_Name__c,
                nSBA__Date_Of_Establishment__c,                     //Eqvivalent to DateEntityWasFormed__c, 
                nSBA__Net_Export_Amount__c,
                nSBA__Bankruptcy__c,
                nSBA__No_SBA_Employee_Owns_10_Percent_Or_More__c,
                nSBA__Duns_Number__c,
                nSBA__Business_Has_Outstanding_Debt__c,
                nSBA__Control_Interest_Type__c,
                nSBA__Primary_Bank_Name__c,
                nSBA__Date_Of_Current_Ownership_Establishment__c,
                nSBA__Exporter__c,
                nSBA__External_Credit_Score_Date__c,
                nSBA__External_Credit_Score__c,
                nSBA__Revenues_From_Gambling_Or_Sexual_Nature__c,
                nSBA__Current_Lawsuit__c,
                nSBA__DBA__c,
                nSBA__Rural_Urban_Indicator__c,
                nSBA__Prior_Government_Loan__c,                      //Added new  
                nSBA__Federal_Employee__c,                            //Added new 
            	//Added below Fields for Person Accounts instead of contacts
            	//LLC_BI__SS__pc, // This field is used in TBoM for person account ssn
            	LLC_BI__SS_PE__pc,
                FirstName,
                LastName,
                PersonEmail,
                nsba__Alien_Registration_Number__pc,
            	nSBA__Birth_City__pc,
            	nSBA__Birth_Country__pc,
            	PersonBirthdate,
            	nSBA__Birth_State__pc,
		        LLC_BI__Country_of_Citizenship__pc,
            	nSBA__Convicted_Criminal__c,
            	nSBA__Ethnicity__pc,
            	nSBA__Fingerprint_Waived_Date__c,
                nSBA__Gender__pc,
                nSBA__Insurance_Amount__c,
                nSBA__Disability_Insurance__c,
                nSBA__Disability_Insured_Names__c,
                nSBA__Insured_Name__c,          
                nSBA__Presently_Involved_In_Any_Legal_Action__pc,
                MiddleName,
                Suffix,
                nSBA__Business_Experience_Years__c,
            	PersonTitle,
            	nSBA__US_Citizen__pc,
            	nSBA__Veteran_Status__pc,
                nSBA__Is_Certified_Veteran__pc,
                nSBA__Race__pc,                      
            	nSBA__External_Credit_Score_Source__c, // end of Person Account fields 
            	//Added below 2 fields for country of citizenship logic
            	CF_Country_of_Citizenship__c,
            	CF_US_Citizenship_Status__c
            FROM  
                Account
            WHERE
                Id in :Ids
        ];
        return account;
    }

	/* Commented to replace Contacts by Person Accounts  
 	public static list<Contact> getContacts(Set<String> Ids) {
        list<Contact> contacts = [
            SELECT 
                Id,
                Name,
                AccountId,
                Account.Tax_ID__c,  //Eqvivalent to Account.SSN__c
                FirstName,
                LastName,
                email,
                Phone,
               //OwnershipPercentage__c, //SAN
                nsba__Alien_Registration_Number__c,
                LLC_BI__Home_Address__c,
                LLC_BI__Home_City__c,
                LLC_BI__Home_State__c,
                LLC_BI__Home_Zipcode__c,
                LLC_BI__SS__c,
                nSBA__Birth_City__c,
                nSBA__Birth_Country__c,
                Birthdate,
                nSBA__Birth_State__c, 
                Account.Select_Your_Business_Entity_Type__c,            // Replaced Account.EntityType__c
                Account.nSBA__Control_Interest_Type__c,
                Account.nSBA__Convicted_Criminal__c,
                Account.nSBA__External_Credit_Score_Source__c,
                account.nSBA__External_Credit_Score__c,
                account.nSBA__External_Credit_Score_Date__c, 
                nSBA__Ethnicity__c,
                nSBA__Gender__c,
                Account.nSBA__Bankruptcy__c,
                Account.nSBA__Fingerprint_Waived_Date__c,
                Account.nSBA__Insurance_Amount__c,
                Account.nSBA__Disability_Insurance__c,
                Account.nSBA__Disability_Insured_Names__c,
                Account.nSBA__Insured_Name__c,
                Account.nSBA__Current_Lawsuit__c,
                Account.ShippingCity,
                Account.ShippingCountry,
                Account.ShippingPostalCode,
                Account.ShippingState,
                Account.ShippingStreet,
                Title,
                nSBA__US_Citizen__c,
                nSBA__Is_Certified_Veteran__c,
                nSBA__Veteran_Status__c,
                nSBA__Race__c,
                Account.nSBA__Business_Experience_Years__c,
                nSBA__Presently_Involved_In_Any_Legal_Action__c,        // Eqvivalent to Account.Legal_Action__c 
                LLC_BI__Country_of_Citizenship__c,                      // Eqvivalent to Account.Citizenship__c
                Account.MiddleName,                             // Eqvivalent to contact middlename
                Account.Suffix,                                   // Eqvivalent to contact Suffix
                Account.nSBA__Federal_Employee__c                       // Added new 
            FROM  
                Contact
            WHERE
                AccountId IN :Ids AND LLC_BI__Primary_Contact__c = True
        ];
        return contacts;
    }
	 -End- Commented to replace Contacts by Person Accounts  */
    
    public static list<nSBA__Change_Of_Ownership__c> getCOO(String Id) {
        list<nSBA__Change_Of_Ownership__c> changeOfOwner = [
            SELECT Id,
                Name,
                nSBA__Total_Accounts_Receivable__c,
                nSBA__Appraiser_Fee__c,
                nSBA__Appraiser_Name__c,
                nSBA__Broker_Address__c,
                nSBA__Broker_Commission__c,
                nSBA__Broker_Name__c,
                nSBA__Borrower_Equity_Amount__c,
                nSBA__Buyer_Equity_Cash__c,
                nSBA__Buyer_Equity_Cash_Description__c,
                nSBA__Other_Equity_Amount__c,
                nSBA__Other_Equity_Description__c,
                nSBA__Client_List_Value__c,
                nSBA__Franchise_Value__c,
                nSBA__Goodwill_Value__c,
                nSBA__Total_Intangible_Assets__c,
                nSBA__Total_Inventory__c,
                nSBA__License_Value__c,
                nSBA__Total_Other_Assets__c,
                nSBA__Total_Other_Assets_Description__c,
                nSBA__Other_Intangibles_Value__c,
                nSBA__Other_Intangibles_Description__c,
                nSBA__Total_Real_Estate__c,
                nSBA__Seller_Finance_Full_Standby__c,
                nSBA__Seller_Finance_Not_Full_Standby__c,
                nSBA__Total_Appraised_Value__c,
                nSBA__Real_Estate_Evaluation_Type__c,
            	CF_7_a_Loan__c		//Added new field to capture the amount similar to LaserPro
            FROM  
                nSBA__Change_Of_Ownership__c
            WHERE
                nSBA__Application__c = :Id
        ];
        return changeOfOwner;
    }

    public static list<nSBA__Unavailable_Credit_Information__c> getUCI(String Id) {
        list<nSBA__Unavailable_Credit_Information__c> unCreditInfo = [
            SELECT Id,
                Name,
                nSBA__Reason_Code__c,
                nSBA__Reason_Comment__c
            FROM  
                nSBA__Unavailable_Credit_Information__c
            WHERE
                nSBA__Associated_Loan_Application__c = :Id
        ];
        return unCreditInfo;
    }

    public static list<nSBA__Injections__c> getInjection(String Id) {
        list<nSBA__Injections__c> injectRec = [
            SELECT Id,
                Name,
                nSBA__Injection_Other_Description__c,
                nSBA__Injection_Type_Code__c,                                  //Added new
                nSBA__Injection_Amount__c
                //SourceType__c  //SAN
            FROM  
                nSBA__Injections__c
            WHERE
                nSBA__Application__c = :Id
        ];
        return injectRec;
    }

    public static list<LLC_BI__Legal_Entities__c> getLegalEntities (String Id) {
        list<LLC_BI__Legal_Entities__c> LegalEntities = [
            SELECT 
                Id, 
                LLC_BI__Loan__c,  
                nSBA__Guarantor_Type__c,
                LLC_BI__Entity_Type__c,
                LLC_BI__Account__c
            FROM 
                LLC_BI__Legal_Entities__c  
            WHERE 
                LLC_BI__Loan__c =: Id AND (LLC_BI__Borrower_Type__c = 'Borrower' OR LLC_BI__Borrower_Type__c = 'Co-Borrower')
        ];
        return LegalEntities;
    }

    public static list<LLC_BI__Connection__c> getConnections(Set<String> Ids) {
        list<LLC_BI__Connection__c> connections = [
            SELECT 
                Id,
                Name,
                LLC_BI__Connected_To__c,
                LLC_BI__Ownership_Percent__c,
                LLC_BI__Connected_From__c,
                E2E_Role__c
            FROM  
                LLC_BI__Connection__c
            WHERE
                //LLC_BI__Connected_From__c IN :Ids AND LLC_BI__Connection_Role__r.Name = 'Principal Owner'
                LLC_BI__Connected_From__c IN :Ids AND LLC_BI__Connection_Role__r.Name = 'Owner'
        ];
        return connections;
    }
    // Added new logic for Gurantor Type
    public static Set<Id> collManagementRecList = new Set<Id>();
    public static List<LLC_BI__Loan_Collateral2__c> getCollateral(String Id){
        List<LLC_BI__Loan_Collateral2__c> collateralList = new List<LLC_BI__Loan_Collateral2__c>();
        // Added Cash Secured Life Insurance CI ABL
        RecordType lifeInsuranceRec = [SELECT Id From RecordType WHERE SObjectType = 'LLC_BI__Collateral__c' AND DeveloperName = 'Collateral_Mgmt_UCC' LIMIT 1]; 
        for(LLC_BI__Loan_Collateral2__c col : [SELECT Id,LLC_BI__Collateral__r.LLC_BI__Life_Insurance_Policy_Number__c,
                                               LLC_BI__Collateral__r.RecordTypeID ,LLC_BI__Collateral__c
             FROM LLC_BI__Loan_Collateral2__c WHERE LLC_BI__Loan__c =: Id]){
                 collManagementRecList.add(col.LLC_BI__Collateral__c);
                 if(col.LLC_BI__Collateral__r.RecordTypeID == lifeInsuranceRec.Id)
                    collateralList.add(col);
             }
        return collateralList;
    }
    
    public static Set<Id> getCollateralOwnership(){
        Set<Id> collateralOwneAccount = new Set<Id>();
        if(collManagementRecList.size() > 0){
            for(LLC_BI__Account_Collateral__c col : [SELECT Id,LLC_BI__Account__c
                                                     FROM LLC_BI__Account_Collateral__c WHERE LLC_BI__Collateral__c IN: collManagementRecList]){
                 collateralOwneAccount.add(col.LLC_BI__Account__c);
             }
        }
        return collateralOwneAccount;
    }
    
    //Not in use , Data will be fectched from loan object 
   /* public static List<SBAGuarantyCalculator__c> getGuarantyCal(String Id){
        List<SBAGuarantyCalculator__c> getGuarantyCal = [SELECT Id,SelectedSetupGty__c,MaximumGuaranty__c FROM SBAGuarantyCalculator__c 
                                                            WHERE Facility__c =: Id LIMIT 1];
        return getGuarantyCal;
    } */
    
    public static List<LLC_BI__Pricing_Rate_Component__c> getPriceRateComp(String Id){
        List<LLC_BI__Pricing_Rate_Component__c> priceRateComp = [SELECT Id,LLC_BI__Is_Fixed__c FROM LLC_BI__Pricing_Rate_Component__c
                                                                 WHERE LLC_BI__Pricing_Stream__r.LLC_BI__Loan__c =: Id LIMIT 1]; 
                                                                        // Replaced LLC_BI__Pricing_Stream__r.Facility__c 
        return priceRateComp;
    }
    
    public static void validateInput(String objectName, Object input, list<string> fields, WS_eTranServiceInvocableResponse output, String RecordName, String navigation){
        Map<String,Schema.SObjectType> sobjectMap = schema.getGlobalDescribe();
        Schema.SObjectType objSchema = sobjectMap.get(objectName);
        Map<String,Schema.SObjectField> fieldMap = objSchema.getDescribe().fields.getMap();
        
        Map<String, Object> attributeValueMap = (Map<String, Object>)JSON.deserializeUntyped(JSON.serialize(input));
        List<String> emptyFields = new List<string>();
        for (string field : fields) {
            if (attributeValueMap.keySet().contains(field) == false &&
               fieldMap.containsKey(field)) {
                emptyFields.add(fieldMap.get(field).getDescribe().getLabel());
            }
        }
        if(!emptyFields.isEmpty())
            output.errors += '\nThe following fields are blank for ' + objSchema.getDescribe().getLabel() + ' - '+ 
                                            RecordName + '\n'+ emptyFields +'\n Navigation: '+navigation+'\n\n';
    }

    public static String createRequestBody(CM_EtranConfigurationSetting__mdt metadata, WS_eTranServiceInvocableRequest input, 
                                            WS_eTranServiceInvocableResponse output) 
    {
        LLC_BI__Application__c application = getApp(input.appId);
        LLC_BI__Loan__c loan = getLoan(application.Id);
        Map<Id,String> accRecMap = new Map<Id,String>();
        Map<String,String> princAccountIds = new Map<String,String>();
        Set<String> busAccountIds = new Set<String>();
        Set<String> pAccountIds = new Set<String>();
        
        for(LLC_BI__Legal_Entities__c legalEntity: [SELECT Id, LLC_BI__Account__c,
                                                    LLC_BI__Account__r.RecordType.Name, 
        											LLC_BI__Loan__c,
                                                    LLC_BI__Borrower_Type__c
                                                    FROM LLC_BI__Legal_Entities__c 
                                                    WHERE LLC_BI__Loan__c =: loan.Id AND (LLC_BI__Borrower_Type__c = 'Borrower' OR LLC_BI__Borrower_Type__c = 'Co-Borrower' )]){
                busAccountIds.add(legalEntity.LLC_BI__Account__c);
           }

           list<LLC_BI__Connection__c> connections =  getConnections(busAccountIds);
           for(LLC_BI__Connection__c connectionRecord: connections){
            pAccountIds.add(connectionRecord.LLC_BI__Connected_To__c);
        }
        Account primaryBAcc = getAccount(new Set<String> {loan.LLC_BI__Account__c})[0];
        List<Account> accounts = getAccount(busAccountIds);
        //Added connections 
        List<Account> pAccounts = getAccount(pAccountIds);
//JJ        list<Contact> contacts = getContacts(pAccountIds);
		List<Account> persAccounts = getAccount(pAccountIds);
        List<nSBA__Unavailable_Credit_Information__c> unCreditInfo = getUCI(input.appId);
        List<nSBA__Change_Of_Ownership__c> changeOfOwnership = getCOO(input.appId);
        List<nSBA__Injections__c> injectionRecords = getInjection(input.appId);
        List<nSBA__Use_Of_Proceeds__c> useOfProceedRec = getUseOfProceed(input.appId);
        List<LLC_BI__Loan_Collateral2__c> collateralRec = getCollateral(loan.Id);
       //List<SBAGuarantyCalculator__c> guarantyCal = getGuarantyCal(loan.Id);             //Fetching Data from Loan
        List<LLC_BI__Pricing_Rate_Component__c> priceRateCompList = getPriceRateComp(loan.Id);
        Set<Id> collateralOwnRecords = getCollateralOwnership();
        List<LLC_BI__Legal_Entities__c> legalEntityRecord = getLegalEntities(loan.Id);
            
        string request;
        List<EtranCredential__c> credentials = getCredentials();
        
        if(metadata.TECH_UseServiceAccount__c && credentials.size() <= 0){
            output.errors = 'Please contact your system administrator to set up your eTran credentials in nCino.';
        }
        else if(input.method != 'OrigUpdate' && 
           String.isNotBlank(application.nSBA__Application_Number__c)){
            output.errors = 'Application number is already generated.\n\n';
        }
        else{
            validateInput('LLC_BI__Application__c' , application, applicationFields , output, application.Name, '');
            validateInput('LLC_BI__Loan__c', loan, loanFields , output, loan.Name,'Please navigate to Loan Application or Pricing route and populate the required fields.');
            for (Account acc : accounts) {
                if(acc.Id == loan.LLC_BI__Account__c){
                    validateInput('Account', acc, primaryBusinessFields , output, acc.Name, 'Please navigate to customer record, SBA Etran Fields section to populate the required fields.');
                }
                else
                    validateInput('Account', acc, accountFields , output, acc.Name, 'Please navigate to customer record, SBA Etran Fields section to populate the required fields.');
            }
            if(pAccounts.size() <= 0)
                output.errors += 'Principal is required.\n Navigation : Please navigate to Borrowing Structure route to add it to the facility. \n\n';
            else{
                for (Account acc : pAccounts) {
                validateInput('Account', acc, pAccountFields, output, acc.Name, 'Please navigate to customer record, SBA Etran Fields section to populate the required fields.');
                }
            }

			/* Commented to replace contacts with Person Account
             if(contacts.size() <= 0)
                output.errors += 'Primary Contact is required on Principals.\n';
            else{
                for (Contact contact : contacts) {
                	validateInput('Contact', contact, contactFields, output, contact.Name, 'Please navigate to contact record, Etran Required Fields section to populate the required fields.');
            	}
            } --End--- Commented to replace contacts with Person Account */
			
            //Added below logic to replace Primary Contact with Person Account
            if(persAccounts.size() <= 0)
                output.errors += 'Person Account is required to be added as Owner.\n';
            else{
                for (Account account : persAccounts) {
                	validateInput('Account', account, persAccountsFields, output, account.Name, 'Please navigate to Person account record SBA Etran Fields section , to populate the required fields.');
            	}
            } //--End-- logic to replace Primary Contact with Person Account
                
            if(connections.size() <= 0) 
                output.errors += 'Unavailable Ownership Percent (%) on connection record.\n\n';
            else{ for(LLC_BI__Connection__c connection: connections){
                    validateInput('LLC_BI__Connection__c', connection, connectionFields , output, connection.name, 'Please navigate to Connection Record to populate the required fields.');
                }
            } 

            if(unCreditInfo.size() <= 0){
 			    output.errors += 'Credit Elsewhere Reason.\n Navigation : Please navigate to Loan Application record, Related List to create it. \n\n';
				output.errors += 'Credit Elsewhere Reason.\n \n';
        		}
                 else{
                for (nSBA__Unavailable_Credit_Information__c uci : unCreditInfo) {
                    validateInput('nSBA__Unavailable_Credit_Information__c', uci, uciFields , output,uci.Name,'Please navigate to Credit Elsewhere Reason record and populate the required fields.');
                }
            }
            
            if(useOfProceedRec.size() <= 0)
                output.errors += 'Use of proceed is required.\n Navigation : Please navigate to Use of proceeds route to create it. \n\n';
            else{
                for (nSBA__Use_Of_Proceeds__c uop : useOfProceedRec) {
                    validateInput('nSBA__Use_Of_Proceeds__c', uop, uopFields , output, uop.Name,'Please navigate to Use of proceeds route and populate the required fields.');
                }
            }
                
            if (String.isBlank(output.errors) || Test.isRunningTest()) {
                WS_eTranServiceRequestWrapper requestWrapper = new WS_eTranServiceRequestWrapper(
                    input.method,
                    metadata,
                    credentials[0],
                    application, 
                    loan, 
                    primaryBAcc,
                    accounts, 
                    persAccounts,
                    connections,                        //Added new
                    changeOfOwnership,
                    unCreditInfo,
                    injectionRecords,
                    useOfProceedRec,
                    output,
                    princAccountIds,
                    collateralRec,
                    //guarantyCal,                      // fetching from loan
                    priceRateCompList,
                    collateralOwnRecords,
                    legalEntityRecord                   // added nee
                );
                request = JSON.serialize(requestWrapper);
            }
        }
        System.debug('##Request: '+request);
        return request;
    }

    public static WS_eTranServiceInvocableResponse parseResponseBody(HttpResponse response, WS_eTranServiceInvocableResponse output) {
        if (response.getStatusCode() == 200) {
            system.debug('response'+response);
            system.debug('responseBody'+response.getBody());
            system.debug(json.deserializeUntyped(response.getBody()));
            WS_eTranServiceResponseWrapper responseWrapper = (WS_eTranServiceResponseWrapper)JSON.deserialize(response.getBody(), WS_eTranServiceResponseWrapper.class);
            system.debug('##Response:'+responseWrapper);
            if (String.isBlank(responseWrapper.ErrorMessageTechnical)) {
                WS_eTranServiceResponseWrapper.eTranResponseResults appInfo = responseWrapper.getResponseResults();
                String synopsis = '';
                if (responseWrapper.getSynopsis() != null) {
                    for (String s : responseWrapper.getSynopsis()) {
                        synopsis += s + '\n\n';
                    }
                }
                output.synopsis = synopsis;
                if (appInfo != null) {
                    String error = '';
                    if (responseWrapper.getErrors() != null) {
                        for (String e : responseWrapper.getErrors()) {
                            error += e + '\n\n';
                        }
                    }
                    
                    output.errors = error;

                    if (responseWrapper.getApplicationNumber() != null) {
                        output.applicationNumber = responseWrapper.getApplicationNumber();
                    }
                    if (appInfo.sbaLoanNumber != null) {
                        output.sbaLoanNumber = appInfo.sbaLoanNumber;
                    }
                    if (appInfo.dunsNumber != null) {
                        output.dunsNumber = appInfo.dunsNumber;
                    }
                    if (appInfo.applicationReceivedDate != null) {
                        output.applicationReceivedDate = appInfo.applicationReceivedDate;
                    }
                    if (appInfo.applicationApprovedDate != null) {
                        output.applicationApprovedDate = appInfo.applicationApprovedDate;
                    }
                    if (appInfo.applicationFundedDate != null) {
                        output.applicationFundedDate = appInfo.applicationFundedDate;
                    }
                    if (appInfo.LoanApplicationApprovalAmount != null) {
                        output.loanApplicationApprovedAmount = appInfo.LoanApplicationApprovalAmount;
                    }
                    if (appInfo.LoanGuarnteeFeeAmount != null) {
                        output.LoanGuaranteeFeeAmount = appInfo.LoanGuarnteeFeeAmount;
                    }
                    if (appInfo.LoanApplicationStatusCode != null) {
                        output.LoanApplicationStatus = appInfo.LoanApplicationStatusCode;
                    }
                    if (appInfo.LiquidCreditScore != null) {
                        output.liquidCreditScore = appInfo.LiquidCreditScore;
                    }

                }
                else{
                    String error = '';
                    if (responseWrapper.getErrors() != null) {
                        for (String e : responseWrapper.getErrors()) {
                            error += e + '\n\n';
                        }
                    }
                    output.errors = error;
                }
            }
            else{
                output.errors = responseWrapper.ErrorMessageTechnical;
            }
        } else {
            output.errors = response.getStatusCode() + ': ' + response.getStatus() + ' - ' + response.getBody();
        }
        return output;
    }
}