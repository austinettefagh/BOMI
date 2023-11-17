({
	init : function(component, event, helper) 
    {  
        var whichOne = 'all';
        var query = 'all';
        helper.setTable(component, event);
        helper.getData(component,query,whichOne);
		helper.getFilter(component, event);
        
        var action = component.get("c.fetchRecordTypeValues");
        action.setParams({
              "sObjectName":'Account'
          });
        action.setCallback(this, function(response) {
            component.set("v.lstOfRecordType", response.getReturnValue());
        });
        $A.enqueueAction(action);
	},
    handleRowAction : function(component, event, helper)
    {
        helper.rowActions(component, event, helper);
    },
    handleChange : function(component, event, helper)
    {
        var wrapperList = component.get("v.wrapperList");
        var selectedField = component.get("v.pickVal1");
        if (selectedField !== 'all') {
            component.set('v.pickVal1Check',false);
        } else {
            component.set('v.pickVal1Check',true);
        }
        var SelectedFieldfromhandleSearch = component.get('v.selectedField1');
        if(selectedField!==SelectedFieldfromhandleSearch && SelectedFieldfromhandleSearch!==''){
            var isActivityClicked = component.get('v.isActivityClicked');
            var isValueClicked = component.get('v.isValueClicked');
            var isStatusClicked = component.get('v.isStatusClicked');
            var whichOne;
            var query="all";
            component.set('v.selectedValue','');
            component.set('v.pickVal2','all');
            component.set('v.queryClicked',false);
            var queryClicked=component.get('v.queryClicked');
            if(queryClicked===false && isActivityClicked===true && isStatusClicked===true && isValueClicked===true) {
                component.set('v.selectedValue','');
                whichOne="ActivityValuestatusButton";
            }
            else if(queryClicked===false && isActivityClicked===true && isValueClicked===false && isStatusClicked===false)
            {
                whichOne="activityButton";
            }
            else if(queryClicked===false && isValueClicked===true && isActivityClicked===false && isStatusClicked===false)
            {
                whichOne="valueButton";
            }
            //start
            else if(isStatusClicked===true && isActivityClicked===false && isValueClicked===false && queryClicked===false)
            {
            whichOne="statusButton";
            }
            else if(isActivityClicked===true && isValueClicked===true && isStatusClicked===false && queryClicked===false)
            {
            whichOne="activityButtonandValueButton";
            }
            else if(isActivityClicked===true && isValueClicked===false && isStatusClicked===true && queryClicked===false)
            {
            whichOne="activityButtonandstatusButton";
        	}
        	else if(isActivityClicked===false && isValueClicked===true && isStatusClicked===true && queryClicked===false)
        	{
            whichOne="valueButtonandstatusButton";
        	}
        }
        helper.getData(component,query,whichOne);
        
        var index =wrapperList.lstLabel.indexOf(selectedField);
        var fieldtype=wrapperList.lstType[index].toLowerCase();
        if(fieldtype==="picklist")
        {
            
            component.set("v.truthy", true);
            var fieldapi=wrapperList.lstApi[index];
            helper.getPicklist(component, event, helper,fieldapi);
        }
        else if(fieldtype==="datetime" || fieldtype==="date")
        {
            component.set("v.truthy", false);
            component.set("v.fieldType","date");
        }
       else 
       {
            component.set("v.truthy", false);
            component.set("v.fieldType","");
       }
        
        
},
    handleSearch : function(component, event, helper)
    {
        console.log('check handleSearch');
        component.set('v.queryClicked', true);
        var whichOne;
        var isActivityClicked = component.get('v.isActivityClicked');
        var isStatusClicked = component.get('v.isStatusClicked');
        var isValueClicked = component.get('v.isValueClicked');
        var queryClicked = component.get('v.queryClicked');
        console.log('test get error 1');
        if(isActivityClicked===false && isStatusClicked===false && isValueClicked===false && queryClicked===true)
        {
            whichOne = "none";
        }
        else if(isActivityClicked===true && isValueClicked===false && isStatusClicked===false && queryClicked===true)
        {
            whichOne="bothsectionfiltersOne";
        }
        else if(isValueClicked===true && isStatusClicked===false && isActivityClicked===false && queryClicked===true)
        {
            whichOne="bothsectionfiltersTwo";
        }
        else if(isStatusClicked===true && isValueClicked===false && isActivityClicked===false && queryClicked===true)
        {
            whichOne="bothsectionfiltersThree";
        }
        else if(isActivityClicked===true && isValueClicked===true && isStatusClicked===false && queryClicked===true)
        {
            whichOne="bothsectionfilters12Selected";
        }
        else if(isActivityClicked===true && isValueClicked===false && isStatusClicked===true && queryClicked===true)
        {
            whichOne="bothsectionfilters13Selected"
        }
        else if(isActivityClicked===false && isValueClicked===true && isStatusClicked===true && queryClicked===true)
        {
            whichOne="bothsectionfilters23Selected";
        }
        else if(isActivityClicked===true && isValueClicked===true && isStatusClicked===true && queryClicked===true)
        {
            whichOne="bothsectionfilters123Selected";
        }
        //console.log("isActivityClicked",isActivityClicked);
        //console.log("isValueClicked",isValueClicked);
        //console.log("isStatusClicked",isStatusClicked);
        //console.log("queryClicked",queryClicked);
        //console.log("handleSearch function " +whichOne);
        //----------------------->
        var selectedField = component.find("select1").get("v.value");
        component.set('v.selectedField1',selectedField);
        //console.log("selectedField in handleSearch "+selectedField);
        //var selectedOperator = component.find("select2").get("v.value");
        var selectedOperator = component.get("v.pickVal2");
        //console.log("selectedOperator please "+selectedOperator);
        
        var wrapperList = component.get("v.wrapperList");
        var index =wrapperList.lstLabel.indexOf(selectedField);
        var fieldapi=wrapperList.lstApi[index];
        var operator;     
        switch (selectedOperator) 
        {
            case 'contains':
                operator = " like";   
                break;
            case 'equals':
                operator = "=";   
                break;
            case 'not equal to':
                operator = "!=";    
                break;
            case 'less than':
                operator = "<";    
                break;
            case 'greater than':
                operator = ">";     
                break;
            case 'less or equal':
                operator = "<=";    
                break;
            case 'greater or equal':
                operator = ">=";     
                break;
        }
        console.log('test get error 2');
        var fieldtype=wrapperList.lstType[index].toLowerCase();
        var selectedValue;
        
        if(fieldtype==="picklist" )
        {
          selectedValue = component.find("mySelect").get("v.value");
        }
        
        else
        {
          selectedValue = component.get("v.selectedValue");  
        }
        
        var query;        
        if(fieldtype==="integer" || fieldtype==="currency" || fieldtype==="boolean" || fieldtype==="datetime" || fieldtype==="date" || fieldtype==="percent" || fieldtype==="double")
        {
         query = fieldapi + operator + selectedValue;   
        }
        else if(selectedOperator === "contains")
        {
            query = fieldapi + operator +"'%"+selectedValue+"%'"; 
        }
        else
        {
         query = fieldapi + operator +"'"+selectedValue+"'";     
        }
        component.set('v.queryFilter',query);
        helper.getData(component,query,whichOne);
                    
    },
    applyFilter : function(component, event, helper)
    {
         var whichOne = event.getSource().getLocalId();
        
        helper.getData(component,query,whichOne);
        
    },
     handleButton1 : function (component, event, helper) {
       var buttonstate = component.get('v.button1State');
        component.set('v.button1State', !buttonstate);
        var isActivityClicked=component.get('v.isActivityClicked');
        if(isActivityClicked===true)
        {
            component.set('v.isActivityClicked',false);
        }
        else
        {
           component.set('v.isActivityClicked',true);
        }
        var a = component.get('c.filterButton');
        $A.enqueueAction(a);
    },
    handleButton2 : function (component, event, helper) {
       var buttonstate = component.get('v.button2State');
        component.set('v.button2State', !buttonstate);
        var isValueClicked = component.get('v.isValueClicked');
        if(isValueClicked===true)
        {
            component.set('v.isValueClicked',false);
        }
        else
        {
            component.set('v.isValueClicked',true);
        }
        var a = component.get('c.filterButton');
        $A.enqueueAction(a);
    },
    handleButton3 : function (component, event, helper) {
       var buttonstate = component.get('v.button3State');
        component.set('v.button3State', !buttonstate);
        var isStatusClicked=component.get('v.isStatusClicked');
        if(isStatusClicked===true)
        {
            component.set('v.isStatusClicked',false);
        }
        else
        {
            component.set('v.isStatusClicked',true);
        }
        var a = component.get('c.filterButton');
        $A.enqueueAction(a);
    },
    //created filterButton method for Enablement multi preset filters
    filterButton : function (component, event, helper) {
        var queryFilter=component.get('v.queryFilter');
        // console.log("queryFilter sagar " +queryFilter);
        var queryClicked=component.get('v.queryClicked');
        // console.log("queryClicked " +queryClicked);
        var whichOne;
        var query = queryFilter;
        var isActivityClicked=component.get('v.isActivityClicked');
        var isValueClicked=component.get('v.isValueClicked');
        var isStatusClicked=component.get('v.isStatusClicked');
        // console.log("isActivityClicked" +isActivityClicked);
        // console.log("isValueClicked" +isValueClicked);
        // console.log("isStatusClicked" +isStatusClicked);
        
        if(isActivityClicked===true && isValueClicked===false && isStatusClicked===false && queryClicked===false)
        {
            //if isActivityClicked selected make button1Variant as brand
            component.set('v.button1Variant','brand');
            whichOne="activityButton";
            // console.log("Button1 selected");
            //if isStatusClicked deselected make button2Variant as neutral 
            component.set('v.button2Variant','neutral');
            component.set('v.button3Variant','neutral');
        }
        else if(isValueClicked===true && isActivityClicked===false && isStatusClicked===false && queryClicked===false)
        {
            //if isValueClicked selected make button2Variant as brand
            component.set('v.button2Variant','brand')
            whichOne="valueButton";
            // console.log("Button2 selected");
            //if isActivityClicked & isStatusClicked deselected make button1Variant and buttonVariant as neutral
            component.set('v.button1Variant','neutral');
            component.set('v.button3Variant','neutral');
        }
         else if(isStatusClicked===true && isActivityClicked===false && isValueClicked===false && queryClicked===false)
        {
            //if isValueClicked selected make button2Variant as brand
            component.set('v.button3Variant','brand')
            whichOne="statusButton";
            //if isActivityClicked & isStatusClicked deselected make button1Variant and button2Variant as neutral
            component.set('v.button1Variant','neutral');
            component.set('v.button2Variant','neutral');
        }
        
        //TTF - 1
        else if(isActivityClicked===true && isValueClicked===true && isStatusClicked===false && queryClicked===false)
        {
            component.set('v.button1Variant','brand');
            component.set('v.button2Variant','brand');
            whichOne="activityButtonandValueButton";
            component.set('v.button3Variant','neutral');
        }
        //TFT - 2
        else if(isActivityClicked===true && isValueClicked===false && isStatusClicked===true && queryClicked===false)
        {
            component.set('v.button1Variant','brand');
            component.set('v.button3Variant','brand');
            whichOne="activityButtonandstatusButton";
            component.set('v.button2Variant','neutral');
        }
        //FTT - 3
        else if(isActivityClicked===false && isValueClicked===true && isStatusClicked===true && queryClicked===false)
        {
            component.set('v.button2Variant','brand');
            component.set('v.button3Variant','brand');
            whichOne="valueButtonandstatusButton";
            component.set('v.button1Variant','neutral');
        }
        //TTT - 4
        else if(isActivityClicked===true && isValueClicked===true && isStatusClicked===true && queryClicked===false)
        {
            component.set('v.button1Variant','brand');
            component.set('v.button2Variant','brand');
            component.set('v.button3Variant','brand');
            whichOne="ActivityValuestatusButton";
        }
        //condition based on if queryClicked===true <---starts here---->
        //It will check only if the both 1st filter section and preset filter section are checked
        
        //query the records only if 1st section filter and lastActivity button are clicked 
        else if(isActivityClicked===true && isValueClicked===false && isStatusClicked===false && queryClicked===true)
        {
            component.set('v.button1Variant','brand');
            whichOne="bothsectionfiltersOne";
            component.set('v.button2Variant','neutral');
            component.set('v.button3Variant','neutral');
        }
        //query the records only if 1st section filter and value button are clicked
        else if(isValueClicked===true && isStatusClicked===false && isActivityClicked===false && queryClicked===true)
        {
            component.set('v.button2Variant','brand');
            whichOne="bothsectionfiltersTwo";
            component.set('v.button1Variant','neutral');
            component.set('v.button3Variant','neutral');
        }
        //query the records only if 1st section filter and Status button are clicked
        else if(isStatusClicked===true && isValueClicked===false && isActivityClicked===false && queryClicked===true)
        {
            component.set('v.button3Variant','brand');
            whichOne="bothsectionfiltersThree";
            component.set('v.button1Variant','neutral');
            component.set('v.button2Variant','neutral');
        }
        //query the records only if 1st section filter and 1 & 2 buttons are clicked - 1
        else if(isActivityClicked===true && isValueClicked===true && isStatusClicked===false && queryClicked===true)
        {
            component.set('v.button1Variant','brand');
            component.set('v.button2Variant','brand');
            whichOne="bothsectionfilters12Selected";
            component.set('v.button3Variant','neutral');
        }
        //query the records only if 1st section filter and 1 & 3 buttons are clicked -2
        else if(isActivityClicked===true && isValueClicked===false && isStatusClicked===true && queryClicked===true)
        {
            component.set('v.button1Variant','brand');
            component.set('v.button3Variant','brand');
            whichOne="bothsectionfilters13Selected";
            component.set('v.button2Variant','neutral');
        }
        //query the records only if 1st section filter and 2 & 3 buttons are clicked -3
        else if(isActivityClicked===false && isValueClicked===true && isStatusClicked===true && queryClicked===true)
        {
            component.set('v.button2Variant','brand');
            component.set('v.button3Variant','brand');
            whichOne="bothsectionfilters23Selected";
            component.set('v.button1Variant','neutral');
        }
        //query the records only if 1st section filter and 123 buttons are clicked -4
        else if(isActivityClicked===true && isValueClicked===true && isStatusClicked===true && queryClicked===true)
        {
            component.set('v.button1Variant','brand');
            component.set('v.button2Variant','brand');
            component.set('v.button3Variant','brand');
            whichOne="bothsectionfilters123Selected";
        }
        else if(isActivityClicked===false && isStatusClicked===false && isValueClicked===false && queryClicked===true)
        {
            component.set('v.button1Variant','neutral');
            component.set('v.button2Variant','neutral');
            component.set('v.button3Variant','neutral');
            whichOne="none";
        }
        //<----Ends here (queryClicked===true)---->
        else if(isActivityClicked===false || isValueClicked===false || isStatusClicked===false && queryClicked===false)
        {
            component.set('v.button1Variant','neutral');
            component.set('v.button2Variant','neutral');
            component.set('v.button3Variant','neutral');
            whichOne="all";
        }
        helper.getData(component,query,whichOne);
    },
   handleReset:function (component, event, helper) {
        component.set('v.reset',false);
        component.set('v.reset',true);
          var queryClicked=component.get('v.queryClicked');
          var isActivityClicked=component.get('v.isActivityClicked');
          var isValueClicked=component.get('v.isValueClicked');
          var isStatusClicked=component.get('v.isStatusClicked');
          var whichOne="all";
          var query="all";
          if(isActivityClicked===true || isValueClicked===true || isStatusClicked===true || queryClicked===true)
        {
            component.set('v.truthy',false);
            component.set('v.pickVal1','all');
            component.set('v.pickVal2','all');
            component.set('v.selectedValue','');
            component.set('v.queryClicked',false);
            component.set('v.button1Variant','neutral');
            component.set('v.button1State',false);
            component.set('v.isActivityClicked',false);
            component.set('v.button2Variant','neutral');
            component.set('v.button2State',false);
            component.set('v.isValueClicked',false);
            component.set('v.button3Variant','neutral');
            component.set('v.button3State',false);
            component.set('v.isStatusClicked',false);
            component.set('v.pickVal1Check',true);
        }
          helper.getData(component,query,whichOne);
      },
    openModal: function(component, event, helper) {
      	// set "isOpen" attribute to true to show model box
      	component.set("v.isOpen", true);
      },
    closeModal: function(component, event, helper) {
      	// set "isOpen" attribute to false for hide/close model box 
      	component.set("v.isOpen", false);
   	  },
    createRecord: function(component, event, helper) {
          component.set("v.isOpen", false);
          
          var action = component.get("c.getRecTypeId");
          var recordTypeLabel = component.find("selectid").get("v.value");
          action.setParams({
              "recordTypeLabel": recordTypeLabel,
              "objName":'Account'
          });
          action.setCallback(this, function(response) {
              var state = response.getState();
              if (state === "SUCCESS") {
                  var createRecordEvent = $A.get("e.force:createRecord");
                  var RecTypeID  = response.getReturnValue();
                  createRecordEvent.setParams({
                      "entityApiName": 'Account',
                      "recordTypeId": RecTypeID
                  });
                  createRecordEvent.fire();
                  
              } else if (state == "INCOMPLETE") {
                  var toastEvent = $A.get("e.force:showToast");
                  toastEvent.setParams({
                      "title": "Oops!",
                      "message": "No Internet Connection"
                  });
                  toastEvent.fire();
                  
              } else if (state == "ERROR") {
                  var toastEventAdmin = $A.get("e.force:showToast");
                  toastEventAdmin.setParams({
                      "title": "Error!",
                      "message": "Please contact your administrator"
                  });
                  toastEventAdmin.fire();
              }
          });
          $A.enqueueAction(action);
      },
})