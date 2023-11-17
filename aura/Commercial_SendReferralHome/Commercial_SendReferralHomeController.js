({
	doInit : function(component, event, helper) {  
        //console.log("Parent aura component method invoked do init");  
        //console.log('---'+JSON.stringify(component.find('lwc_SendReferralPopup')));
        component.set("v.recordId", null);
        //component.find('lwc_SendReferralPopup').openModal(); 
    },
})