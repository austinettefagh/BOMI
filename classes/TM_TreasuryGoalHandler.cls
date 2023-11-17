/**
 * @description  Handler for Treasury Goals trigger
 */ 
public with sharing class TM_TreasuryGoalHandler {
    /**
     * @description beforeUpsertTreasuryGoals description
     * @param  treasuryGoals treasuryGoals description
     */ 
    public void beforeUpsertTreasuryGoals(List<Treasury_Goals__c> treasuryGoals, Map<Id,Treasury_Goals__c> oldMap){
        
        List<Treasury_Goals__c> activedTreasuryGoals = [SELECT Id, TM_Fiscal_Year__c, TM_Treasury_Solutions_Officer__c  FROM Treasury_Goals__c WHERE TM_Active__c = true];
        // if(activedTreasuryGoals.size() <= 0){
        //     return;
        // }
        for (Treasury_Goals__c treasuryGoal : treasuryGoals) {
            if (treasuryGoal.TM_Active__c && (treasuryGoal.Id == null || !oldMap.get(treasuryGoal.Id).TM_Active__c || oldMap.get(treasuryGoal.Id).TM_Treasury_Solutions_Officer__c  != treasuryGoal.TM_Treasury_Solutions_Officer__c ) ) {
                Boolean isHasActivedGoal = checkActivedGoals(treasuryGoal.Id,treasuryGoal.TM_Treasury_Solutions_Officer__c , treasuryGoal.TM_Fiscal_Year__c, activedTreasuryGoals);
                if (isHasActivedGoal) {
                    treasuryGoal.TM_Treasury_Solutions_Officer__c .addError(System.label.TM_Treasury_Goals_ErrorMessage);
                }
            }
        }
    }

    /**
     * @description checkActivedGoals description
     * @param  goalId       goalId description
     * @param  rmId         rmId description
     * @param  year         year description
     * @param  activedGoals activedGoals description
     * @return              return description
     */ 
    public Boolean checkActivedGoals(Id goalId, Id rmId, String year, List<Treasury_Goals__c> activedGoals){
        for (Treasury_Goals__c treasuryGoal : activedGoals) {
            if (goalId == null && treasuryGoal.TM_Treasury_Solutions_Officer__c  == rmId && treasuryGoal.TM_Fiscal_Year__c == year) {
                return true;
            }else if (treasuryGoal.TM_Treasury_Solutions_Officer__c  == rmId && treasuryGoal.TM_Fiscal_Year__c == year && treasuryGoal.Id != goalId) {
                return true;
            }
        }
        return false;
    }
}