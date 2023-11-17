/*********************************************************************************************************
*@author    : PwC Team
*@date      : December 24th 2020
*@description : This class used in lightning component - 
*@Modification Log   :
Change History Story              Modify by               Date                          Desc
/**********************************************************************************************************
 *                               Sagar                    14/10/2021                 Modified getRMopportunities method
 *  
 */
 
public class Commercial_RMHomeHeaderController{
    
    /*
    * Method Name : getRMopportunities :Method used to fetch the Opportunities,Amount,Deposit and credit balance
    * Parameters  : String sorttype
    *               String sortorder
    * Return Type : RMOpportunitiesWrapper 
    */
    @AuraEnabled
    public static RMOpportunitiesWrapper  getRMopportunities(String sorttype,String sortorder) {
        String endDecimal = '.00';
        Decimal amountSum;
        Decimal sumDepositBal;
        Decimal sumCreditBal;
        Integer countCore;
        Decimal commercialRelationships;
        Decimal coreTreasuryProducts;
        Integer countAccHasCIF;
        List<Opportunity> opplst;
        AggregateResult[] groupedResults;
        AggregateResult[] accResults;
        
        // AggregateResult[] groupedOppResults;
        AggregateResult[] groupedOppLoanRes;
        AggregateResult[] groupedOppTreasuryRes;
        // AggregateResult[] groupedAnnualGoalsOppResults;
        // AggregateResult[] countTreasuryProductsOppResults;
        // AggregateResult[] countAccHasCIFResults;

        List<Treasury_Goals__c> treasuryGoals;

        Decimal sumOfclosedWon;
        Decimal sumOfLoan;
        Decimal sumOfTreasury;
        Decimal annualGoals;
        //currentFiscalYear = [SELECT FiscalYearSettings.Name FROM Period WHERE Type = 'Year' AND StartDate <= TODAY AND EndDate >= TODAY].FiscalYearSettings.Name;
        try{
            //Instance of the wrapper class to hold the values of variables in getRMopportunities
            RMOpportunitiesWrapper RMoppWrap = new RMOpportunitiesWrapper();  
            string profileName = TM_Utility.getprofileInfo(userinfo.getProfileId());
            
            //get the total annual goals of the current fiscal year
            // if(profileName!=null && profileName.equalsIgnoreCase('Wealth Advisor')){
            //     groupedAnnualGoalsOppResults = [SELECT SUM(Business_Development_Goal__r.Annual_Goal__c)annualGoal from Opportunity WHERE OwnerId =:Userinfo.getUserId() AND CloseDate = THIS_FISCAL_YEAR];
            // }
            // else{
            //     groupedAnnualGoalsOppResults = [SELECT SUM(Business_Development_Goal__r.Annual_Goal__c)annualGoal from Opportunity WHERE OwnerId =:Userinfo.getUserId() AND CloseDate = THIS_FISCAL_YEAR];
            // }
            
            //to show the sales achievement progress bar on RM Cockpit page banner
            // if(profileName!=null && profileName.equalsIgnoreCase('Wealth Advisor')){
            //     groupedOppResults = [SELECT SUM(amount)sumA,SUM(Loan_Amount__c)sumL FROM Opportunity WHERE OwnerId =:Userinfo.getUserId() AND CloseDate =THIS_FISCAL_YEAR AND (Stagename = 'Post Approval Activities' OR Stagename='Closed Won') AND (RecordType.Name = 'Loan' OR RecordType.Name = 'Treasury')];
            // }
            // else{
            //     groupedOppResults = [SELECT SUM(amount)sumA,SUM(Loan_Amount__c)sumL FROM Opportunity WHERE OwnerId =:Userinfo.getUserId() AND CloseDate =THIS_FISCAL_YEAR AND (Stagename = 'Post Approval Activities' OR Stagename='Closed Won') AND (RecordType.Name = 'Loan' OR RecordType.Name = 'Treasury')];
            // }
            
            groupedOppLoanRes = [SELECT SUM(Loan_Amount__c)sum FROM Opportunity WHERE OwnerId =:Userinfo.getUserId() AND Stagename NOT IN ('Closed Won','Closed Lost','Closed-ERROR') AND RecordType.Name = 'Loan'];
            
            groupedOppTreasuryRes = [SELECT SUM(TM_New_Money__c)sum FROM Opportunity WHERE OwnerId =:Userinfo.getUserId() AND Stagename NOT IN ('Onboarding','Closed Lost','Closed-ERROR') AND RecordType.Name = 'Track Deposit Pipeline'];
            
            if(profileName!=null && profileName.equalsIgnoreCase('Wealth Advisor')){
                groupedResults = [SELECT SUM(amount)sumA,SUM(Loan_Amount__c)sumL FROM Opportunity WHERE OwnerId =:Userinfo.getUserId() AND StageName NOT IN ('Onboarding','Closed Won','Closed Lost','Closed-ERROR') AND RecordType.Name = 'Treasury'];
            }
            else{
                groupedResults = [SELECT SUM(amount)sumA,SUM(Loan_Amount__c)sumL FROM Opportunity WHERE OwnerId =:Userinfo.getUserId() AND StageName NOT IN ('Onboarding','Closed Won','Closed Lost','Closed-ERROR') AND (RecordType.Name = 'Loan' OR RecordType.Name = 'Treasury')];
            }
            accResults = [SELECT SUM(Account.FinServ__TotalBankDeposits__c)depositbalance,SUM(Account.FinServ__TotalOutstandingCredit__c)creditbalance FROM Account WHERE OwnerId =:Userinfo.getUserId()];
            
            // countTreasuryProductsOppResults = [SELECT COUNT(Id)coreCount from Opportunity WHERE OwnerId =:Userinfo.getUserId() AND CF_Core_Treasury_Product__c  = 'YES' AND (RecordType.Name = 'Loan' OR RecordType.Name = 'Treasury')];

            List<Period> periods = [SELECT FiscalYearSettings.Name FROM Period WHERE Type = 'Year' AND StartDate <= TODAY AND EndDate >= TODAY];
            String currentFiscalYear = '';
            if (periods.size() > 0) {
                currentFiscalYear = periods[0].FiscalYearSettings.Name;
            }else {
                currentFiscalYear = String.valueOf(System.today().year());
            }

            treasuryGoals = [SELECT TM_of_New_Commercial_Relationships__c, TM_of_New_Core_Treasury_Products_Sold__c, TM_New_Money_Commercial_Deposit_s__c, TM_New_Money_Till_Date__c, TM_New_Commercial_Relationships_Till__c, TM_New_Core_Treasury_Products_Sold_Till__c FROM Treasury_Goals__c WHERE TM_Treasury_Solutions_Officer__c =:Userinfo.getUserId() AND TM_Fiscal_Year__c =:currentFiscalYear];

            // countAccHasCIFResults = [SELECT COUNT(Id)countAccHasCIF from Account WHERE OwnerId =:Userinfo.getUserId() AND CIF__c <> null];
            
            String querystr='SELECT Id,Name,StageName,format(CloseDate),format(Amount),format(LastActivityDate) FROM Opportunity  WHERE StageName NOT IN (\'Onboarding\',\'Closed Lost\',\'Closed Won\',\'Closed-ERROR\') AND OwnerId =\''+Userinfo.getUserId() +'\' ORDER BY '+ sorttype +' '+ sortorder + ' NULLS LAST';
            //system.debug('tets'+querystr);
            //fire the query
            opplst= Database.query(querystr);
            // sumOfclosedWon = (groupedOppResults[0].get('sumA') != null ? (Decimal)groupedOppResults[0].get('sumA') : 0) + (groupedOppResults[0].get('sumL') != null ? (Decimal)groupedOppResults[0].get('sumL') : 0);
            
            sumOfLoan = (Decimal)groupedOppLoanRes[0].get('sum');
            sumOfTreasury = (Decimal)groupedOppTreasuryRes[0].get('sum');
            amountSum = (groupedResults[0].get('sumA') != null ? (Decimal)groupedResults[0].get('sumA') : 0) + (groupedResults[0].get('sumL') != null ? (Decimal)groupedResults[0].get('sumL') : 0);
            sumDepositBal = (Decimal)accResults[0].get('depositbalance');
            sumCreditBal = (Decimal)accResults[0].get('creditbalance');
            // annualGoals = (Decimal)groupedAnnualGoalsOppResults[0].get('annualGoal');
            // countCore = (Integer)countTreasuryProductsOppResults[0].get('coreCount');
            // countAccHasCIF = countAccHasCIFResults.size() > 0 ? (Integer)countAccHasCIFResults[0].get('countAccHasCIF') : 0;
            if (treasuryGoals.size() > 0) {
                sumOfclosedWon = (Decimal)treasuryGoals[0].TM_New_Money_Till_Date__c;
                countCore = (Integer)treasuryGoals[0].TM_New_Core_Treasury_Products_Sold_Till__c;
                // commercialRelationships = (Decimal)treasuryGoals[0].TM_of_New_Commercial_Relationships__c;
                coreTreasuryProducts = (Decimal)treasuryGoals[0].TM_of_New_Core_Treasury_Products_Sold__c;
                annualGoals = (Decimal)treasuryGoals[0].TM_New_Money_Commercial_Deposit_s__c;
                countAccHasCIF = (Integer)treasuryGoals[0].TM_New_Commercial_Relationships_Till__c;
            }else {
                sumOfclosedWon = 0;
                countCore = 0;
                commercialRelationships = 0;
                coreTreasuryProducts = 0;
                annualGoals = 0;
                countAccHasCIF = 0;
            }
            
            if(annualGoals>0){
                //FWB prep - divides the amountSum by 1000000 and format according to locale of user
                String annualGoalAmt = (annualGoals.divide(1000000, 2).format().contains('.')?annualGoals.divide(1000000, 2).format():(annualGoals.divide(1000000, 2).format()+endDecimal));
                Decimal annualGoalAmtDec = Decimal.valueOf(annualGoalAmt);
                RMoppWrap.AnnualGoal = annualGoalAmtDec.setScale(2, RoundingMode.HALF_UP) + ' M';
            }else{
                RMoppWrap.AnnualGoal = '';
            }
            
            if(sumOfclosedWon>0){
                //FWB prep - divides the amountSum by 1000000 and format according to locale of user
                String closedWonAmt = (sumOfclosedWon.divide(1000000, 2).format().contains('.')?sumOfclosedWon.divide(1000000, 2).format():(sumOfclosedWon.divide(1000000, 2).format()+endDecimal));
                Decimal closedWonPercentage = Decimal.valueOf(closedWonAmt);
                RMoppWrap.closedWon = closedWonPercentage.setScale(2, RoundingMode.HALF_UP) + ' M';
            }else{
                RMoppWrap.closedWon = '';
            }
            
            if(sumOfLoan>0){
                String loanAmt = (sumOfLoan.divide(1000000, 2).format().contains('.')?sumOfLoan.divide(1000000, 2).format():(sumOfLoan.divide(1000000, 2).format()+endDecimal));
                RMoppWrap.loanSum = loanAmt + ' M';
            }else{
                RMoppWrap.loanSum = '';
            }
            //system.debug('sumOfTreasury'+sumOfTreasury);
            if(sumOfTreasury>0){
                String treasuryAmt = (sumOfTreasury.divide(1000000, 2).format().contains('.')?sumOfTreasury.divide(1000000, 2).format():(sumOfTreasury.divide(1000000, 2).format()+endDecimal));
                RMoppWrap.treasurySum = treasuryAmt + ' M';
            }else{
                RMoppWrap.treasurySum = '';
            }
            
            if(amountSum>0){
              //FWB prep - divides the amountSum by 1000000 and format according to locale of user
              String formattedAmountSum = (amountSum.divide(1000000, 2).format().contains('.')?amountSum.divide(1000000, 2).format():(amountSum.divide(1000000, 2).format()+endDecimal));
              RMoppWrap.resultSum = formattedAmountSum + ' M';
                //formattedAmountSum.setScale(2, RoundingMode.HALF_UP)
            }else{
                RMoppWrap.resultSum = '';
            }
            if(sumDepositBal>0){
                //FWB prep - divides the amountSum by 1000000 and format according to locale of user
                String formattedDepositBal = (sumDepositBal.divide(1000000, 2).format().contains('.')?sumDepositBal.divide(1000000, 2).format():(sumDepositBal.divide(1000000, 2).format()+endDecimal));
                RMoppWrap.depositSum =  formattedDepositBal + ' M';
                //formattedDepositBal.setScale(2, RoundingMode.HALF_UP)
            }else{
                RMoppWrap.depositSum = '';  
            }
            if(sumCreditBal>0){
                //RMoppWrap.creditsum = sumCreditBal.format(); 
                String formattedCredBal = (sumCreditBal.divide(1000000, 2).format().contains('.')?sumCreditBal.divide(1000000, 2).format():(sumCreditBal.divide(1000000, 2).format()+endDecimal));
                RMoppWrap.creditsum = formattedCredBal + ' M';
                //formattedCredBal.setScale(2, RoundingMode.HALF_UP)
            }else{
                RMoppWrap.creditsum = '';   
            }
            
            //calculate the percentage of sumOfclosedWon upon annualGoals
            if(sumOfclosedWon>0 && annualGoals>0){
                Decimal Calpercentage = (sumOfclosedWon/annualGoals)*100;
                RMoppWrap.percentage = Calpercentage.setScale(2, RoundingMode.HALF_UP);
            }
            else{
                RMoppWrap.percentage = 0.00;
            }
            
            //calculate the percentage of countCore upon annualGoals
            if (coreTreasuryProducts>0) {
                RMoppWrap.coreTreasuryProdGoal = coreTreasuryProducts;
            }else {
                RMoppWrap.coreTreasuryProdGoal = 0;
            }
            if(countCore>0){
                RMoppWrap.coreCount = countCore;
                if (coreTreasuryProducts>0) {
                    Decimal coreCalPercentage = (countCore/coreTreasuryProducts)*100;
                    RMoppWrap.corePercentage = coreCalPercentage.setScale(2, RoundingMode.HALF_UP);
                }
                else {
                    RMoppWrap.coreTreasuryProdGoal = 0;
                    RMoppWrap.corePercentage = 0.00;
                }
            }
            else{
                RMoppWrap.coreCount = 0;
                RMoppWrap.corePercentage = 0.00;
            }

            if (commercialRelationships > 0) {
                RMoppWrap.commercialGoal = commercialRelationships;
            }else {
                RMoppWrap.commercialGoal = 0;
            }

            if (countAccHasCIF > 0) {
                RMoppWrap.commercialCount = countAccHasCIF;
                if (commercialRelationships > 0) {
                    RMoppWrap.commercialPercentage = (countAccHasCIF/commercialRelationships*100).setScale(2, RoundingMode.HALF_UP);
                }else {
                    RMoppWrap.commercialPercentage = 0.00;
                }
            }else {
                RMoppWrap.commercialCount = 0;
                RMoppWrap.commercialPercentage = 0.00;
            }
            
            RMoppWrap.oppWraplst = opplst;
            //return Wrapper
            return RMoppWrap;        
        } catch (Exception ex) {
            // Convert the error to Aura Exception.
            
            throw new AuraHandledException(System.Label.TM_StdErrorMessage);
        } 
    }
    
    //Wrapper class have variable which are used in getRMopportunities method returned to lightning component.
    public class  RMOpportunitiesWrapper {
        @AuraEnabled public string resultSum {get;set;}
        @AuraEnabled public string depositSum {get;set;}
        @AuraEnabled public string creditsum {get;set;}
        @AuraEnabled public string closedWon {get;set;}
        @AuraEnabled public string loanSum {get;set;}
        @AuraEnabled public string treasurySum {get;set;}
        @AuraEnabled public integer coreCount {get;set;}
        @AuraEnabled public Decimal percentage {get;set;}
        @AuraEnabled public Decimal corePercentage {get;set;}
        @AuraEnabled public string AnnualGoal {get;set;}
        @AuraEnabled public List<Opportunity> oppWraplst {get;set;}
        @AuraEnabled public Decimal commercialGoal {get;set;}
        @AuraEnabled public Decimal coreTreasuryProdGoal {get;set;}
        @AuraEnabled public Integer commercialCount {get;set;}
        @AuraEnabled public Decimal commercialPercentage {get;set;}
    }
}