({
    setTable : function(component, event)
    {
        var actions = [
            { label: 'EDIT', name: 'edit',iconName: 'action:edit', },
            { label: 'TASK', name: 'task',iconName: 'action:new_task'},
            { label: 'EVENT', name: 'event',iconName: 'action:log_event'}
        ]
        
        
        component.set('v.columns', [
            {
                label: 'NAME',
                fieldName: 'linkName', 
                type: 'url', 
                typeAttributes: {label: { fieldName: 'Name' }, target: '_self', tooltip: { fieldName: 'Name' }},
                sortable :true
            },
            {
                label:'STAGE',
                fieldName: 'StageName', 
                type: 'text',
                cellAttributes: {class: {fieldName: 'StageFormat'}},
                sortable :true
            },
            {
                label: 'ACCOUNT', 
                fieldName: 'Accountlink', 
                type: 'url',
                typeAttributes: {label: { fieldName: 'AccountName' }, target: '_self', tooltip: { fieldName: 'AccountName' }},
                cellAttributes: { alignment: 'left' },
                sortable: true
            },
            {
                /**label: 'VALUE', **/
                label: 'AMOUNT',
                fieldName: 'displayAmount', 
                type: 'currency',
                typeAttributes: { currencyCode: 'USD', maximumSignificantDigits: 6},
                cellAttributes: { alignment: 'left' },
                sortable: true
            },
            {
                label: 'RECORD TYPE', 
                fieldName: 'RecordTypeName', 
                type: 'String',
                sortable: true,
                cellAttributes: { alignment: 'left'},
            },
            {
                label: 'CLOSE DATE', 
                fieldName: 'CloseDate', 
                type: 'Date',
                /*cellAttributes: {
            	   class: { fieldName: 'highlight_dra_cell' },alignment: 'left'
        			},*/
                cellAttributes: { alignment: 'left' },
                sortable: true
            },
            {
                label: 'PROBABILITY (%)', 
                fieldName: 'Probability', 
                type: 'Percent',
                cellAttributes: { alignment: 'left' },
                sortable: true
            },
            
            // {
            //     label:'LAST ACTIVITY',
            //     fieldName: 'LastActivityDate', 
            //     type: '',
            //     cellAttributes: { alignment: 'left' },
            //     sortable :true

            // },
            {   
             type: 'action', 
             typeAttributes: { rowActions: actions } 
            } 
        ]);
    },
    
    setData : function(component,query,whichOne) 
    {
        // console.log("whichone "+whichOne);
        // console.log("Query results "+query);
        var filter = query;       
        var action = component.get("c.getOpportunities");
        if(whichOne==="stageButton")
        {
            filter = "StageName = 'Onboarding'";
        }
        else if(whichOne==="activityButton")
        {
            filter = "LastActivityDate >= LAST_N_MONTHS:6";
        }
        else if(whichOne==="valueButton")
        {
           filter = "(TM_Projected_Annual_Treasury_Fee_Income__c > 50000 OR TM_Anticipated_Deposit_Amount__c > 50000)";
        }
        else if(whichOne==="activityButtonandValueButton")
        {
            filter = "LastActivityDate >= LAST_N_MONTHS:6 AND (TM_Projected_Annual_Treasury_Fee_Income__c > 50000 OR TM_Anticipated_Deposit_Amount__c > 50000)"
        }
        else if(whichOne==="activityButtonandstageButton")
        {
            filter = "LastActivityDate >= LAST_N_MONTHS:6 AND StageName = 'Onboarding'";
        }
        else if(whichOne==="valueButtonandstageButton")
        {
            filter = "(TM_Projected_Annual_Treasury_Fee_Income__c > 50000 OR TM_Anticipated_Deposit_Amount__c > 50000) AND StageName = 'Onboarding'";
        }
        else if(whichOne==="ActivityValueStageButton")
        {
            filter = "LastActivityDate >= LAST_N_MONTHS:6 AND (TM_Projected_Annual_Treasury_Fee_Income__c > 50000 OR TM_Anticipated_Deposit_Amount__c > 50000) AND StageName = 'Onboarding'";
        }
        else if(whichOne==="bothsectionfiltersOne")
        {
            filter = "LastActivityDate >= LAST_N_MONTHS:6 AND "+query;
        }
        else if(whichOne==="bothsectionfiltersTwo")
        {
            filter = "(TM_Projected_Annual_Treasury_Fee_Income__c > 50000 OR TM_Anticipated_Deposit_Amount__c > 50000) AND "+query;
        }
        else if(whichOne==="bothsectionfiltersThree")
        {
            filter = "StageName = 'Onboarding' AND "+query;
        }
        else if(whichOne==="bothsectionfilters12Selected")
        {
            filter = "LastActivityDate >= LAST_N_MONTHS:6 AND (TM_Projected_Annual_Treasury_Fee_Income__c > 50000 OR TM_Anticipated_Deposit_Amount__c > 50000) AND "+query;
        }
        else if(whichOne==="bothsectionfilters13Selected")
        {
            filter = "LastActivityDate >= LAST_N_MONTHS:6 AND StageName = 'Onboarding' AND "+query;
        }
        else if(whichOne==="bothsectionfilters23Selected")
        {
            filter = "(TM_Projected_Annual_Treasury_Fee_Income__c > 50000 OR TM_Anticipated_Deposit_Amount__c > 50000) AND StageName = 'Onboarding' AND "+query;
        }
        else if(whichOne==="bothsectionfilters123Selected")
        {
            filter = "LastActivityDate >= LAST_N_MONTHS:6 AND (TM_Projected_Annual_Treasury_Fee_Income__c > 50000 OR TM_Anticipated_Deposit_Amount__c > 50000) AND StageName = 'Onboarding' AND "+query;
        }
        else if(whichOne==="all")
        {
           filter="all";   
        }
        
        action.setParams({ oppFilter:filter});
        
        // action.setParams({ oppFilter : whichOne });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var records =response.getReturnValue();
                records.forEach(function(record){
                    record.linkName =  '/'+record.Id;
                    record.RecordTypeName = record.RecordType.Name;
                    record.StageFormat = record.StageName.replaceAll(' ','').replaceAll('/', '');
                    record.displayAmount = (record.TM_Projected_Annual_Treasury_Fee_Income__c || record.TM_Anticipated_Deposit_Amount__c);
                    //fetch account name from Opportunity
                    var rows =response.getReturnValue();
                    for (var i = 0; i < rows.length; i++) {
                        var row = rows[i];
                        if (row.Account) row.Accountlink = '/'+row.Account.Id;
                        if (row.Account) row.AccountName = row.Account.Name;
                    }
                    /*
            		if(record.StageName === 'Negotiation'){
                		if(!record.ETA__c){
                			record['highlight_dra_cell'] = "highlight_cell";
                		}
            		}*/  
                });
                // console.log("v.data",response.getReturnValue())
                component.set("v.data",response.getReturnValue());
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
                else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            // console.log("Error message: " + 
                                        // errors[0].message);
                        }
                    } 
                    // else {
                    //     // console.log("Unknown error");
                    // }
                }
        });
        
        $A.enqueueAction(action);
        
    },
    
    picklist : function(component, event,helper)
    {
        
        var action = component.get("c.getFields");
        //action.setParams({
        // objectType: component.get("v.sObjectName"),
        // selectedField: component.get("v.fieldName")
        //});
        
        
        action.setCallback(this, function(response) {
            var list = response.getReturnValue();
            component.set("v.picklistValues", list);
        })
        $A.enqueueAction(action);
    },
    
    sortData : function(component,fieldName,sortDirection)
    {
        //to sort the hyperlinks labels
        if ( fieldName === 'linkName' ){
            fieldName = 'Name';
        }
         //to sort the hyperlinks labels
        if(fieldName === 'Accountlink'){
            fieldName = 'AccountName';
        }
        var data = component.get("v.data");
        //function to return the value stored in the field
        var key = function(a) { return a[fieldName]; }
        var reverse = sortDirection == 'asc' ? 1: -1;
        
        var a;
        var b;
        
        // to handle number/currency type fields 
        if(fieldName == 'displayAmount' || fieldName == 'Probability'|| fieldName == 'Metric_C__c' ){ 
            data.sort(function(a,b){
                 var aSortP = key(a) ? key(a) : '';
                 var bSortP = key(b) ? key(b) : '';
                return reverse * ((aSortP>bSortP) - (bSortP>aSortP));
            }); 
        }
        else{// to handle text type fields 
            data.sort(function(a,b){ 
                 var aSort = key(a) ? key(a).toLowerCase() : '';//To handle null values , uppercase records during sorting
                 var bSort = key(b) ? key(b).toLowerCase() : '';
                return reverse * ((aSort>bSort) - (bSort>aSort));
            });    
        }
        //set sorted data to attribute
        component.set("v.data",data);
    },
    getFilter: function (component, event, helper)
    {
        var obj = 'Opportunity'; 
        var fieldSetName = 'TM_RM_Opportunities';
        // var action = component.get('c.initMethod');
        // action.setParams({  obj : obj  });
        var action = component.get('c.getFilterFields');
        action.setParams({"fieldSetName" : fieldSetName, "obj" : obj});
        
        
        action.setCallback(this, function(response) {
            //store state of response
            var state = response.getState();
           
            //alert(state);
            
            
            if (state === "SUCCESS") {
                //set response value in wrapperList attribute on component.
                component.set('v.wrapperList', response.getReturnValue());
            }
            // else
            // {
            //      var error = response.getError();
            //      console.log(error);
            // }
        });
        $A.enqueueAction(action);
        
    },
    
    getPicklist: function (component, event, helper,selectedField)
    {     
        var obj='Opportunity';
        //var field = selectedField;
        var action = component.get("c.getPickListValues");
        action.setParams({"fieldApiName": selectedField,
                          "obj": obj});
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                
                var rows = response.getReturnValue();
                
                component.set("v.pickListValues", rows);  
                
            }
            else {
                // console.log("Failed with state: " + state);
            }
        });
        
        $A.enqueueAction(action);
        
    },
    
    
    rowActions: function (component, event, helper) 
    
    {
        var action = event.getParam('action');
        // console.log('action '+action.name);
        var row = event.getParam('row');
        var accRecId = row.Id;
        // console.log('accRecId '+accRecId);
        
        
        switch (action.name) 
        {
            case 'edit':
                
                var editRecordEvent = $A.get("e.force:editRecord");
                editRecordEvent.setParams({
                    "recordId": accRecId
                });
                 //$A.get("e.force:refreshView").fire();
                //var a = component.get('c.doInit');
                //$A.enqueueAction(a);
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
    
})