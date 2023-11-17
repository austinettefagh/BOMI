({
    doInit : function(component, event, helper) {
        var action = component.get("c.getAccountDetails");
        action.setParams({
            accountId: component.get("v.recordId")
        });
        // Register the callback function
        action.setCallback(this, function(response) {
            component.set("v.accountDetails", response.getReturnValue());
            
        });
        // var curr = component.find("comAmount");
        // curr.set("v.format", '$#,###.## M');
        //var curr = component.find("aum");
        var currLoanOppty = component.find("loanOppty");
        currLoanOppty.set("v.format", '$#,###.## M');
        var currAnnualRevenue = component.find("annualRevenue");
        currAnnualRevenue.set("v.format", '$#,###.## M');
        var currTotalLoans = component.find("totalLoans");
        currTotalLoans.set("v.format", '$#,###.## M');
        var currTotalDeposits = component.find("totalDeposits");
        currTotalDeposits.set("v.format", '$#,###.## M');
        var currTotalTreasury = component.find("totalTreasury");
        currTotalTreasury.set("v.format", '$#,###.## M');
        var currtotalBankDeposits = component.find("totalBankDeposits");
        currtotalBankDeposits.set("v.format", '$#,###.## M');
        // var currTotalCases = component.find("totalCases");
        // currTotalCases.set("v.format", '$#,###.## M');
        // Invoke the service
        $A.enqueueAction(action);
    },
    handleSendReferralClick : function(component, event, helper) { 
        component.find('tm_SendReferralPopup').openModal();   
    },
    spreadsAction : function( component, event, helper) {
        // var actionAPI = component.find("quickActionAPI");
        // var args = {actionName: "Account.StatementLauncher"}
        // actionAPI.invokeAction(args);
        // actionAPI.getCustomAction(args).then(function(customAction) {
        //     if (customAction) {
        //       customAction.subscribe(function(data) {
        //         // Handle quick action message
        //       });
        //       customAction.publish({
        //         message : "Hello Custom Action",
        //         Param1 : "This is a parameter"
        //       });
        //     }
        //   }).catch(function(error) {
        //     // We can't find that custom action.
        //     console.error(error.errors);
        //   });
        // var fields = {Id: {value: component.get("v.recordId")}};
        // var args = {actionName: "Account.nCRED__StatementLauncher", 
        //             entityName : "Account",
        //             targetFields : fields ,
        //             parentID : component.get("v.recordId")};
        // actionAPI.selectAction(args).then(function(result){
        //     actionAPI.invokeAction(args);
        //     console.log('closeHelpTicket action called');
        // }).catch(function(e){
        //     console.error(e.errors);
        // });
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url":"/apex/nCRED__StatementLauncher?Id="+component.get("v.recordId")
        });
        urlEvent.fire();
    },
    reviewAction : function( component, event, helper) {
        // var actionAPI = component.find("quickActionAPI");
        // var fields = {Id: {value: component.get("v.recordId")}};
        // var args = { actionName : "Account.LLC_BI__review", 
        //              entityName : "Account",
        //              targetFields : fields,
        //              parentID : component.get("v.recordId")};
        // actionAPI.selectAction(args).then(function() {
        //     actionAPI.invokeAction(args);
        // }).catch(function(e){
        //     if(e.errors){
        //         console.error('Full error is ', JSON.stringify(e));
        //     }        
        // });
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url":"/apex/LLC_BI__AccountReview?Id="+component.get("v.recordId")
        });
        urlEvent.fire();
    },
    runVerificationAction : function( component, event, helper) {
        // var actionAPI = component.find("quickActionAPI");
        // var fields = {Id: {value: component.get("v.recordId")}};
        // var args = {actionName: "Account.nCRED__Verifications", 
        //             entityName : "Account",targetFields : fields};
        // actionAPI.setActionFieldValues(args).then(function(){
        //     actionAPI.invokeAction(args);
        // }).catch(function(e){
        //     console.error(e.errors);
        // });
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url":"/apex/nFUSE__Verifications?Id="+component.get("v.recordId")
        });
        urlEvent.fire();
    }
    //  ,
    // handleCallReportClick : function(component, event, helper) { 
    //     var urlEvent = $A.get("e.force:navigateToURL"); 
    //     var recordId= component.get("v.recordId");
    //     var name=component.get('v.sObjectName');
    //     // alert(name);
    //     if(name=='Account' || name=='Contact') {            
    //         urlEvent.setParams({
    //             'url':'/apex/OB_FF_CreateActivity_Retail_SF1Action?id='+recordId 
    //         });
    //     }
    //     /*else if(name=='Contact') {
    //         urlEvent.setParams({
    //             'url':'/apex/OB_FF_CreateActivity_Retail_SF1Action?id='+recordId 
    //         });
    //     }*/
    //     urlEvent.fire(); 
    //  } 
})