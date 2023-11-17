({
    doInit: function (component, event, helper) 
    {
        var whichOne = 'all';
        var query = 'all';
        helper.setData(component, event,query, helper,whichOne);
        helper.setTable(component, event, helper);
        helper.getFilter(component, event);
        var action = component.get("c.fetchRecordTypeValues");
        action.setParams({
              "sObjectName":'Opportunity'
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
    handleSort: function(component, event, helper) 
    {
        var sortedBy = event.getParam('fieldName');
        var sortDirection = event.getParam('sortDirection');
        //var sortDirection = component.get('v.sortDirection') == 'asc' ? 'desc' : 'asc';  
        //console.log('sortDirection '+sortDirection);
        component.set('v.sortDirection', sortDirection);
        component.set('v.sortBy', sortedBy);
            
        helper.sortData(component, sortedBy,sortDirection);
    },
    handleChange : function(component, event, helper)
    {
        var wrapperList = component.get("v.wrapperList");
        var selectedField = component.get("v.pickVal1");
        //console.log('--selectedField---'+selectedField);
        var SelectedFieldfromhandleSearch = component.get('v.selectedField1');
        //console.log("SelectedFieldfromhandleSearch "+SelectedFieldfromhandleSearch);
        
        if(selectedField!==SelectedFieldfromhandleSearch && SelectedFieldfromhandleSearch!==''){
            var isActivityClicked = component.get('v.isActivityClicked');
            var isValueClicked = component.get('v.isValueClicked');
            var isStageClicked = component.get('v.isStageClicked');
            var whichOne;
            var query="all";
            component.set('v.selectedValue','');
            component.set('v.pickVal2','all');
            component.set('v.queryClicked',false);
            var queryClicked=component.get('v.queryClicked');
            if(queryClicked===false && isActivityClicked===true && isStageClicked===true && isValueClicked===true) {
                component.set('v.selectedValue','');
                whichOne="ActivityValueStageButton";
                //console.log("ActivityValueStageButton is true");
            }
            else if(queryClicked===false && isActivityClicked===true && isValueClicked===false && isStageClicked===false)
            {
                whichOne="activityButton";
            }
            else if(queryClicked===false && isValueClicked===true && isActivityClicked===false && isStageClicked===false)
            {
                whichOne="valueButton";
            }
            //start
            else if(isStageClicked===true && isActivityClicked===false && isValueClicked===false && queryClicked===false)
            {
            whichOne="stageButton";
            }
            else if(isActivityClicked===true && isValueClicked===true && isStageClicked===false && queryClicked===false)
            {
            whichOne="activityButtonandValueButton";
            }
            else if(isActivityClicked===true && isValueClicked===false && isStageClicked===true && queryClicked===false)
            {
            whichOne="activityButtonandstageButton";
        	}
        	else if(isActivityClicked===false && isValueClicked===true && isStageClicked===true && queryClicked===false)
        	{
            whichOne="valueButtonandstageButton";
        	}
        }
        helper.setData(component,query,whichOne);
        
        var index =wrapperList.lstLabel.indexOf(selectedField);
        // console.log('--index1---'+index);
        
        var fieldtype=wrapperList.lstType[index].toLowerCase();
        //console.log('--fieldtype---'+fieldtype);
        //var fieldtype=wrapperList.lstApi[index];
        if(fieldtype==="picklist")
        {
            var fieldapi=wrapperList.lstApi[index];
            component.set("v.truthy", true);
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
        component.set('v.queryClicked', true);
        var whichOne;
        var isActivityClicked = component.get('v.isActivityClicked');
        var isStageClicked = component.get('v.isStageClicked');
        var isValueClicked = component.get('v.isValueClicked');
        var queryClicked = component.get('v.queryClicked');
        if(isActivityClicked===false && isStageClicked===false && isValueClicked===false && queryClicked===true)
        {
            whichOne = "none";
        }
        else if(isActivityClicked===true && isValueClicked===false && isStageClicked===false && queryClicked===true)
        {
            whichOne="bothsectionfiltersOne";
        }
        else if(isValueClicked===true && isStageClicked===false && isActivityClicked===false && queryClicked===true)
        {
            whichOne="bothsectionfiltersTwo";
        }
        else if(isStageClicked===true && isValueClicked===false && isActivityClicked===false && queryClicked===true)
        {
            whichOne="bothsectionfiltersThree";
        }
        else if(isActivityClicked===true && isValueClicked===true && isStageClicked===false && queryClicked===true)
        {
            whichOne="bothsectionfilters12Selected";
        }
        else if(isActivityClicked===true && isValueClicked===false && isStageClicked===true && queryClicked===true)
        {
            whichOne="bothsectionfilters13Selected"
        }
        else if(isActivityClicked===false && isValueClicked===true && isStageClicked===true && queryClicked===true)
        {
            whichOne="bothsectionfilters23Selected";
        }
        else if(isActivityClicked===true && isValueClicked===true && isStageClicked===true && queryClicked===true)
        {
            whichOne="bothsectionfilters123Selected";
        }
        //console.log("isActivityClicked",isActivityClicked);
        //console.log("isValueClicked",isValueClicked);
        //console.log("isStageClicked",isStageClicked);
        //console.log("queryClicked",queryClicked);
        //console.log("handleSearch function " +whichOne);
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
        
        var fieldtype=wrapperList.lstType[index].toLowerCase();
        //console.log("fieldtype "+fieldtype);
        var selectedValue;
        
        if(fieldtype==="picklist" )
        {
          selectedValue = component.find("mySelect").get("v.value");
        }
        
        else
        {
          selectedValue = component.get("v.selectedValue");  
        }
        //console.log(selectedValue);
        
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
        //console.log("Query "+query);
        component.set('v.queryFilter',query);
        helper.setData(component,query,whichOne);
                    
    },
    applyFilter : function (component, event, helper) 
    {
        var whichOne = event.getSource().getLocalId();
        
        helper.setData(component, event, helper,whichOne);
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
        //console.log("handleButton1");
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
        //console.log("handleButton2");
    },
    handleButton3 : function (component, event, helper) {
        var buttonstate = component.get('v.button3State');
        component.set('v.button3State', !buttonstate);
        var isStageClicked=component.get('v.isStageClicked');
        if(isStageClicked===true)
        {
            component.set('v.isStageClicked',false);
        }
        else
        {
            component.set('v.isStageClicked',true);
        }
        var a = component.get('c.filterButton');
        $A.enqueueAction(a);
        //console.log("handleButton3");
    },
    //Sagar created filterButton method for Enablement multi preset filters
    filterButton : function (component, event, helper) {
        var queryFilter=component.get('v.queryFilter');
        //console.log("queryFilter sagar " +queryFilter);
        var queryClicked=component.get('v.queryClicked');
        //console.log("queryClicked " +queryClicked);
        var whichOne;
        var query = queryFilter;
        var isActivityClicked=component.get('v.isActivityClicked');
        var isValueClicked=component.get('v.isValueClicked');
        var isStageClicked=component.get('v.isStageClicked');
        //console.log("isActivityClicked" +isActivityClicked);
        //console.log("isValueClicked" +isValueClicked);
        //console.log("isStageClicked" +isStageClicked);
        
        if(isActivityClicked===true && isValueClicked===false && isStageClicked===false && queryClicked===false)
        {
            //if isActivityClicked selected make button1Variant as brand
            component.set('v.button1Variant','brand');
            whichOne="activityButton";
            //console.log("Button1 selected");
            //if isStageClicked deselected make button2Variant as neutral 
            component.set('v.button2Variant','neutral');
            component.set('v.button3Variant','neutral');
        }
        else if(isValueClicked===true && isActivityClicked===false && isStageClicked===false && queryClicked===false)
        {
            //if isValueClicked selected make button2Variant as brand
            component.set('v.button2Variant','brand')
            whichOne="valueButton";
            //console.log("Button2 selected");
            //if isActivityClicked & isStageClicked deselected make button1Variant and buttonVariant as neutral
            component.set('v.button1Variant','neutral');
            component.set('v.button3Variant','neutral');
        }
         else if(isStageClicked===true && isActivityClicked===false && isValueClicked===false && queryClicked===false)
        {
            //if isValueClicked selected make button2Variant as brand
            component.set('v.button3Variant','brand')
            whichOne="stageButton";
            //console.log("Button3 selected");
            //if isActivityClicked & isStageClicked deselected make button1Variant and button2Variant as neutral
            component.set('v.button1Variant','neutral');
            component.set('v.button2Variant','neutral');
        }
        //TTF - 1
        else if(isActivityClicked===true && isValueClicked===true && isStageClicked===false && queryClicked===false)
        {
            component.set('v.button1Variant','brand');
            component.set('v.button2Variant','brand');
            whichOne="activityButtonandValueButton";
            //console.log("button1 and 2 selected 3 deselected");
            component.set('v.button3Variant','neutral');
        }
        //TFT - 2
        else if(isActivityClicked===true && isValueClicked===false && isStageClicked===true && queryClicked===false)
        {
            component.set('v.button1Variant','brand');
            component.set('v.button3Variant','brand');
            whichOne="activityButtonandstageButton";
            //console.log("button1 and 3 selected 2 deselected");
            component.set('v.button2Variant','neutral');
        }
        //FTT - 3
        else if(isActivityClicked===false && isValueClicked===true && isStageClicked===true && queryClicked===false)
        {
            component.set('v.button2Variant','brand');
            component.set('v.button3Variant','brand');
            whichOne="valueButtonandstageButton";
            //console.log("button2 and 3 selected 1 deselected");
            component.set('v.button1Variant','neutral');
        }
        //TTT - 4
        else if(isActivityClicked===true && isValueClicked===true && isStageClicked===true && queryClicked===false)
        {
            component.set('v.button1Variant','brand');
            component.set('v.button2Variant','brand');
            component.set('v.button3Variant','brand');
            whichOne="ActivityValueStageButton";
            //console.log("button1 and 2 and 3 selected");
        }
        //condition based on if queryClicked===true <---starts here---->
        //It will check only if the both 1st filter section and preset filter section are checked
        
        //query the records only if 1st section filter and lastActivity button are clicked 
        else if(isActivityClicked===true && isValueClicked===false && isStageClicked===false && queryClicked===true)
        {
            component.set('v.button1Variant','brand');
            whichOne="bothsectionfiltersOne";
            //console.log("queryClicked1 finally");
            component.set('v.button2Variant','neutral');
            component.set('v.button3Variant','neutral');
        }
        //query the records only if 1st section filter and value button are clicked
        else if(isValueClicked===true && isStageClicked===false && isActivityClicked===false && queryClicked===true)
        {
            component.set('v.button2Variant','brand');
            whichOne="bothsectionfiltersTwo";
            //console.log("queryClicked2 finally");
            component.set('v.button1Variant','neutral');
            component.set('v.button3Variant','neutral');
        }
        //query the records only if 1st section filter and Stage button are clicked
        else if(isStageClicked===true && isValueClicked===false && isActivityClicked===false && queryClicked===true)
        {
            component.set('v.button3Variant','brand');
            whichOne="bothsectionfiltersThree";
            //console.log("queryClicked3 finally");
            component.set('v.button1Variant','neutral');
            component.set('v.button2Variant','neutral');
        }
        //query the records only if 1st section filter and 1 & 2 buttons are clicked - 1
        else if(isActivityClicked===true && isValueClicked===true && isStageClicked===false && queryClicked===true)
        {
            component.set('v.button1Variant','brand');
            component.set('v.button2Variant','brand');
            whichOne="bothsectionfilters12Selected";
            //console.log("queryClicked 1&2 finally");
            component.set('v.button3Variant','neutral');
        }
        //query the records only if 1st section filter and 1 & 3 buttons are clicked -2
        else if(isActivityClicked===true && isValueClicked===false && isStageClicked===true && queryClicked===true)
        {
            component.set('v.button1Variant','brand');
            component.set('v.button3Variant','brand');
            whichOne="bothsectionfilters13Selected";
            //console.log("queryClicked 1&3 finally");
            component.set('v.button2Variant','neutral');
        }
        //query the records only if 1st section filter and 2 & 3 buttons are clicked -3
        else if(isActivityClicked===false && isValueClicked===true && isStageClicked===true && queryClicked===true)
        {
            component.set('v.button2Variant','brand');
            component.set('v.button3Variant','brand');
            whichOne="bothsectionfilters23Selected";
            //console.log("queryClicked 2&3 finally");
            component.set('v.button1Variant','neutral');
        }
        //query the records only if 1st section filter and 123 buttons are clicked -4
        else if(isActivityClicked===true && isValueClicked===true && isStageClicked===true && queryClicked===true)
        {
            component.set('v.button1Variant','brand');
            component.set('v.button2Variant','brand');
            component.set('v.button3Variant','brand');
            whichOne="bothsectionfilters123Selected";
            //console.log("queryClicked 123 finally");
        }
        else if(isActivityClicked===false && isStageClicked===false && isValueClicked===false && queryClicked===true)
        {
            component.set('v.button1Variant','neutral');
            component.set('v.button2Variant','neutral');
            component.set('v.button3Variant','neutral');
            whichOne="none";
            //console.log("remove button and selected");
        }
        //<----Ends here (queryClicked===true)---->
        else if(isActivityClicked===false || isValueClicked===false || isStageClicked===false && queryClicked===false)
        {
            component.set('v.button1Variant','neutral');
            component.set('v.button2Variant','neutral');
            component.set('v.button3Variant','neutral');
            whichOne="all";
            //console.log("remove button");
        }
        helper.setData(component,query,whichOne) ;
    },
      handleReset:function (component, event, helper) {
          var queryClicked=component.get('v.queryClicked');
          var isActivityClicked=component.get('v.isActivityClicked');
          var isValueClicked=component.get('v.isValueClicked');
          var isStageClicked=component.get('v.isStageClicked');
          var whichOne="all";
          var query="all";
          if(isActivityClicked===true || isValueClicked===true || isStageClicked===true || queryClicked===true)
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
            component.set('v.isStageClicked',false);
          }
          helper.setData(component,query,whichOne);
      },
          handleTableRefresh:function (component, event, helper) {
          var whichOne = 'all';
          var query = 'all';
         //component.set('v.truthy',false);
        // component.set('v.pickVal1','all');
         // component.set('v.pickVal2','all');
         // component.set('v.selectedValue','');
         // component.set('v.button1Variant','neutral');
        //  component.set('v.button2Variant','neutral');
        //  component.set('v.button3Variant','neutral');
        //  component.set('v.button1State',false);
        //  component.set('v.button2State',false);
         // component.set('v.button3State',false);
          helper.setData(component,query,whichOne);
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
              "objName":'Opportunity'
          });
          action.setCallback(this, function(response) {
              var state = response.getState();
              if (state === "SUCCESS") {
                  var createRecordEvent = $A.get("e.force:createRecord");
                  var RecTypeID  = response.getReturnValue();
                  //console.log('RecTypeID',RecTypeID);
                  createRecordEvent.setParams({
                      "entityApiName": 'Opportunity',
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
      /*createRecord : function (component, event, helper) {
      
        //Default behaviour for crearting new record        
         var createRecordEvent = $A.get("e.force:createRecord");
        createRecordEvent.setParams({
            "entityApiName": "Opportunity"          						
        });
        createRecordEvent.fire();
      }*/
    
})