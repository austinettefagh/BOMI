/**
 * @description TM_RefreshTreasuryGoal description
 */ 
public with sharing class TM_RefreshTreasuryGoal {

    /**
     * @description refreshGoal description
     * @param  recordId recordId description
     */ 
    @AuraEnabled()
    public static void refreshGoal(String recordId){
        try {
            if (String.isBlank(recordId)) {
                return;
            }
            Treasury_Goals__c treasuryGoals = [SELECT Id, TM_Treasury_Solutions_Officer__c, TM_New_Money_Till_Date__c, TM_New_Commercial_Relationships_Till__c, TM_New_Core_Treasury_Products_Sold_Till__c FROM Treasury_Goals__c WHERE Id = :recordId];
            if (treasuryGoals == null) {
                return;
            }
            //get New Commercial Relationships Till Date
            AggregateResult[] countAccHasCIFResults = [SELECT COUNT(Id)countAccHasCIF from Account WHERE OwnerId =:treasuryGoals.TM_Treasury_Solutions_Officer__c AND CIF__c <> null];
    
            //get New Core Treasury Products Sold Till D
            AggregateResult[] countTreasuryProductsOppResults = [SELECT COUNT(Id)coreCount from OpportunityLineItem WHERE Opportunity.OwnerId =:treasuryGoals.TM_Treasury_Solutions_Officer__c AND TM_Core_Treasury_Product__c  = 'Y' AND (Opportunity.RecordType.Name = 'Track Treasury Products Sold')];
    
            //get New Money Till Date
            AggregateResult[] groupedOppResults = [SELECT SUM(TM_New_Money__c)sumA FROM Opportunity WHERE OwnerId =:treasuryGoals.TM_Treasury_Solutions_Officer__c AND CloseDate =THIS_FISCAL_YEAR AND RecordType.Name = 'Track Deposit Pipeline'];
    
            // update New Commercial Relationships Till Date
            if (countAccHasCIFResults.size() > 0) {
                treasuryGoals.TM_New_Commercial_Relationships_Till__c = (Integer)countAccHasCIFResults[0].get('countAccHasCIF');
            }
    
            // update Core Treasury Products Sold Till D
            if (countTreasuryProductsOppResults.size() > 0) {
                treasuryGoals.TM_New_Core_Treasury_Products_Sold_Till__c = (Integer)countTreasuryProductsOppResults[0].get('coreCount');
            }
    
            // update New Money Till Date
            if (groupedOppResults.size() > 0) {
    
                treasuryGoals.TM_New_Money_Till_Date__c = groupedOppResults[0].get('sumA') != null ? (Decimal)groupedOppResults[0].get('sumA') : 0;
            }
            // Update Record
            update treasuryGoals;
        } catch (Exception ex) {
            throw new AuraHandledException(System.Label.TM_StdErrorMessage); 
        }
        
    }
}