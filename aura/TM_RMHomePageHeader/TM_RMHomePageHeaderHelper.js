({
    //RMOpportunityData is used to call the getRMopportunities method on controller
    RMOpportunityData : function(component) {
        var action = component.get("c.getRMopportunities");
        
        // action.setParams({
        //     "sorttype":type,
        //     "sortorder":sortorder
        // });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var resp = response.getReturnValue();
                if($A.util.isEmpty(resp.msg)){
                    // if( !$A.util.isEmpty(resp.resultSum)){
                    //     component.set("v.Pipeline",'$ '+resp.resultSum);
                    // }
                    // else{
                    //     component.set("v.Pipeline",'$0');
                    // }
                    if( !$A.util.isEmpty(resp.depositSum)){
                        component.set("v.DepositAmt",'$ '+resp.depositSum);
                    }
                    else{
                        component.set("v.DepositAmt",'$0');
                    }
                    if( !$A.util.isEmpty(resp.treasurySum)){
                        component.set("v.TreasuryAmt",'$ '+resp.treasurySum);
                    }
                    else{
                        component.set("v.TreasuryAmt",'$0');
                    }
                    if( !$A.util.isEmpty(resp.closedWon)){
                        component.set("v.ClosedWonAmt",'$ '+resp.closedWon);
                        component.set("v.Percentage", resp.percentage);
                    }
                    else{
                        component.set("v.ClosedWonAmt",'$0');
                        component.set("v.Percentage", 0);
                    }
                    if( !$A.util.isEmpty(resp.AnnualGoal)){
                        component.set("v.AnnualGoal",'$ '+resp.AnnualGoal);
                    }
                    else{
                        component.set("v.AnnualGoal",'$ 0');
                    }
                    if(resp.coreCount > 0){
                        component.set("v.coreCount", resp.coreCount);
                        component.set("v.corePercentage", resp.corePercentage);
                    }
                    else{
                        component.set("v.coreCount",0);
                        component.set("v.corePercentage", 0);
                    }
                    if(resp.coreTreasuryProdGoal > 0){
                        component.set("v.coreTreasuryProdGoal", resp.coreTreasuryProdGoal);
                    }else{
                        component.set("v.coreTreasuryProdGoal",0);
                    }

                    if(resp.commercialCount > 0){
                        component.set("v.commercialCount", resp.commercialCount);
                    }
                    else{
                        component.set("v.commercialCount",0);
                    }
                    if(resp.commercialPercentage > 0){
                        component.set("v.commercialPercentage", resp.commercialPercentage);
                    }else{
                        component.set("v.commercialPercentage",0);
                    }
                    if(resp.commercialGoal > 0){
                        component.set("v.commercialGoal", resp.commercialGoal);
                    }else{
                        component.set("v.commercialGoal",0);
                    }
                    if(resp.customerCount > 0){
                        component.set("v.customerCount", resp.customerCount);
                    }else{
                        component.set("v.customerCount",0);
                    }
                }
                
            }else{
            	component.set("v.Pipeline",'$0');
                component.set("v.ClosedWonAmt",'$0');
                component.set("v.Percentage", '0');
                component.set("v.AnnualGoal", '$0');
                component.set("v.coreCount", 0);
                component.set("v.TreasuryAmt",'$0');
                component.set("v.DepositAmt",'$0');
                component.set("v.corePercentage", '0');
                component.set("v.customerCount", 0);
            }
        });
        
        $A.enqueueAction(action);
    },
    
    //LoadCarousal is used for swiping functionalitiy on mobile device 
    loadCarousel: function(component){

    }
})