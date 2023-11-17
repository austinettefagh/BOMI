/** 
 * This is the eTran Request Wrapper
 * This class makes request payload by taking loan , application etc records.
*/
public without sharing class WS_eTranServiceRequestWrapper {

    public String MethodNamePhysical;
    public String CLSUsername;
    public String CLSPassword;
    public String CLSPIN;
    public String EMail;
    public String SoftwareVendorCode;
    public String SoftwareVendorName;
    public String LocationId;
    public String RequestData;
    public String FormatIn;
    public String FormatOut;
    public String ApplicationNumber;
    public String RequestedAmount;
    
    public WS_eTranServiceRequestWrapper(
        String method,
        CM_EtranConfigurationSetting__mdt metadata,
        EtranCredential__c credentials,
        LLC_BI__Application__c application,
        LLC_BI__Loan__c loan,
        Account primBAcc,
        List<Account> bAccounts,
//JJ        list<Contact> contacts,
        list<Account> persAccounts,
        list<LLC_BI__Connection__c> connections,    // Added new 
        List<nSBA__Change_Of_Ownership__c> ownerShip,
        List<nSBA__Unavailable_Credit_Information__c> unCreditInfo,
        List<nSBA__Injections__c> InjectionRec,
        List<nSBA__Use_Of_Proceeds__c> useOfProceedList,
        WS_eTranServiceInvocableResponse output,
        Map<String,String> principalEIMap,
        List<LLC_BI__Loan_Collateral2__c> collateralList,
       // List<SBAGuarantyCalculator__c> sbaGuaranty,
        List<LLC_BI__Pricing_Rate_Component__c> priceRateCompList,
        Set<Id> ownershipAccount, 
        list<LLC_BI__Legal_Entities__c> legalRecord              // added new 
    ) {
        if(metadata.TECH_UseServiceAccount__c){
            try{
                CLSUsername = credentials.TECH_CLSUsername__c;
                CLSPassword = credentials.TECH_CLSPassword__c;
                CLSPIN = credentials.TECH_CLSPIN__c;
            }catch(Exception e){
               output.errors += 'We are unable to access your credentials. Please contact your system administrator.';
            }
        }else{
            CLSUsername = metadata.TECH_CLSUsername__c;
            CLSPassword = metadata.TECH_CLSPassword__c;
            CLSPIN = metadata.TECH_CLSPIN__c;
        }
        LocationId = metadata.TECH_LocationId__c;
        MethodNamePhysical = method;
        EMail = UserInfo.getUserEmail();
        SoftwareVendorName = metadata.TECH_SoftwareVendorName__c;
        FormatIn = metadata.TECH_FormatIn__c;
        FormatOut = metadata.TECH_FormatOut__c;
        ApplicationNumber = application.nSBA__Application_Number__c;
        RequestedAmount = String.valueOf(loan.LLC_BI__Amount__c);

        SoftwareVendorCode = metadata.TECH_SoftwareVendorCode__c;
        
        Boolean AgentInfoAvailable = false; //Added for AgentInfo
        If(application.nSBA__Form_159_Business_Name_of_Agent__c != null){
			AgentInfoAvailable = true;            
        }
        Boolean ReferralAgentInfoAvailable = false; //Added for AgentInfo
        If(application.nSBA__Form_159_Business_Name_of_Referral_Agent__c != null){
			ReferralAgentInfoAvailable = true;            
        }        
        RequestData requestDataObject = new RequestData(method,unCreditInfo.size() > 0,
                                                       ownerShip.size() > 0, useOfProceedList.size() > 0,
                                                       /*collateral*/false,InjectionRec.size() > 0, persAccounts.size() > 0,/*Borrower*/true, AgentInfoAvailable); //JJ Replaced contacts.size
        
        Map<String,String> bTypeMap = new Map<String,String>();
        for(Business_Type_to_Code_Mapping__mdt businessType : [SELECT Id, MasterLabel, Business_Type_Code__c FROM Business_Type_to_Code_Mapping__mdt WHERE (Business_Type_Code__c !='' OR Business_Type_Code__c != null)]){
            bTypeMap.put(businessType.MasterLabel, businessType.Business_Type_Code__c);
        }
        
        //Map for controlling interest type
        Map<String,String> cIntType = new Map<String,String>();
        Map<String,String> injTyCd = new Map<String,String>();
        
        for(eTranPicklistTranslationMetadata__mdt picklistValue : [SELECT Id, FieldName__c, TBoMValue__c, EtranValue__c 
                                                              FROM eTranPicklistTranslationMetadata__mdt WHERE (Id != null OR Id != '')])
        {
            if(picklistValue.FieldName__c == 'ControlInterestType'){
                cIntType.put(picklistValue.TBoMValue__c,picklistValue.EtranValue__c);
            }/*else if(picklistValue.FieldName__c == 'Race'){
                raceCd.put(picklistValue.TBoMValue__c,picklistValue.EtranValue__c);
            }else if(picklistValue.FieldName__c == 'Ethnicity'){
                ethnicCd.put(picklistValue.TBoMValue__c,picklistValue.EtranValue__c);
            }*/
			else if(picklistValue.FieldName__c == 'InjectionTypeCd'){
                injTyCd.put(picklistValue.TBoMValue__c,picklistValue.EtranValue__c);
            }
        }

        Decimal rateCeiling;
        Decimal rateFloor;
        If(loan.LLC_BI__Rate_Ceiling__c != null){  
             rateCeiling =  loan.LLC_BI__Rate_Ceiling__c.setScale(3);
        }
        If(loan.LLC_BI__Rate_Floor__c != null){  
             rateFloor = loan.LLC_BI__Rate_Floor__c.setScale(3);
        }
        //requestDataObject.App[0].LoanApplication[0].AgentInvolved = application.nSBA__Is_Agent_Involved__c ? 'Y' : 'N';
        requestDataObject.App[0].LoanApplication[0].AgentInvolved = 'Y';
        requestDataObject.App[0].LoanApplication[0].LenderCntctFirstName = metadata.TECH_LenderCntctFirstName__c;
        requestDataObject.App[0].LoanApplication[0].LenderCntctLastName = metadata.TECH_LenderCntctLastName__c;
        requestDataObject.App[0].LoanApplication[0].LenderCntctEmail = metadata.TECH_Email__c;
        requestDataObject.App[0].LoanApplication[0].LenderCntctFax = metadata.TECH_LenderCntctFax__c;
        requestDataObject.App[0].LoanApplication[0].LenderCntctMiddleInitial = String.isNotBlank(loan.LLC_BI__Application__r.nSBA__Lender_Service_Provider_Middle_Name__c) ? loan.LLC_BI__Application__r.nSBA__Lender_Service_Provider_Middle_Name__c.substring(0,1) : ''; //Replaced nSBA__ETran_Lender_Contact__r.middlename
        requestDataObject.App[0].LoanApplication[0].LenderCntctNameSuffix = loan.LLC_BI__Application__r.nSBA__Lender_Service_Provider_Name_Suffix__c; //Replaced nSBA__ETran_Lender_Contact__r.Suffix;
        requestDataObject.App[0].LoanApplication[0].LenderCntctTitl = metadata.TECH_LenderCntctTitle__c;
        requestDataObject.App[0].LoanApplication[0].LenderContactCellPhn = String.isnotBlank(loan.nSBA__ETran_Lender_Contact__r.mobilePhone) ? String.valueOf(loan.nSBA__ETran_Lender_Contact__r.mobilePhone).replaceAll('\\D','') : '';
        requestDataObject.App[0].LoanApplication[0].LenderCntctPhnNmb = String.isnotBlank(metadata.TECH_LenderCntctPhnNmb__c) ? String.valueOf(metadata.TECH_LenderCntctPhnNmb__c).replaceAll('\\D','') : '';
        requestDataObject.App[0].LoanApplication[0].RequestedAmt = String.isnotBlank(String.valueOf(loan.LLC_BI__Amount__c)) ? String.valueOf(loan.LLC_BI__Amount__c).replaceAll(',', '') : '';
        requestDataObject.App[0].LoanApplication[0].MnthsIntrstOnlyQty = String.valueof(loan.LLC_BI__Interest_Only_Months__c);
        requestDataObject.App[0].LoanApplication[0].SBAGntyPct = String.isnotBlank(String.valueOf(loan.LLC_BI__SBA_Guarantee__c)) ? String.valueOf(loan.LLC_BI__SBA_Guarantee__c ) : '';
        requestDataObject.App[0].LoanApplication[0].LoanTermMnths =  String.isnotBlank(String.valueof(loan.LLC_BI__Term_Months__c)) ? String.valueOf(loan.LLC_BI__Term_Months__c).replaceAll('[^0-9]', '') : ''; 
        requestDataObject.App[0].LoanApplication[0].LoanTermAmortMnths = String.isnotBlank(String.valueof(loan.LLC_BI__Amortized_Term_Months__c)) ? String.valueOf(loan.LLC_BI__Amortized_Term_Months__c).replaceAll('[^0-9]', '') : '';
        requestDataObject.App[0].LoanApplication[0].NAICSCd = string.isnotBlank(primBAcc.cm_Industry_Code__c) ? String.valueOf(primBAcc.cm_Industry_Code__r.name).replaceAll('[^0-9]', ''):'';  // Replaced NaicsCode__r.name JJ used TBoM NAICS
        requestDataObject.App[0].LoanApplication[0].LoanName = loan.Name;
        requestDataObject.App[0].LoanApplication[0].CurrEmpQty = String.isnotBlank(String.valueof(primBAcc.NumberOfEmployees))? String.valueOf(primBAcc.NumberOfEmployees) : '';
        requestDataObject.App[0].LoanApplication[0].ProjectStrtName1 = primBAcc.ShippingStreet;
        requestDataObject.App[0].LoanApplication[0].ProjectCityName = primBAcc.ShippingCity;
        requestDataObject.App[0].LoanApplication[0].ProjectStCd = primBAcc.ShippingState;
        requestDataObject.App[0].LoanApplication[0].ProjectZipCd = primBAcc.ShippingPostalCode.left(5);
        requestDataObject.App[0].LoanApplication[0].PymtAmt =  String.valueOf(loan.LLC_BI__Monthly_Payment__c);                                                     //Replaced Principal_and_Interest_Payment_Amount__c
        requestDataObject.App[0].LoanApplication[0].LoanBusinessEstDt = primBAcc.nSBA__Date_Of_Establishment__c != null ? String.valueOf(primBAcc.nSBA__Date_Of_Establishment__c) + ' 00:00:00.0' : ''; //DateTime format required by SBA eLend
        requestDataObject.App[0].LoanApplication[0].BusinessAgeCd = primBAcc.nSBA__Business_Age__c;
        requestDataObject.App[0].LoanApplication[0].CollateralInd = application.nSBA__Is_Collateralized__c ? 'Y' : 'N';
        requestDataObject.App[0].LoanApplication[0].EligPassiveCompanyInd = loan.LLC_BI__Application__r.nSBA__Is_EPC_Type_Of_Business_Eligible__c ? 'Y' : 'N';      // Replaced primBAcc.Applicant_Business_an_EPC__c
        requestDataObject.App[0].LoanApplication[0].FrnchiseInd = String.isNotBlank(primBAcc.nSBA__Franchise_Code__c) ? 'Y' : 'N';
        requestDataObject.App[0].LoanApplication[0].FrnchiseCd = primBAcc.nSBA__Franchise_Code__c;                                                                  // Replaced Franchise_Code__c
        requestDataObject.App[0].LoanApplication[0].FrnchiseName = primBAcc.nSBA__Franchise_Name__c;
        requestDataObject.App[0].LoanApplication[0].InjectionInd = application.nSBA__Injection_Indication__c ? 'Y' : 'N';
        requestDataObject.App[0].LoanApplication[0].EWCPPostShipmntInd = primBAcc.nSBA__Exporter__c ? 'Y' : 'N';                                                    // Replaced   Exporting__c
        requestDataObject.App[0].LoanApplication[0].JobsCreatdQty = String.valueof(loan.LLC_BI__Application__r.nSBA__Jobs_Created__c);                              // Replaced primBAcc.Jobs_Created__c
        requestDataObject.App[0].LoanApplication[0].JobsRetaindQty = String.valueof(loan.LLC_BI__Application__r.nSBA__Jobs_Retained__c);                            // Replaced primBAcc.Jobs_Retained__c
        requestDataObject.App[0].LoanApplication[0].LenderLoanNmb = loan.LLC_BI__Lookupkey__c;                                                                      
        requestDataObject.App[0].LoanApplication[0].LoanPackagerCityName = application.nSBA__Loan_Packager_City__c;
        requestDataObject.App[0].LoanApplication[0].LoanPackagerName = application.nSBA__Loan_Packager_Name__c;
        requestDataObject.App[0].LoanApplication[0].LoanPackagerStCd = application.nSBA__Loan_Packager_State__c;
        requestDataObject.App[0].LoanApplication[0].LoanPackagerStrtName1 = application.nSBA__Loan_Packager_Street__c;
        requestDataObject.App[0].LoanApplication[0].LoanPackagerZipCd = application.nSBA__Loan_Packager_Zipcode__c;
        requestDataObject.App[0].LoanApplication[0].LoanPackageSourcTypCd = application.nSBA__Loan_Package_Source__c;
        requestDataObject.App[0].LoanApplication[0].NetExprtAmt = string.valueof(primBAcc.nSBA__Net_Export_Amount__c);
        requestDataObject.App[0].LoanApplication[0].PymtCeilingMaxPct =String.valueof(rateCeiling);
        requestDataObject.App[0].LoanApplication[0].PymtFloorMinPct = String.valueof(rateFloor);
        requestDataObject.App[0].LoanApplication[0].UnderwritingBy = application.nSBA__SBA_Underwriting_required__c ? 'SBA' : 'LNDR';
        requestDataObject.App[0].LoanApplication[0].RuralUrbanInd = primBAcc.nSBA__Rural_Urban_Indicator__c;
        requestDataObject.App[0].LoanApplication[0].LenderApplicNmb = loan.Id;
        requestDataObject.App[0].LoanApplication[0].PymtTypeCode = '';                                                                                              //loan.LLC_BI__Payment_Type__c;
        requestDataObject.App[0].LoanApplication[0].ReconsiderationInd = loan.LLC_BI__Application__r.nSBA__Resubmission__c ? 'Y' : 'N';                             // Replaced primBAcc.Resubmission__c
        requestDataObject.App[0].LoanApplication[0].StateLawComplianceForBulkInd = application.nsba__Business_Acquisition_Asset__c ? 'Y': 'N';
        //requestDataObject.App[0].LoanApplication[0].InterestStructureCd = priceRateCompList.size() > 0 && priceRateCompList[0].LLC_BI__Is_Fixed__c == true ? 'F' : 'V';
        requestDataObject.App[0].LoanApplication[0].InterestStructureCd = loan.LLC_BI__PRICING_BASIS__c =='FIXED' ? 'F': 'V'; //Used Pricing basis instead of Interest structure
        //requestDataObject.App[0].LoanApplication[0].PymtSchedule = loan.LLC_BI__Payment_Schedule__c; // Jayanth added to fix payment schedule
        //requestDataObject.App[0].LoanApplication[0].PymtSchedule = '1'; // Jayanth added to fix payment schedule
        
        //requestDataObject.App[0].LoanApplication[0].LoanAgentType = '6';
        
        Boolean lifeInsReq = false;
        for(LLC_BI__Loan_Collateral2__c col : collateralList){
            if(String.isNotBlank(col.LLC_BI__Collateral__r.LLC_BI__Life_Insurance_Policy_Number__c)){
                lifeInsReq = true;
                Break;
            }
        }
        requestDataObject.App[0].LoanApplication[0].LifeInsurRqmtInd = lifeInsReq ? 'Y' : 'N';
        //String businessTaxID = '0' + primBAcc.Tax_ID__c.replaceAll('[^0-9]', ''); //Prefix of 0 for EIN is required by SBA eLend
        String businessTaxID = '0' + primBAcc.LLC_BI__Tax_Identification_Number_PE__c.replaceAll('[^0-9]', ''); //Prefix of 0 for EIN is required by SBA eLend
        requestDataObject.App[0].Borrower.clear();

        for(Account acc : bAccounts){
            Borrower borrower = new Borrower(MethodNamePhysical);
            
            String EPCOperatingCompnyCd;
            String AccountId = acc.Id; 
 			//Added new logic
            if(loan.LLC_BI__Application__r.nSBA__Is_EPC_Type_Of_Business_Eligible__c == true){
                for(LLC_BI__Legal_Entities__c legalrecs: legalRecord ){
            		if(legalrecs.LLC_BI__Account__c == AccountId && legalrecs.LLC_BI__Entity_Type__c == 'Operating Company'){
                        EPCOperatingCompnyCd = '3';
                    } else if(legalrecs.LLC_BI__Account__c == AccountId && legalrecs.LLC_BI__Entity_Type__c == 'EPC'){
                        EPCOperatingCompnyCd = '2';
                    } else if(legalrecs.LLC_BI__Account__c == AccountId){
                        EPCOperatingCompnyCd = '1';
                    }
    
                }
            }else{
                EPCOperatingCompnyCd = '';
            }
           
            borrower.EPCOperatingCompnyCd = EPCOperatingCompnyCd;
            //borrower.TaxId = '0' + acc.Tax_ID__c.replaceAll('[^0-9]', '');
            borrower.TaxId = '0' + acc.LLC_BI__Tax_Identification_Number_PE__c.replaceAll('[^0-9]', '');
            borrower.BnkrptcyInd = acc.nSBA__Bankruptcy__c ? 'Y' : 'N';
            borrower.BusDUNSNmb = acc.nSBA__Duns_Number__c;
            borrower.BusOutstandingDebtInd = acc.nSBA__Business_Has_Outstanding_Debt__c ? 'Y' : 'N';
            borrower.ControlInterestType = String.isNotBlank(acc.nSBA__Control_Interest_Type__c) && cIntType.containsKey(acc.nSBA__Control_Interest_Type__c) ?
                cIntType.get(acc.nSBA__Control_Interest_Type__c) : '';
            borrower.BusinessName = acc.Name;
            borrower.PrimaryPhone = String.isNotBlank(acc.Phone) ? acc.Phone.replaceAll('[^0-9]', '') : '';
            borrower.PhysCityName = acc.ShippingCity;
            borrower.PhysCountryCd = acc.ShippingCountry == 'USA' || acc.ShippingCountry == 'United States' ? 'US' : acc.ShippingCountry;
            borrower.PhysPostalCd = acc.ShippingPostalCode.replaceAll('[^0-9]', '').left(5);
            borrower.PhysStrtName1 = acc.ShippingStreet;
            borrower.PhysStCd = acc.ShippingState;
            borrower.PhysZipCd = String.ISNOTBLANK(acc.ShippingPostalCode) ? acc.ShippingPostalCode.replaceAll('[^0-9]', '').left(5) : '';
            borrower.PriorSBALoanInd = acc.nSBA__Prior_SBA_Loan__c ? 'Y' : 'N';
            borrower.TradeName = acc.nSBA__DBA__c;
            //borrower.LegalOrgnztnCd = bTypeMap.containsKey(acc.Select_Your_Business_Entity_Type__c) ? bTypeMap.get(acc.Select_Your_Business_Entity_Type__c) : '';
            borrower.LegalOrgnztnCd = bTypeMap.containsKey(acc.Type) ? bTypeMap.get(acc.Type) : '';
            borrower.CreditScorSourcCd = acc.nSBA__External_Credit_Score_Source__c;
            borrower.CurrBankName = acc.nSBA__Primary_Bank_Name__c;
            borrower.CurrOwnrshpEstblshDt = String.valueof(acc.nSBA__Date_Of_Current_Ownership_Establishment__c);
            borrower.ExporterInd = (acc.nSBA__Net_Export_Amount__c == 0 || acc.nSBA__Net_Export_Amount__c == null) ? 'N' : 'Y';
            borrower.ExtrnlCreditScorDt = String.valueof(acc.nSBA__External_Credit_Score_Date__c);
            borrower.ExtrnlCreditScorInd = acc.nSBA__External_Credit_Score__c != null ? 'Y' : 'N';
            borrower.ExtrnlCreditScorNmb = String.valueof(acc.nSBA__External_Credit_Score__c);
            borrower.GamblingOrSexualNatureInd = acc.nSBA__Revenues_From_Gambling_Or_Sexual_Nature__c ? 'Y' : 'N';
            borrower.LawsuitInd = acc.nSBA__Current_Lawsuit__c ? 'Y' : 'N';
            borrower.MailCityName = acc.ShippingCity;
            borrower.MailCountryCd = acc.ShippingCountry == 'USA' || acc.ShippingCountry == 'United States' ? 'US' : acc.ShippingCountry;
            borrower.MailPostalCd = acc.ShippingPostalCode;
            borrower.MailStCd = acc.ShippingState;
            borrower.MailStrtName1 = acc.ShippingStreet;
            borrower.PrimaryBusinessInd = acc.Id == primBAcc.Id ? 'Y' : 'N';
            borrower.MailZipCd = acc.ShippingPostalCode;
            borrower.NonFedEmpInd = acc.nSBA__No_Member_of_Congress_Owns_10_Percent__c ? 'Y' : 'N';                 // Replaced Member_of_Congress_10_Percent_Owner__c
            borrower.NonFmrSBAEmpInd = acc.nSBA__No_SBA_Employee_Owns_10_Percent_Or_More__c ? 'Y' : 'N';            // Replaced SBA_Employee_10_Owner_Indicator__c
            borrower.NonGS13EmpInd = application.nSBA__No_GS13_Government_Employee_10_Pct_Owner__c ? 'Y' : 'N';     // Added new logic
            borrower.PrevGovFinInd = acc.nSBA__Prior_Government_Loan__c ? 'Y' : 'N';                                  // Added new logic

            requestDataObject.App[0].Borrower.add(borrower);
        }
        
        //Change Of Ownership
        if(ownerShip.size() > 0 && methodNamePhysical != 'OrigUpdate') 
        {
            requestDataObject.App[0].ChangeOfOwnership.clear();
            for(nSBA__Change_Of_Ownership__c coo : ownerShip){
            ChangeOfOwnership changeOfOwnership = new ChangeOfOwnership();
            
            changeOfOwnership.AcctRecvAssetAmt = String.valueof(coo.nSBA__Total_Accounts_Receivable__c);
            changeOfOwnership.BusApprFeeAmt = String.valueof(coo.nSBA__Appraiser_Fee__c);
            changeOfOwnership.BusApprNm = coo.nSBA__Appraiser_Name__c;
            changeOfOwnership.BusBrkrAdr = coo.nSBA__Broker_Address__c;
            changeOfOwnership.BusBrkrComisnAmt = String.valueof(coo.nSBA__Broker_Commission__c);
            changeOfOwnership.BusBrkrComisnInd = coo.nSBA__Broker_Commission__c != Null && coo.nSBA__Broker_Commission__c != 0 ? 'Y' : 'N';
            changeOfOwnership.BusBrkrNm = coo.nSBA__Broker_Name__c;
            changeOfOwnership.BuyerEqtyBorrAmt = String.valueof(coo.nSBA__Borrower_Equity_Amount__c);
            changeOfOwnership.BuyerEqtyCashAmt = String.valueof(coo.nSBA__Buyer_Equity_Cash__c);
            changeOfOwnership.BuyerEqtyCashDescTxt = coo.nSBA__Buyer_Equity_Cash_Description__c;
            changeOfOwnership.BuyerEqtyOthAmt = String.valueof(coo.nSBA__Other_Equity_Amount__c);
            changeOfOwnership.BuyerEqtyOthDescTxt = coo.nSBA__Other_Equity_Description__c;
            changeOfOwnership.CustAssetAmt = String.valueof(coo.nSBA__Client_List_Value__c);
            changeOfOwnership.FrnchsAssetAmt = String.valueof(coo.nSBA__Franchise_Value__c);
            changeOfOwnership.GoodwillAssetAmt = String.valueof(coo.nSBA__Goodwill_Value__c);
            changeOfOwnership.IntangAssetAmt = coo.nSBA__Total_Intangible_Assets__c != null ? String.valueof(coo.nSBA__Total_Intangible_Assets__c) : '';
            changeOfOwnership.InvtryAssetAmt = String.valueof(coo.nSBA__Total_Inventory__c);
            changeOfOwnership.LicnsAssetAmt = String.valueof(coo.nSBA__License_Value__c);
            //changeOfOwnership.Loan7aPymtAmt = String.valueof(loan.LLC_BI__Monthly_Payment__c);   //Replaced Principal_and_Interest_Payment_Amount__c
            changeOfOwnership.Loan7aPymtAmt = String.valueof(coo.CF_7_a_Loan__c); // new field as requested by TBoM during Etran Testing
            changeOfOwnership.OthAssetAmt = coo.nSBA__Total_Other_Assets__c != null ? String.valueof(coo.nSBA__Total_Other_Assets__c) : '';
            changeOfOwnership.OthAssetDescTxt = coo.nSBA__Total_Other_Assets_Description__c;
            changeOfOwnership.OthIntangAssetAmt = String.valueof(coo.nSBA__Other_Intangibles_Value__c);
            changeOfOwnership.OthIntangAssetDescTxt = coo.nSBA__Other_Intangibles_Description__c;
            changeOfOwnership.ReAssetAmt = String.valueof(coo.nSBA__Total_Real_Estate__c);
            changeOfOwnership.SellerFinanFullStbyAmt = String.valueof(coo.nSBA__Seller_Finance_Full_Standby__c);
            changeOfOwnership.SellerFinanNonFullStbyAmt = String.valueof(coo.nSBA__Seller_Finance_Not_Full_Standby__c);
            changeOfOwnership.TotApprAmt = String.valueof(coo.nSBA__Total_Appraised_Value__c);
            changeOfOwnership.RevalTypInd = coo.nSBA__Real_Estate_Evaluation_Type__c != '' ? 'Y' : 'N';
            
            if(coo.nSBA__Total_Other_Assets__c != null && coo.nSBA__Total_Intangible_Assets__c != null){
                changeOfOwnership.TotAssetAmt = String.valueof(coo.nSBA__Total_Other_Assets__c + coo.nSBA__Total_Intangible_Assets__c);
            }else if(coo.nSBA__Total_Other_Assets__c != null){
                changeOfOwnership.TotAssetAmt = String.valueof(coo.nSBA__Total_Other_Assets__c);
            }else if(coo.nSBA__Total_Intangible_Assets__c != null){
                changeOfOwnership.TotAssetAmt = String.valueof(coo.nSBA__Total_Intangible_Assets__c);
            }else{
                changeOfOwnership.TotAssetAmt = '';
            }
            
            requestDataObject.App[0].ChangeOfOwnership.add(changeOfOwnership);
            }
        }
        // Unavailable Credit Information
        if(unCreditInfo.size() > 0 && methodNamePhysical != 'OrigUpdate') 
        {
            requestDataObject.App[0].CreditUnavailReasons.clear();
            for(nSBA__Unavailable_Credit_Information__c uci : unCreditInfo){
                CreditUnavailReasons cur = new CreditUnavailReasons();
                cur.CreditUnavailReasonCd = uci.nSBA__Reason_Code__c;
                cur.CreditUnavailReasonCommnt = uci.nSBA__Reason_Comment__c;
                
                requestDataObject.App[0].CreditUnavailReasons.add(cur);
            }
        }
        //Injections
        if(InjectionRec.size() > 0) 
        {
            requestDataObject.App[0].Injection.clear();
            if(methodNamePhysical == 'OrigUpdate'){
                Injection injectionDelete = new Injection();
                injectionDelete.action = 'deleteall';

                requestDataObject.App[0].Injection.add(injectionDelete);
            }
            for(nSBA__Injections__c inj : InjectionRec){
                Injection injection = new Injection();
                injection.action = 'Insert';
                injection.InjctnAmt =  inj.nSBA__Injection_Amount__c != null ? String.valueof(inj.nSBA__Injection_Amount__c) : '';
                injection.InjctnOthDescTxt = String.ISNOTBLANK(inj.nSBA__Injection_Other_Description__c) ? inj.nSBA__Injection_Other_Description__c : '';
                //injection.InjctnTypCd =  String.ISNOTBLANK(inj.nSBA__Injection_Type_Code__c) ? inj.nSBA__Injection_Type_Code__c : '';
				injection.InjctnTypCd = String.isNotBlank(inj.nSBA__Injection_Type_Code__c) && injTyCd.containsKey(inj.nSBA__Injection_Type_Code__c) ?
                injTyCd.get(inj.nSBA__Injection_Type_Code__c) : '';
                
                requestDataObject.App[0].Injection.add(injection);
            }
        }
        //UseOfProceeds
        if(useOfProceedList.size() > 0)
        {
            requestDataObject.App[0].UseOfProceeds.clear();
            if(methodNamePhysical == 'OrigUpdate'){
                UseOfProceeds useOfProDelete = new UseOfProceeds();
                useOfProDelete.action = 'deleteall';
                requestDataObject.App[0].UseOfProceeds.add(useOfProDelete);
            }
            for(nSBA__Use_Of_Proceeds__c uop : useOfProceedList){
            UseOfProceeds useOfPro = new UseOfProceeds();
            useOfPro.action = 'insert';
            //useOfPro.ProceedTypCd = uop.nSBA__Proceed_Type_Code__c;
            useOfPro.ProceedTypCd = 'A'; // 
            useOfPro.LoanProceedTypCd = uop.nSBA__Loan_Proceed_Type_Code__c;
            useOfPro.ProceedAmt = string.valueof(uop.nSBA__Proceed_Amount__c);
            useOfPro.ProceedOthTypTxt = uop.nSBA__Proceed_Other_Type_Text__c;
            useOfPro.PurchaseAgrmtDt = string.valueof(uop.nSBA__Purchase_Agreement_Date__c);
            useOfPro.PurchaseIntngblAssetAmt = string.valueof(uop.nSBA__Intangible_Asset_Amount__c);
            useOfPro.PurchaseIntngblAssetDescTxt = uop.nSBA__Intangible_Asset_Description__c;            
            useOfPro.StockholderName = uop.nSBA__Stockholder_Name__c;
            requestDataObject.App[0].UseOfProceeds.add(useOfPro);
        }
        }

        if(methodNamePhysical == 'OrigUpdate'){
            Interest intRec = new Interest();
            intRec.action = 'deleteAll';
            requestDataObject.App[0].Interest.add(intRec);
            
            SpecialPurpose splRec = new SpecialPurpose();
            splRec.action = 'deleteAll';
            requestDataObject.App[0].SpecialPurpose.add(splRec);
        }
        Interest intRec1 = new Interest();
        intRec1.action = 'insert';
        intRec1.BorrIntrstRatePct = String.IsNotBlank(String.valueOf(loan.LLC_BI__InterestRate__c)) ? String.valueOf(loan.LLC_BI__InterestRate__c.stripTrailingZeros()) : '';
        intRec1.IntrstTypInd = loan.LLC_BI__PRICING_BASIS__c =='FIXED' ? 'F' : 'V';                                                                     //Added new logic 
        intRec1.ShareOfTotalMnths = String.IsNotBlank(String.valueOf(loan.LLC_BI__Amortized_Term_Months__c)) ? String.valueOf(loan.LLC_BI__Amortized_Term_Months__c) : '';
        intRec1.BaseIntrstRatePct = String.IsNotBlank(String.valueOf(loan.nSBA__Base_interest_Rate__c)) ? String.valueOf(loan.nSBA__Base_interest_Rate__c) : '';
        intRec1.AdjustPeriodMnths = String.isnotBlank(String.valueOf(loan.e2e_Special_Payment_Series_Comments__c)) ? String.valueOf(loan.e2e_Special_Payment_Series_Comments__c) : '';
        intRec1.FirstRateAdjustDt = String.IsNotBlank(String.valueOf(application.nSBA__First_Rate_Adjustment_Date__c )) ? String.valueOf(application.nSBA__First_Rate_Adjustment_Date__c) : ''; 
        //intRec1.AdjustPeriodCd = loan.LLC_BI__PRICING_BASIS__c =='FIXED' ? 'Q': 'X';                                                                     //Added new logic 
        //New logic to populate the value as per the Etran Code table - Jayanth        
        switch on loan.LLC_BI__Interest_Rate_Adjustment_Frequency__c {
            when 'Daily' {
                intRec1.AdjustPeriodCd = 'D'; 
            }	
            when 'Monthly' {	
                intRec1.AdjustPeriodCd = 'M'; 
            }
            when 'Quarterly' {	
                intRec1.AdjustPeriodCd = 'Q'; 
            }
            when 'Annual' {	
                intRec1.AdjustPeriodCd = 'A'; 
            }            
            when else {
                intRec1.AdjustPeriodCd = 'X';
            }
    	}
		//End New logic to populate the value as per the Etran Code table   
		
        requestDataObject.App[0].Interest.add(intRec1);

        SpecialPurpose splRec1 = new SpecialPurpose();
        splRec1.action = 'insert';
        splRec1.SpcPurpsLoanCd = application.nSBA__Special_Purpose_Loan_Code__c;
        requestDataObject.App[0].SpecialPurpose.add(splRec1);

        if (methodNamePhysical != 'OrigUpdate') {
            //requestDataObject.App[0].LoanApplication[0].ProcessingMethodCd = application.nSBA__SBA_Underwriting_required__c ? '7AG' : 'PLP';//To be sent only on application request
            //requestDataObject.App[0].LoanApplication[0].ProcessingMethodCd = metadata.TECH_Type_of_SBA__c;
            requestDataObject.App[0].LoanApplication[0].ProcessingMethodCd = application.nSBA__SBA_Processing_Method__c; ////Added on 09/08/2022 as requested by Loren
        }
        
		/* Commented to replace Contacts by Person Accounts  

		-End-- Commented to replace Contacts by Person Accounts  */
        
		//Added below logic to replace the Contacts with Person Accounts
        for (Account account : persAccounts) {
            Principal principal = new Principal(MethodNamePhysical);
            //String ssn = '1'+  account.Tax_ID__c;                 //Replaced contact.Account.SSN__c
            //String ssn = '1'+  account.LLC_BI__SS__pc; 
            String ssn = '1'+  account.LLC_BI__SS_PE__pc; 
            principal.TaxId = ssn;
            principal.AlienRgstrtnNmb = account.nSBA__Alien_Registration_Number__pc;
            principal.BusinessTaxId = businessTaxID;
            principal.FirstName = account.FirstName;
            principal.LastName = account.LastName;
            principal.AlternateEmail = account.PersonEmail;
            principal.AlternatePhone = account.phone.replaceAll('[^0-9]', '');
            principal.BirthCityName = account.nSBA__Birth_City__pc;
            principal.BirthCntryName = account.nSBA__Birth_Country__pc;
            principal.BirthDt = String.valueof(account.PersonBirthdate);
            principal.BirthStCd = account.nSBA__Birth_State__pc;
            principal.BnkrptcyInd = account.nSBA__Bankruptcy__c ? 'Y' : 'N';
            
            //Added below new logic for GntyInc 
            for(LLC_BI__Legal_Entities__c record:legalRecord){
                if(record.nSBA__Guarantor_Type__c != null || record.nSBA__Guarantor_Type__c !=''){
                    principal.GntyInd = 'Y';
                    principal.GntyTypCd = record.nSBA__Guarantor_Type__c;
                } else {
                    principal.GntyInd = 'N';
                    principal.GntyTypCd = '';
                }
            }
     
            //principal.CitznShipCntryName = account.LLC_BI__Country_of_Citizenship__pc;  // Replaced Account.Citizenship__c
            principal.CitznShipCntryName = account.CF_Country_of_Citizenship__c; 
            principal.ControlInterestType = String.isNotBlank(account.nSBA__Control_Interest_Type__c) && cIntType.containsKey(account.nSBA__Control_Interest_Type__c) ?
                cIntType.get(account.nSBA__Control_Interest_Type__c) : '';
            principal.ConvictdInd = account.nSBA__Convicted_Criminal__c ? 'Y' : 'N';
            principal.CreditScorSourcCd = account.nSBA__External_Credit_Score_Source__c;
            principal.CrmnlOffnsInd = account.nSBA__Convicted_Criminal__c ? 'Y' : 'N';
            principal.ExtrnlCreditScorDt = String.valueof(account.nSBA__External_Credit_Score_Date__c);
            principal.ExtrnlCreditScorInd = account.nSBA__External_Credit_Score__c != null ? 'Y' : 'N';
            principal.ExtrnlCreditScorNmb = String.valueof(account.nSBA__External_Credit_Score__c);
            principal.EthnicCd = String.isNotBlank(account.nSBA__Ethnicity__pc) ? account.nSBA__Ethnicity__pc : 'UN';
            principal.PhysStrtName1 = account.ShippingStreet;
            principal.PhysCityName = account.ShippingCity;
            principal.PhysCountryCd = account.ShippingCountry == 'USA' || account.ShippingCountry == 'United States' ? 'US' : account.ShippingCountry;
            principal.PhysStCd = account.ShippingState;
            principal.MailZipCd =  String.isNotBlank(account.ShippingPostalCode) ? account.ShippingPostalCode.replaceAll('[^0-9]', '').left(5) : '';
            principal.PhysPostalCd = String.isNotBlank(account.ShippingPostalCode) ? account.ShippingPostalCode.replaceAll('[^0-9]', '').left(5) : '';
            principal.PhysZipCd = String.isNotBlank(account.ShippingPostalCode) ? account.ShippingPostalCode.replaceAll('[^0-9]', '').left(5) : '';
            principal.FngrprntWaivDt = String.valueof(account.nSBA__Fingerprint_Waived_Date__c);
            principal.GndrCd = account.nSBA__Gender__pc;
            principal.IndctPrleProbatnInd = application.nSBA__Any_Individual_On_Parole_Or_Probation__c ? 'Y' : 'N';
            principal.InsuranceAmt = String.valueof(account.nSBA__Insurance_Amount__c);
            principal.InsuranceDisabInd = account.nSBA__Disability_Insurance__c ? 'Y' : 'N';
            principal.InsureDisabNames = account.nSBA__Disability_Insured_Names__c;
            principal.InsureName = account.nSBA__Insured_Name__c;
            principal.InsuranceLifeInd =  lifeInsReq ? 'Y' : 'N';
            principal.LawsuitInd = account.nSBA__Current_Lawsuit__c ? 'Y' : 'N';
            principal.LglActnInd = account.nSBA__Presently_Involved_In_Any_Legal_Action__pc ? 'Y' : 'N';                 // Replaced Account.Legal_Action__c
            principal.MailCityName = account.ShippingCity;
            principal.MailCountryCd = account.ShippingCountry == 'USA' || account.ShippingCountry == 'United States' ? 'US' : account.ShippingCountry;
            principal.MailPostalCd = account.ShippingPostalCode;
            principal.MailStCd = account.ShippingState;
            principal.MailStrtName1 = account.ShippingStreet;
            principal.MiddleInitial = account.MiddleName;                                               // Replaced contact.middlename
            principal.NameSuffix = account.Suffix;                                                        //Replaced contact.Suffix
            principal.PrimaryPhone = account.phone.replaceAll('[^0-9]', '');
            principal.PrimaryEmail = account.PersonEmail;
            principal.PrimBusExprnceYrNmb = String.valueof(account.nSBA__Business_Experience_Years__c);
            principal.Title = account.PersonTitle;
            //principal.USCitznInd = account.nSBA__US_Citizen__pc ? 'US' : 'US';
            principal.USCitznInd = account.CF_US_Citizenship_Status__c;
            principal.VetCd = account.nSBA__Veteran_Status__pc;
            principal.VetCertInd = account.nSBA__Is_Certified_Veteran__pc ? 'Y' : 'N';
            principal.FedEmplyAffiltInd = account.nSBA__Federal_Employee__c ? 'Y' : 'N';                        //Added new

            //principal.OwnrshpInBusinessPct = String.valueOf(contact.OwnershipPercentage__c.stripTrailingZeros());
            for(LLC_BI__Connection__c connetionobj: connections){
                if(connetionobj.LLC_BI__Connected_To__c == account.Id){
                principal.OwnrshpInBusinessPct = String.valueOf(connetionobj.LLC_BI__Ownership_Percent__c.stripTrailingZeros());
                system.debug('OwnrshpInBusinessPct'+principal.OwnrshpInBusinessPct);
                }
            }
            //principal.GntyLimitAmt = sbaGuaranty.size() > 0 ? String.valueOf(sbaGuaranty[0].SelectedSetupGty__c) : '';
            //principal.GntyLimitAmt = String.isnotBlank(String.valueOf(loan.LLC_BI__SBA_Guarantee__c)) ? String.valueOf(loan.LLC_BI__SBA_Guarantee__c ) : '';
            
            requestDataObject.App[0].Principal.add(principal);

            if(methodNamePhysical != 'OrigUpdate') {
                PrincipalRace principalRace = new PrincipalRace();
                principalRace.TaxId = ssn; //Prefix of 1 for SSN is required by SBA eLend
                principalRace.RaceCd = string.isnotBlank(account.nSBA__Race__pc) ? account.nSBA__Race__pc : '7';
                requestDataObject.App[0].PrincipalRace.add(principalRace);
            }
        }
		// -End-- Added logic to replace the Contacts with Person Accounts

        // Start Logic to send Agent Info to Etran (Jayanth)
        // Agent Info (Loan packaging agent, the bank - SBA Lender)
        
        if(AgentInfoAvailable){
            
           requestDataObject.App[0].Agent.clear();          
            Agent agent = new Agent(MethodNamePhysical);
            if(methodNamePhysical == 'OrigUpdate'){
               agent.action = 'update';  
            }else{
                agent.action = 'insert'; 
            }
                
            agent.LoanAgentBusPerInd = 'B';
            agent.LoanAgentName = application.nSBA__Form_159_Business_Name_of_Agent__c ;
            agent.LoanAgentSeqNmb = '1';        
            String agentContactFullName  = application.nSBA__Form_159_Agent_Contact_Person__c ;
            String[] agentContNames     = agentContactFullName.split(' ');
            agent.LoanAgentFirstName = agentContNames[0] ; //LLC_BI__Application__r.nSBA__Form_159_Agent_Contact_Person__c
            agent.LoanAgentLastName = agentContNames[1] ;
            agent.LoanAgentType = '6'; // hardcoding to SBA LEnder     
            agent.LoanAgentZip4CD = '';
            agent.LoanAgentZipCD = application.nSBA__Form_159_Agent_Business_Zipcode__c;
            agent.LoanAgentStreet1 = application.nSBA__Form_159_Agent_Business_Street__c ;
            agent.LoanAgentStreet2 = '';
            agent.LoanAgentCity = application.nSBA__Form_159_Agent_Business_City__c;
            agent.LoanAgentStateCD = application.nSBA__Form_159_Agent_Business_State_2__c ;
            agent.LoanAgentCntCd ='US';
           
            requestDataObject.App[0].Agent.add(agent);            
                      
            //Agent Fees info
            requestDataObject.App[0].AgentFee.clear();
            Agentfee agentfee = new AgentFee(MethodNamePhysical);
            if(methodNamePhysical == 'OrigUpdate'){
               agentfee.action = 'update';  
            }else{
               agentfee.action = 'insert';
            }
            agentfee.LoanAgentAppCNTPaidAmt = String.valueOf(application.CF_Amount_Paid_by_Applicant__c);        
            agentfee.LoanAgentSeqNmb = '1' ;       
            agentfee.LoanAgentServTypCd = '1';
            agentfee.LoanAgntServOtherType = ''; 
            
            requestDataObject.App[0].Agentfee.add(agentfee);
        }
        
      if(ReferralAgentInfoAvailable){   
           //requestDataObject.App[0].Agent.clear();  // Remove this or what ?        
            Agent agentR = new Agent(MethodNamePhysical);
            if(methodNamePhysical == 'OrigUpdate'){
               agentR.action = 'update';  
            }else{
                agentR.action = 'insert'; 
            }
                
            agentR.LoanAgentBusPerInd = 'B';
            agentR.LoanAgentName = application.nSBA__Form_159_Business_Name_of_Referral_Agent__c ;
            agentR.LoanAgentSeqNmb = '2';        
            String agentContactFullName  = application.CF_Referral_Agent_Contact_Person__c ;
            String[] agentContNames     = agentContactFullName.split(' ');
            agentR.LoanAgentFirstName = agentContNames[0] ; //LLC_BI__Application__r.nSBA__Form_159_Agent_Contact_Person__c
            agentR.LoanAgentLastName = agentContNames[1] ;
            agentR.LoanAgentType = '2';
            agentR.LoanAgentZip4CD = '';
            agentR.LoanAgentZipCD = application.nSBA__Form_159_Referral_Agent_Business_Zipcode__c;
            agentR.LoanAgentStreet1 = application.nSBA__Form_159_Referral_Agent_Business_Street__c ;
            agentR.LoanAgentStreet2 = '';
            agentR.LoanAgentCity = application.nSBA__Form_159_Referral_Agent_Business_City__c ;
            agentR.LoanAgentStateCD = application.nSBA__Form_159_Referral_Agent_Business_State__c ;
            agentR.LoanAgentCntCd ='US';
           
            requestDataObject.App[0].Agent.add(agentR);            
            
            //Agent Fees info
            //requestDataObject.App[0].AgentFee.clear();
            Agentfee agentfee = new AgentFee(MethodNamePhysical);
            if(methodNamePhysical == 'OrigUpdate'){
               agentfee.action = 'update';  
            }else{
               agentfee.action = 'insert';
            }
          
            agentfee.LoanAgentSbaLenderPaidAmt = String.valueOf(application.CF_Amount_Paid_by_SBA_Lender__c);
            agentfee.LoanAgentSeqNmb = '2' ;       
            agentfee.LoanAgentServTypCd = '3';
            agentfee.LoanAgntServOtherType = ''; 
            
            requestDataObject.App[0].Agentfee.add(agentfee);
        }

        // End Logic to send Agent Info to Etran (Jayanth)
                 
        RequestData = JSON.serialize(requestDataObject);
        if (MethodNamePhysical == 'OrigUpdate') {
            RequestData = RequestData.replace('"ProcessingMethodCd":null,',''); //Can't update or change this field
        }
    }

    private class RequestData {
        private String version = '6.4';
        private String reason = '7AG Origination';
        private List<App> App;

        RequestData (String methodNamePhysical, Boolean hasUCI, Boolean hasCOO, Boolean hasUOP, Boolean hasCol,
                     Boolean hasInj, Boolean hasPrincipal, Boolean hasBorrower, Boolean hasAgentInfo) {
            App = new List<App> {new App(methodNamePhysical, hasUCI, hasCOO, hasUOP, hasCol,
                     hasInj, hasPrincipal, hasBorrower,hasAgentInfo)};
        }
    }

    private class App {
        private List<LoanApplication> LoanApplication;
        private List<Borrower> Borrower;
        private List<BusAppr> BusAppr;//new
        private List<ChangeOfOwnership> ChangeOfOwnership;//new
        //private List<Collateral> Collateral;//new
        private List<CreditUnavailReasons> CreditUnavailReasons;
        private List<Eligibility> Eligibility;
        private List<Injection> Injection;//new
        private List<Interest> Interest;
        private List<PartnerInformation> PartnerInformation;
        private List<Principal> Principal;
        private List<PrincipalRace> PrincipalRace;
        private List<SpecialPurpose> SpecialPurpose;
        private List<UseOfProceeds> UseOfProceeds;
        private List<Agent> Agent; //Jayanth Added this to pass Agent Info to Etran
        private List<AgentFee> AgentFee; //Jayanth Added this to pass AgentFee Info to Etran
        //private List<BorrowerRace> BorrowerRace;
        

        App (String methodNamePhysical, Boolean hasUCI, Boolean hasCOO, Boolean hasUOP, Boolean hasCol,
                     Boolean hasInj, Boolean hasPrincipal, Boolean hasBorrower, Boolean hasAgentInfo) {
            LoanApplication = new List<LoanApplication> {new LoanApplication(methodNamePhysical)};
            if(hasBorrower) Borrower = new List<Borrower> {new Borrower(methodNamePhysical)};
            if(hasPrincipal) Principal = new List<Principal>();
            if(hasUOP) UseOfProceeds = new List<UseOfProceeds>();
            if(hasInj) Injection = new List<Injection>();
            Interest = new List<Interest>();
            SpecialPurpose = new List<SpecialPurpose>();  
            if(hasAgentInfo) Agent = new List<Agent> {new Agent(methodNamePhysical)}; // Jayanth Added, to test Agent Info being sent to Etran   
            if(hasAgentInfo) AgentFee = new List<AgentFee> {new AgentFee(methodNamePhysical)}; // Jayanth Added, to test Agent Info being sent to Etran  
            //if(hasCol) Collateral = new List<Collateral>();
            if (methodNamePhysical != 'OrigUpdate') {
                if(hasCOO) ChangeOfOwnership = new List<ChangeOfOwnership>();
                if(hasPrincipal) PrincipalRace = new List<PrincipalRace>();
                if(hasUCI) CreditUnavailReasons = new List<CreditUnavailReasons>();
                Eligibility = new List<Eligibility> {new Eligibility('103'), new Eligibility('104')};
                PartnerInformation = new List<PartnerInformation> {new PartnerInformation()};
                BusAppr = new List<BusAppr>();
           }
        }
    }

        //Jayanth Added this to pass Agent Info to Etran
    private class Agent {
        private String action;
        private String LoanAgentBusPerInd;
        private String LoanAgentName ;
        private String LoanAgentFirstName;
		private String LoanAgentLastName;
        private String LoanAgentType;
        private String LoanAgentSeqNmb;
		private String LoanAgentZip4CD;
		private String LoanAgentZipCD;  
        private String LoanAgentStreet1;
        private String LoanAgentStreet2;
        private String LoanAgentCity;
        private String LoanAgentStateCD;
        private String LoanAgentCntCd;

         Agent (String methodNamePhysical) {
            action = methodNamePhysical == 'OrigUpdate' ? 'update' : 'insert';
        }
    } 
    
        private class AgentFee {
        private String action;
        private String LoanAgentAppCNTPaidAmt;
        private String LoanAgentSbaLenderPaidAmt ;
        private String LoanAgentSeqNmb ;
		private String LoanAgentServTypCd;
        private String LoanAgntServOtherType;

         AgentFee (String methodNamePhysical) {
            action = methodNamePhysical == 'OrigUpdate' ? 'update' : 'insert';
        }
    } 
    
    private class LoanApplication {
        private String action;
        private String AgentInvolved;
        private String BorrowerContribAmt = '';
        private String BorrowerContribPct = '';
        private String BusinessAgeCd = '';
        private String ClosingCostAmt = '';
        private String CollateralInd = '';
        private String CurrEmpQty = '';
        private String EligPassiveCompanyInd = '';
        private String EWCPPostShipmntInd = '';
        private String EWCPSnglTransInd = '';
        private String FrnchiseCd = '';
        private String FrnchiseDeferPymtInd = '';
        private String FrnchiseDeferPymtMonths = '';
        private String FrnchiseInd = '';
        private String FrnchiseName = '';
        private String FrnchiseOpporCureInd = '';
        private String FrnchiserBooksInd = '';
        private String FrnchiseWarnTermInd = '';
        private String FullAmortPymtInd = 'Y';
        private String FundingFeeAmt = '';
        private String GntyFeeAmt = '';
        private String InjectionInd = '';
        private String InterestStructureCd = '';
        private String JobRqmtMetInd = '';
        private String JobsCreatdQty = '';
        private String JobsRetaindQty = '';
        private String LenderAltContactCellPhn = '';
        private String LenderAltContactEmail = '';
        private String LenderAltContactFax = '';
        private String LenderAltContactFirstNm = '';
        private String LenderAltContactInitialNm = '';
        private String LenderAltContactLastNm = '';
        private String LenderAltContactNameSuffix = '';
        private String LenderAltContactPrimPhn = '';
        private String LenderAltContactTitlTxt = '';
        private String LenderAltContactTypCd = '';
        private String LenderApplicNmb = '';
        private String LenderCntctEmail = '';
        private String LenderCntctFax = '';
        private String LenderCntctFirstName;
        private String LenderCntctLastName;
        private String LenderCntctMiddleInitial = '';
        private String LenderCntctNameSuffix = '';
        private String LenderCntctPhnNmb;
        private String LenderCntctTitl = '';
        private String LenderContactCellPhn = '';
        private String LenderLoanNmb = '';
        private String LifeInsurRqmtInd = '';
        private String LimitCompensationAmt = '';
        private String LimitCompensationInd = '';
        private String LimitExemptionInd = '';
        private String LimitFixedAssetAmt = '';
        private String LimitFixedAssetInd = '';
        private String LimitLocation = '';
        private String LoanBusinessEstDt = '';
        private String LoanExtraordinaryServFeeAmt = '';
        private String LoanExtraordinaryServFeeInd = 'N';
        private String LoanName;
        private String LoanPackagerCityName = '';
        private String LoanPackagerName = '';
        private String LoanPackagerStCd = '';
        private String LoanPackagerStrtName1 = '';
        private String LoanPackagerStrtName2 = '';
        private String LoanPackagerZip4Cd = '';
        private String LoanPackagerZipCd = '';
        private String LoanPackageSourcTypCd = '';
        private String LoanTermAmortMnths = '';
        private String LoanTermMnths;
        private String LoanTermRevlMnths = '';
        private String LoanTermStartTypInd = '';
        private String MnthsIntrstOnlyQty = '';
        private String NAICSCd;
        private String NetDebentrAmt = '';
        private String NetEarningsClause = '';
        private String NetExprtAmt = '';
        private String NoteDt = '';
        private String OutPrgrmAreaOfOperInd = '';
        private String OverallPortfolioJobRatio = '';
        private String PayrollMnthlyAvgAmt;
        private String ProcessingFeeAmt = '';
        private String ProcessingMethodCd;
        private String ProjectCityName;
        private String ProjectStCd;
        private String ProjectStrtName1;
        private String ProjectStrtName2 = '';
        private String ProjectZip4Cd = '';
        private String ProjectZipCd;
        private String PymtAmt;
        private String PymtCeilingAndFloorCode = '';
        private String PymtCeilingMaxPct = '';
        private String PymtEscrowInd = 'N';
        private String PymtFloorMinPct = '';
        private String PymtFrequency = '';
        private String PymtIntOnlyDayOfMonth = '';
        private String PymtIntOnlyFreqCode = '';
        private String PymtIntOnlySkipMonths = '';
        private String PymtIntRateDeductionInd = '';
        private String PymtIntRateProgramOther = '';
        private String PymtLateChargeDays = '';
        private String PymtLateChargeInd = '';
        private String PymtLateChargePct = '';
        private String PymtNetEarnPrepayAmt = '';
        private String PymtNetEarnPrepayPct = '';
        private String PymtNetEarnRecaptureInd = '';
        private String PymtPrinAndIntDayOfMonth = '';
        private String PymtPrinAndIntSkipMonths = '';
        private String PymtSchedule = '';
        private String PymtTypeCode = '';
        private String ReconsiderationInd = '';
        private String RequestedAmt = '';
        private String RevolvingInd = '';
        private String RuralUrbanInd = '';
        private String SBAGntyPct = '';
        private String SeprateProcessFeeInd = '';
        private String StateLawComplianceForBulkInd = '';
        private String UnderwritingBy = '';
        private String UnderwrtrsFeeAmt = '';

        LoanApplication (String methodNamePhysical) {
            action = methodNamePhysical == 'OrigUpdate' ? 'update' : 'insert';
        }
    }

    private class Borrower {
        private String action = 'insert';
        private String TaxId;
        private String BusinessPersonInd = 'B';
        private String AlternateEmail = '';
        private String AlternatePhone = '';
        private String BnkrptcyInd = '';
        private String BooksToLenderType = '';
        private String BooksToLenderWithinDays = '';
        private String BusDUNSNmb = '';
        private String BusinessName = '';
        private String BusOutstandingDebtInd = '';
        private String BusPrimCntctNm = '';
        private String ChkngAcctBalanceAmt = '';
        private String ControlInterestType = '';
        private String CreditScorSourcCd = '';
        private String CurrBankName = '';
        private String CurrOwnrshpEstblshDt = '';
        private String EINCertInd = '';
        private String EPCOperatingCompnyCd = '';
        private String ExporterInd = '';
        private String ExtrnlCreditScorDt = '';
        private String ExtrnlCreditScorInd = '';
        private String ExtrnlCreditScorNmb = '';
        private String FedDisqualifiedInd = '';
        private String GamblingOrSexualNatureInd = '';
        private String InsurLiabInd = '';
        private String InsurLiabProductInd = '';
        private String InsurLiquorInd = '';
        private String InsurMalpracticeInd = '';
        private String InsurOtherDesc = '';
        private String InsurOtherInd = '';
        private String InsurWorkersCompInd = '';
        private String LawsuitInd = '';
        private String LegalOrgnztnCd = '';
        private String MailCityName = '';
        private String MailCountryCd = 'US';
        private String MailPostalCd = '';
        private String MailStCd = '';
        private String MailStNm = '';
        private String MailStrtName1 = '';
        private String MailStrtName2 = '';
        private String MailZip4Cd = '';
        private String MailZipCd = '';
        private String NonFedEmpInd = '';
        private String NonFmrSBAEmpInd = '';
        private String NonGS13EmpInd = '';
        private String NonLegBrnchEmpInd = '';
        private String NonSBACEmpInd = '';
        private String PaymentsLessThanCCInd = '';
        private String PhysCityName = '';
        private String PhysCountryCd = '';
        private String PhysPostalCd = '';
        private String PhysStCd = '';
        private String PhysStNm = '';
        private String PhysStrtName1;
        private String PhysStrtName2 = '';
        private String PhysZip4Cd = '';
        private String PhysZipCd = '';
        private String PrevGovFinInd = '';
        private String PrimaryBusinessInd = '';
        private String PrimaryEmail = '';
        private String PrimaryPhone = '';
        private String PriorSBALoanInd = '';
        private String TradeName = '';

        Borrower (String methodNamePhysical) {
            action = methodNamePhysical == 'OrigUpdate' ? 'update' : 'insert';
        }
    }
    
    private class BusAppr {
        private String action = 'insert';
        private String Ind = 'ABV';
    }
    
    private class ChangeOfOwnership {
        private String action = 'insert';
        private String AcctRecvAssetAmt =  '';
        private String BusApprFeeAmt =  '';
        private String BusApprNm =  '';
        private String BusBrkrAdr =  '';
        private String BusBrkrComisnAmt =  '';
        private String BusBrkrComisnInd =  '';
        private String BusBrkrNm =  '';
        private String BuyerEqtyBorrAmt =  '';
        private String BuyerEqtyCashAmt =  '';
        private String BuyerEqtyCashDescTxt =  '';
        private String BuyerEqtyOthAmt =  '';
        private String BuyerEqtyOthDescTxt =  '';
        private String CovntAssetAmt =  '';
        private String CustAssetAmt =  '';
        private String EquipAssetAmt =  '';
        private String EquipValTypInd =  '';
        private String FixAssetAmt =  '';
        private String FrnchsAssetAmt =  '';
        private String GoodwillAssetAmt =  '';
        private String IntangAssetAmt =  '';
        private String InvtryAssetAmt =  '';
        private String LicnsAssetAmt =  '';
        private String Loan7aPymtAmt =  '';
        private String OthAssetAmt =  '';
        private String OthAssetDescTxt =  '';
        private String OthIntangAssetAmt =  '';
        private String OthIntangAssetDescTxt =  '';
        private String ReAssetAmt =  '';
        private String RevalTypInd =  '';
        private String SellerFinanFullStbyAmt =  '';
        private String SellerFinanNonFullStbyAmt =  '';
        private String TotApprAmt =  '';
        private String TotAssetAmt =  '';
    }
    
    /*private class Collateral {
        private String action =  '';
        private String ZipCd =  '';
    }*/
    
    private class CreditUnavailReasons {
        private String action = 'insert';
        private String CreditUnavailReasonCd = '';
        private String CreditUnavailReasonCommnt = '';
    }

    private class Eligibility {
        private String action = 'insert';
        private String EligibleCd;
        private String EligibleInd = 'Y';

        Eligibility(String code){
            EligibleCd = code;
        }
    }

    private class Injection {
        private String action = 'insert';
        private String InjctnAmt = '';
        private String InjctnOthDescTxt = '';
        private String InjctnTermNotLessThanYrNmb = '';
        private String InjctnTypCd = '';
    }
    
    private class Interest {
        private String action = 'insert';
        private String Phase = '1';
        private String AdjustPeriodCd = '';
        private String AdjustPeriodMnths = '';
        private String BaseIntrstRatePct = '';
        private String BaseRateSourcTypCd = 'WSJ'; //TODO: might change with Prime Reference
        private String BorrIntrstRatePct = '';
        private String FirstRateAdjustDt = '';
        private String IntrstGuaranteeInd = '';
        private String IntrstTypInd = '';
        private String ShareOfTotalMnths = '';
        private String ShareOfTotalPct = '100.000';
    }

    private class PartnerInformation {
        private String action = 'insert';
        private String ACHAccountNmb;
        private String ACHAccountType;
        private String ACHTaxId;
        private String ACHRoutingNmb;
        private String LocationId='41214';
    }

    private class Principal {
        private String action = 'insert';
        private String BusinessTaxId;
        private String TaxId;
        private String BusinessPersonInd = 'P';
        private String AlienRgstrtnNmb = '';
        private String AlternateEmail = '';
        private String AlternatePhone = '';
        private String BirthCityName = '';
        private String BirthCntryName = '';
        private String BirthDt = '';
        private String BirthStCd = '';
        private String BnkrptcyInd = '';
        private String CitznShipCntryName = '';
        private String ControlInterestType = '';
        private String ConvictdInd = '';
        private String CreditScorSourcCd = '';
        private String CrmnlOffnsInd = '';
        private String CSP60DayDelnqInd = '';
        private String EthnicCd = '';
        private String ExtrnlCreditScorDt = '';
        private String ExtrnlCreditScorInd = '';
        private String ExtrnlCreditScorNmb = '';
        private String FedDisqualifiedInd = '';
        private String FedEmplyAffiltInd = '';
        private String FirstName = '';
        private String FngrprntWaivDt = '';
        private String GndrCd = '';
        private String GntyInd = '';
        private String GntyLimitAmt = '';
        private String GntyLimitCd = '';
        private String GntyLimitCollatSeqNmb = '';
        private String GntyLimitPct = '';
        private String GntyLimitYrNmb = '';
        private String GntyTypCd = '';
        private String IndctPrleProbatnInd = '';
        private String InsuranceAmt = '';
        private String InsuranceDisabInd = '';
        private String InsuranceLifeInd = '';
        private String InsureDisabNames = '';
        private String InsureName = '';
        private String IntrstOthBusinessInd = '';
        private String LastName;
        private String LawsuitInd = '';
        private String LglActnInd = '';
        private String MailCityName = '';
        private String MailCountryCd = '';
        private String MailPostalCd = '';
        private String MailStCd = '';
        private String MailStNm = '';
        private String MailStrtName1 = '';
        private String MailStrtName2 = '';
        private String MailZip4Cd = '';
        private String MailZipCd = '';
        private String MiddleInitial = '';
        private String NameSuffix = '';
        private String NoNCACompetitorName = '';
        private String NoNCAInd = 'N';   //HardCode
        private String OwnrshpInBusinessPct;
        private String PhysCityName = '';
        private String PhysCountryCd = 'US';
        private String PhysPostalCd = '';
        private String PhysStCd = '';
        private String PhysStNm = '';
        private String PhysStrtName1 = '';
        private String PhysStrtName2 = '';
        private String PhysZip4Cd = '';
        private String PhysZipCd = '';
        private String PrimaryEmail = '';
        private String PrimaryPhone = '';
        private String PrimBusExprnceYrNmb = '';
        private String Title = '';
        private String USCitznInd = '';
        private String VetCd = '';
        private String VetCertInd = '';

        Principal (String methodNamePhysical) {
            action = methodNamePhysical == 'OrigUpdate' ? 'update' : 'insert';
        }
    }

    private class PrincipalRace {
        private String action = 'insert';
        private String TaxId;
        private String BusinessPersonInd = 'P';
        private String RaceCd = '';
    }

    private class SpecialPurpose {
        private String action;
        private String SpcPurpsLoanCd = '';
    }

    private class UseOfProceeds {
        private String action = 'insert';
        private String ProceedTypCd = '';
        private String LoanProceedTypCd = '';
        private String ProceedAmt;
        private String ProceedOthTypTxt = '';
        private String PurchaseAgrmtDt = '';
        private String PurchaseAgrmtNCAInd = '';
        private String PurchaseIntngblAssetAmt = '';
        private String PurchaseIntngblAssetDescTxt = '';
        private String RefDescTxt = '';
        private String StockholderName = '';
    }
     
}