/*********************************************************************************************************
*@author    : PwC Team
*@date      : April 30th 2020
*@description : This class used in lightning component - 
*@Modification Log   :
Change History Story              Modify by               Date                          Desc
**********************************************************************************************************/
public without sharing class TM_AccountPageController {

    /*********************************************************************************************************
    /* Method Name : getAccountDetails
    * param : accountId
    *purpose :
    **********************************************************************************************************/
    //get account details for header
    @auraEnabled
    public static AccountWrapper getAccountDetails(Id accountId){
        try{
            // Integer totalOpenCases = 0;
            Decimal totalBankDeposits = 0;
            Integer totalProducts = 0;
            Decimal totalLoans = 0;
            Decimal totalDeposits = 0;
            Decimal totalTreasury = 0;
            Decimal loanAmount = 0;
            String address = '';
            Decimal annualRevenue = 0;
            
            // account info
            Account account = [SELECT Id,RecordTypeId, Name, Industry, AnnualRevenue, FinServ__TotalBankDeposits__c, Phone, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry,Website,OwnerId,Account.Owner.Name, CIF__c, nSBA__External_Credit_Score__c,Relationship_Manager__c FROM Account WHERE Id =: accountId]; 

            // sum of Loan amount
            AggregateResult[] groupedLoans = [SELECT SUM(LLC_BI__Amount__c)sumOfLoan FROM LLC_BI__Loan__c WHERE LLC_BI__Account__c =:accountId AND LLC_BI__Stage__c = 'Booked'];
            totalLoans = groupedLoans[0].get('sumOfLoan') == null ? 0 : (Decimal)groupedLoans[0].get('sumOfLoan');
            totalLoans = totalLoans.divide(1000000, 2);

            // count of Open cases
            // AggregateResult[] groupedCases = [SELECT Count(Id)casesCount FROM Case WHERE AccountId =:accountId AND Status != 'Closed'];
            // totalOpenCases = (Integer) groupedCases[0].get('casesCount');
            // totalOpenCases = totalOpenCases.divide(1000000, 2);

            //count of Treasury Products
            AggregateResult[] groupedproducts = [SELECT Count(Id)productCount FROM Treasury_Product__c WHERE Account_Name__c =:accountId];
            totalProducts = (Integer) groupedproducts[0].get('productCount');

            // RecordType=[SELECT Name FROM RecordType WHERE Id=:account.RecordTypeId].Name;     
            if (account.BillingStreet != null) {
                address = account.BillingStreet + ' ';
            }
            if (account.BillingCity != null) {
                address += account.BillingCity+' ';
            }
            if (account.BillingState != null) {
                address += account.BillingState + ' ';
            }
            if (account.BillingPostalCode != null) {
                address += account.BillingPostalCode;
            }
            
            //if annual revenue is not null
            if(account.AnnualRevenue !=null) {
                annualRevenue= (account.AnnualRevenue)/1000000;
            }   

            //if Total Bank Deposits is not null
            if(account.FinServ__TotalBankDeposits__c !=null) {
                totalBankDeposits = (account.FinServ__TotalBankDeposits__c)/1000000;
            }      
            
            List<Opportunity> opportunityList = [SELECT Id, StageName, TM_Anticipated_Deposit_Amount__c, TM_Projected_Annual_Treasury_Fee_Income__c, TM_New_Money__c, Loan_Amount__c, RecordType.Name FROM Opportunity WHERE AccountId = :accountId];            
            for(Opportunity opp:opportunityList){
                if (opp.RecordType.Name == 'Loan' && opp.Loan_Amount__c != null && opp.StageName == 'Closed Won') {
                    // totalLoans += opp.Loan_Amount__c;
                    // if (opp.StageName == 'Closed Won') {
                    loanAmount += opp.Loan_Amount__c;
                    // }
                }else if (opp.RecordType.Name == 'Track Deposit Pipeline' && opp.TM_Anticipated_Deposit_Amount__c != null) {
                    totalDeposits += opp.TM_Anticipated_Deposit_Amount__c;
                }else if (opp.RecordType.Name == 'Track Treasury Products Sold' && opp.TM_Projected_Annual_Treasury_Fee_Income__c != null) {
                    totalTreasury += opp.TM_Projected_Annual_Treasury_Fee_Income__c;
                }
            }
            
            totalDeposits = totalDeposits.divide(1000000, 2);
            totalTreasury = totalTreasury.divide(1000000, 2);
            loanAmount = loanAmount.divide(1000000, 2);
            // outstandingOppty = outstandingOppty.divide(1000000, 2);
            AccountWrapper aw = new AccountWrapper(account, totalBankDeposits, totalLoans, address, annualRevenue, totalDeposits, totalTreasury, loanAmount, totalProducts);
            return aw;
        }catch(Exception expt){
            // throw exception
            throw new AuraHandledException(System.Label.TM_StdErrorMessage);
        }   
    }
    
    //Account Wrapper
    public class AccountWrapper{
        @AuraEnabled public Account acc;
        // @AuraEnabled public Integer totalOpenCases;
        @AuraEnabled public Decimal totalBankDeposits;
        @AuraEnabled public Decimal totalLoans;
        // @AuraEnabled public Decimal outstandingOppty;
        // @AuraEnabled public Decimal roec;
        @auraEnabled public String address;
        @AuraEnabled public Decimal annualRevenue;
        @AuraEnabled public Decimal totalDeposits;
        @AuraEnabled public Decimal totalTreasury;
        @AuraEnabled public Decimal loanAmount;
        @AuraEnabled public Integer totalTreasuryProducts;
        
        /**
         * @description AccountWrapper description
         * @param  acc                   acc description
         * @param  totalBankDeposits        totalBankDeposits description
         * @param  totalLoans            totalLoans description
         * @param  address               address description
         * @param  annualRevenue         annualRevenue description
         * @param  totalDeposits         totalDeposits description
         * @param  totalTreasury         totalTreasury description
         * @param  loanAmount            loanAmount description
         * @param  totalTreasuryProducts totalTreasuryProducts description
         * @return                       return description
         */ 
        public AccountWrapper(Account acc, Decimal totalBankDeposits, Decimal totalLoans, String address, Decimal annualRevenue, Decimal totalDeposits, Decimal totalTreasury, Decimal loanAmount, Integer totalTreasuryProducts){
            // this.WonOppFYTD=WonOppFYTD;            
            // this.RecordType=RecordType;
            // this.Executive=Executive;
            this.acc = acc;
            // this.totalOpenCases = totalOpenCases;
            this.totalBankDeposits = totalBankDeposits;
            this.totalLoans = totalLoans;
            // this.outstandingOppty = outstandingOppty;
            // this.roec = roec;
            this.address = address;
            this.annualRevenue = annualRevenue;
            this.totalDeposits = totalDeposits;
            this.totalTreasury = totalTreasury;
            this.loanAmount = loanAmount;
            this.totalTreasuryProducts = totalTreasuryProducts;
        }
    }
}