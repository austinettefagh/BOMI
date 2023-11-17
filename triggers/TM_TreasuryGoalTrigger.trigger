/**
 * @description Treasury_Goals__c description
 * @param  insert insert description
 * @param  update update description
 * @return        return description
 */ 
trigger TM_TreasuryGoalTrigger on Treasury_Goals__c (before insert,before update) {
    TM_TreasuryGoalHandler treasuryGoalHandler = new TM_TreasuryGoalHandler();
    if(Trigger.isBefore ) {
        treasuryGoalHandler.beforeUpsertTreasuryGoals(Trigger.New,Trigger.oldMap);
    }
}