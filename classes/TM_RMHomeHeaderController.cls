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
 
public class TM_RMHomeHeaderController{
    
    /**
     * @description getRMopportunities description
     * @param  sorttype  sorttype description
     * @param  sortorder sortorder description
     * @return           return description
     */ 
    @AuraEnabled
    public static RMOpportunitiesWrapper  getRMopportunities() {
        
        String endDecimal = '.00';
        // Decimal amountSum;
        Integer countCore;
        Decimal commercialRelationships;
        Decimal coreTreasuryProducts;
        Integer countAccHasCIF;
        // List<Opportunity> opplst;
        // AggregateResult[] groupedResults;
        AggregateResult[] groupedOppDepositRes;
        AggregateResult[] groupedOppTreasuryRes;
        AggregateResult[] groupedCustomers;

        List<Treasury_Goals__c> treasuryGoals;

        Decimal sumOfclosedWon;
        Decimal sumOfDeposit;
        Decimal sumOfTreasury;
        Decimal annualGoals;
        try{
            //Instance of the wrapper class to hold the values of variables in getRMopportunities
            RMOpportunitiesWrapper RMoppWrap = new RMOpportunitiesWrapper();
            // get Deposit Opportunity
            groupedOppDepositRes = [SELECT SUM(TM_Anticipated_Deposit_Amount__c)sum FROM Opportunity WHERE OwnerId =:Userinfo.getUserId() AND RecordType.Name = 'Track Deposit Pipeline'];
            // get Treasury Opportunity
            groupedOppTreasuryRes = [SELECT SUM(TM_Projected_Annual_Treasury_Fee_Income__c)sum FROM Opportunity WHERE OwnerId =:Userinfo.getUserId() AND RecordType.Name = 'Track Treasury Products Sold'];
            //get Fiscal Year
            List<Period> periods = [SELECT FiscalYearSettings.Name FROM Period WHERE Type = 'Year' AND StartDate <= TODAY AND EndDate >= TODAY];
            String currentFiscalYear = '';
            if (periods.size() > 0) {
                currentFiscalYear = periods[0].FiscalYearSettings.Name;
            }else {
                currentFiscalYear = String.valueOf(System.today().year());
            }
            // get Treasury Goal for Annual goal and till Date goals
            treasuryGoals = [SELECT TM_of_New_Commercial_Relationships__c, TM_of_New_Core_Treasury_Products_Sold__c, TM_New_Money_Commercial_Deposit_s__c, TM_New_Money_Till_Date__c, TM_New_Commercial_Relationships_Till__c, TM_New_Core_Treasury_Products_Sold_Till__c FROM Treasury_Goals__c WHERE TM_Treasury_Solutions_Officer__c =:Userinfo.getUserId() AND TM_Fiscal_Year__c =:currentFiscalYear AND TM_Active__c= true];

            groupedCustomers = [SELECT COUNT(Id)customerCount FROM Account WHERE TM_Treasury_Officer__c = :Userinfo.getUserId()];
            RMoppWrap.customerCount = (Integer)groupedCustomers[0].get('customerCount');
            
            sumOfDeposit = (Decimal)groupedOppDepositRes[0].get('sum');
            sumOfTreasury = (Decimal)groupedOppTreasuryRes[0].get('sum');
            // amountSum = (groupedResults[0].get('sumA') != null ? (Decimal)groupedResults[0].get('sumA') : 0) + (groupedResults[0].get('sumL') != null ? (Decimal)groupedResults[0].get('sumL') : 0);

            if (treasuryGoals.size() > 0) {
                //set goals value
                sumOfclosedWon = (Decimal)treasuryGoals[0].TM_New_Money_Till_Date__c;
                countCore = (Integer)treasuryGoals[0].TM_New_Core_Treasury_Products_Sold_Till__c;
                commercialRelationships = (Decimal)treasuryGoals[0].TM_of_New_Commercial_Relationships__c;
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
                //format AnnualGoal
                //FWB prep - divides the amountSum by 1000000 and format according to locale of user
                String annualGoalAmt = (annualGoals.divide(1000000, 2).format().contains('.')?annualGoals.divide(1000000, 2).format():(annualGoals.divide(1000000, 2).format()+endDecimal));
                Decimal annualGoalAmtDec = Decimal.valueOf(annualGoalAmt);
                RMoppWrap.AnnualGoal = annualGoalAmtDec.setScale(2, RoundingMode.HALF_UP) + ' M';
            }else{
                RMoppWrap.AnnualGoal = '';
            }
            
            if(sumOfclosedWon>0){
                //format closedWon
              	//FWB prep - divides the amountSum by 1000000 and format according to locale of user
              	String closedWonAmt = (sumOfclosedWon.divide(1000000, 2).format().contains('.')?sumOfclosedWon.divide(1000000, 2).format():(sumOfclosedWon.divide(1000000, 2).format()+endDecimal));
              	Decimal closedWonPercentage = Decimal.valueOf(closedWonAmt);
                RMoppWrap.closedWon = closedWonPercentage.setScale(2, RoundingMode.HALF_UP) + ' M';
            }else{
                RMoppWrap.closedWon = '';
            }
            
            if(sumOfDeposit>0){
                //format depositSum
              	String depositSum = (sumOfDeposit.divide(1000000, 2).format().contains('.')?sumOfDeposit.divide(1000000, 2).format():(sumOfDeposit.divide(1000000, 2).format()+endDecimal));
               	RMoppWrap.depositSum = depositSum + ' M';
            }else{
                RMoppWrap.depositSum = '';
            }
            // system.debug('sumOfTreasury'+sumOfTreasury);
            if(sumOfTreasury>0){
                //format treasurySum
                String treasuryAmt = (sumOfTreasury.divide(1000000, 2).format().contains('.')?sumOfTreasury.divide(1000000, 2).format():(sumOfTreasury.divide(1000000, 2).format()+endDecimal));
              	RMoppWrap.treasurySum = treasuryAmt + ' M';
            }else{
                RMoppWrap.treasurySum = '';
            }

            //calculate the percentage of sumOfclosedWon upon annualGoals
            if(sumOfclosedWon>0 && annualGoals>0){
                //format percentage
                Decimal Calpercentage = (sumOfclosedWon/annualGoals)*100;
                RMoppWrap.percentage = Calpercentage.setScale(2, RoundingMode.HALF_UP);
            }
            else{
                RMoppWrap.percentage = 0.00;
            }
            
            //calculate the percentage of countCore upon annualGoals
            if (coreTreasuryProducts>0) {
                //format coreTreasuryProdGoal
                RMoppWrap.coreTreasuryProdGoal = coreTreasuryProducts;
            }else {
                RMoppWrap.coreTreasuryProdGoal = 0;
            }
            if(countCore>0){
                //format corePercentage/coreCount
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
                //format commercialCount/commercialPercentage
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
            
            // RMoppWrap.oppWraplst = opplst;
            //return Wrapper
            return RMoppWrap;        
        } catch (Exception ex) {
            // Convert the error to Aura Exception.
            
            throw new AuraHandledException(System.Label.TM_StdErrorMessage);
        } 
    }
    
    //Wrapper class have variable which are used in getRMopportunities method returned to lightning component.
    public class  RMOpportunitiesWrapper {
        // @AuraEnabled public string resultSum {get;set;}
        @AuraEnabled public string depositSum {get;set;}
        // @AuraEnabled public string creditsum {get;set;}
        @AuraEnabled public string closedWon {get;set;}
        // treasurySum
        @AuraEnabled public string treasurySum {get;set;}
        @AuraEnabled public integer coreCount {get;set;}
        @AuraEnabled public Decimal percentage {get;set;}
        @AuraEnabled public Decimal corePercentage {get;set;}
        // AnnualGoal
        @AuraEnabled public string AnnualGoal {get;set;}
        // opportunity Wrap list
        @AuraEnabled public Decimal commercialGoal {get;set;}
        @AuraEnabled public Decimal coreTreasuryProdGoal {get;set;}
        @AuraEnabled public Integer commercialCount {get;set;}
        @AuraEnabled public Decimal commercialPercentage {get;set;}
        @AuraEnabled public Integer customerCount {get;set;}
    }
}