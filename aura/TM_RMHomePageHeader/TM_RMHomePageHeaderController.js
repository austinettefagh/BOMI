({
    //Init Method to call RMOpportunityData to fetch OutstandingBlanace,Credit Balance and Deposit balance from the controller
    doInit : function(component, event, helper) {
        helper.RMOpportunityData(component);
    },
    //ScriptsLoaded method is used to load third part Js for swipe on mobile device
    ScriptsLoaded : function(component, event, helper) {
        //helper.loadCarousel(component);
       
     }
})