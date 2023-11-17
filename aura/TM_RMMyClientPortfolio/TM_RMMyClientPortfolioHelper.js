({
    setTable : function(component, event)
    {
        var actions = [
            { label: 'EDIT', name: 'edit',iconName: 'action:edit', },
            { label: 'TASK', name: 'task',iconName: 'action:new_task'},
            { label: 'EVENT', name: 'event',iconName: 'action:log_event'}
        ]
        component.set('v.columns', [
            {label: 'NAME', fieldName: 'linkName', type: 'url', typeAttributes: {label: { fieldName: 'Name' }, target: '_self', tooltip: { fieldName: 'Name' }}},
            {label: 'STATUS', fieldName: 'FinServ__Status__c', type: 'text', cellAttributes: {class: {fieldName: 'FinServ__Status__c'}}},
			//{label: 'Location', fieldName: 'linkName', type: 'url', typeAttributes: {label: { fieldName: 'OB_Location__c' }, target: '_self'}},
            {label: 'TYPE',fieldName: 'CF_Type__c',type: 'text'},
            {label: 'VALUE', fieldName: 'FinServ__TotalRevenue__c', type: 'currency', typeAttributes: { currencyCode: 'USD', maximumSignificantDigits: 6}, cellAttributes: { alignment: 'left' },},
            //{label: 'LEAD BANK', fieldName: 'Lead_Bank__c', type: 'text'},//removed for preparation of FIRST MIDWEST BANK 
            {label: 'INDUSTRY', fieldName: 'Industry',type: 'text'},
            {label: 'CITY', fieldName: 'BillingCity',type: 'text'},
            {label: 'STATE', fieldName: 'BillingState',type: 'text',sortable: false,cellAttributes: {class: {fieldName: 'BillingState'} }},
            // {label: 'LAST ACTIVITY', fieldName: 'LastActivityDate', type: '',
            //     cellAttributes: { alignment: 'left' },
            //     sortable :true},
            {label: 'ENTITY TYPE', fieldName: 'Type', type: 'text',sortable :false},
            {type: 'action', typeAttributes: { rowActions: actions } },

        ]);
    },
            getFilter: function (component, event, helper)
    {
        var obj = 'Account'; 
        var fieldSetName = 'TM_RM_Accounts';
        // var action = component.get('c.initMethod');
        // action.setParams({  obj : obj  });
        var action = component.get('c.getFilterFields');
        action.setParams({"fieldSetName" : fieldSetName, "obj" : obj});
        
        action.setCallback(this, function(response) {
            //store state of response
            var state = response.getState();
            //var error = response.getError();
            //alert(state);
            
            
            if (state === "SUCCESS") {
                //set response value in wrapperList attribute on component.
                component.set('v.wrapperList', response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
        
    },
	getData : function(component,query,whichOne) 
    {
            var filter=query; 
            var action = component.get("c.getAccounts");
            if(whichOne==="statusButton")
            {
            filter = "FinServ__Status__c = 'Active'";
            }
            else if(whichOne==="valueButton")
            {
            filter = "FinServ__TotalRevenue__c > 50000";
            }
            else if(whichOne==="activityButton")
            {
            filter = "LastActivityDate >= LAST_N_MONTHS:6";
            }
            else if(whichOne==="activityButtonandValueButton")
            {
            filter = "LastActivityDate >= LAST_N_MONTHS:6 AND FinServ__TotalRevenue__c > 50000";
            }
            else if(whichOne==="activityButtonandstatusButton")
            {
            filter = "LastActivityDate >= LAST_N_MONTHS:6 AND FinServ__Status__c = 'Active'";
            }
            else if(whichOne==="valueButtonandstatusButton")
            {
            filter = "FinServ__TotalRevenue__c > 50000 AND FinServ__Status__c = 'Active'";
            }
            else if(whichOne==="ActivityValuestatusButton")
            {
            filter = "LastActivityDate >= LAST_N_MONTHS:6 AND FinServ__TotalRevenue__c > 50000 AND FinServ__Status__c = 'Active'";
            }
            else if(whichOne==="bothsectionfiltersOne")
            {
            filter = "LastActivityDate >= LAST_N_MONTHS:6 AND "+query;
            }
            else if(whichOne==="bothsectionfiltersTwo")
            {
            filter = "FinServ__TotalRevenue__c > 50000 AND "+query;
            }
            else if(whichOne==="bothsectionfiltersThree")
            {
            filter = "FinServ__Status__c = 'Active' AND "+query;
            }
            
            else if(whichOne==="bothsectionfilters12Selected")
            {
            filter = "LastActivityDate >= LAST_N_MONTHS:6 AND FinServ__TotalRevenue__c > 50000 AND "+query;
            }
            else if(whichOne==="bothsectionfilters13Selected")
            {
            filter = "LastActivityDate >= LAST_N_MONTHS:6 AND FinServ__Status__c = 'Active' AND "+query;
            }
            else if(whichOne==="bothsectionfilters23Selected")
            {
            filter = "FinServ__TotalRevenue__c > 50000 AND FinServ__Status__c = 'Active' AND "+query;
            }
            else if(whichOne==="bothsectionfilters123Selected")
            {
            filter = "LastActivityDate >= LAST_N_MONTHS:6 AND FinServ__TotalRevenue__c > 50000 AND FinServ__Status__c = 'Active' AND "+query;
            }
            else if(whichOne==="all")
            {
            filter="all";   
            }
            
            action.setParams({ accFilter:filter});
            action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var records =response.getReturnValue();
                records.forEach(function(record){
                    record.linkName =  '/'+record.Id;
                });
                component.set("v.data",records);
            }
            else if (state === "INCOMPLETE") {
            // do something
            }
            else if (state === "ERROR") {
            var errors = response.getError();
            if (errors) {
            if (errors[0] && errors[0].message) {
            Console.log("Error message: " + 
                        errors[0].message);
        }
    } else {
    Console.log("Unknown error");
}
 }
 });

$A.enqueueAction(action);
	},
        rowActions: function (component, event, helper) 

        {
          var action = event.getParam('action');
          var row = event.getParam('row');
          var accRecId = row.Id;
          
            switch (action.name) 
            {
                case 'edit':
                    
                    var editRecordEvent = $A.get("e.force:editRecord");
            editRecordEvent.setParams({
                "recordId": accRecId
            });
            editRecordEvent.fire();
                   
            break;
                    case 'task':
                     var createTaskRecordEvent = $A.get("e.force:createRecord");
                     createTaskRecordEvent.setParams({
                        "entityApiName": "Task",
                        "defaultFieldValues": {
                            'WhatId' : accRecId
                        }
                    });
                    createTaskRecordEvent.fire();
            
            break;
         case 'event':
            var createEventRecordEvent = $A.get("e.force:createRecord");
                     createEventRecordEvent.setParams({
                        "entityApiName": "Event",
                        "defaultFieldValues": {
                            'WhatId' : accRecId
                        }
                    });
                    createEventRecordEvent.fire();

            break;
         }
       },
            getPicklist: function (component, event, helper,selectedField)

    {           
    
    		var obj='Account';
  			//var field = selectedField;
  			var action = component.get("c.getPickListValues");
            action.setParams({"fieldApiName": selectedField,
                              "obj": obj});
         
            action.setCallback(this, function(response) {
                var state = response.getState();
                
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        Console.log("Error message: " + 
                                 errors[0].message);
                    }
                } 
                
                if (state === "SUCCESS") {
                    
                    var rows = response.getReturnValue();
                    
                    component.set("v.pickListValues", rows);  
                    
                }
                else {
                    Console.log("Failed with state: " + state);
                }
            });
            
            $A.enqueueAction(action);
          
},
})