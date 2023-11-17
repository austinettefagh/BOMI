/*********************************************************************************************************
*@author    : PwC Team
*@date      : December 24th 2020
* @description : This class used in lightning component - 
*@Modification Log   :
Change History Story              Modify by               Date                          Desc
                                    Grace                 August 6 2021                 modified fetchRecordTypeValues method to fetch only active recordtypes
                                    Grace                 August 6 2021                 modified getRecTypeId method - added objname parameter
                                    Sagar                 October 24 2021               modified initMethod method
**********************************************************************************************************/
public class TM_RMDesktopController { 
    //declare public variables 
    public static Map<Id, String> recordtypemap {get;set;}
    public static String strAll = 'all';
    public static String strLimit = ' LIMIT 100';
    public static String strClosedWon = 'Implementation';
    public static String strAnd = ' AND ';

    // Returns a List of the Names of all RecordTypes
    // available to the running user for a given SOBject type
    public static List<String> getAvailableRecordTypeNamesForSObject(
        Schema.SObjectType objType
    ) {
        List<String> names = new List<String>();
        List<RecordTypeInfo> infos = objType.getDescribe().getRecordTypeInfos();
        // If there are 2 or more RecordTypes...
        if (infos.size() > 1) {
            for (RecordTypeInfo info : infos) {
                if (info.isAvailable() && !info.isMaster() && info.isActive() && info.getName() != 'Loan'){
                    names.add(info.getName());
                }
            }
        } 
            // Otherwise there's just the Master record type,
            // so add it in, since it MUST always be available
        else{
            names.add(infos[0].getName());
        }
        for(Integer num = names.size() -1; num >= 0 ; num--) {
            if (names[num] == 'Track Treasury Products Sold') {
                string swap = names[0];
                names[0] = names[num];
                names[num] = swap;
            }
        }
        return names;
}
    
    /**
     * @description fetchRecordTypeValues description
     * @param  sObjectName sObjectName description
     * @return             return description
     */
    @AuraEnabled        
    public static List<String> fetchRecordTypeValues(String sObjectName){
        Map<String, Schema.SObjectType> globalDescribeMap = Schema.getGlobalDescribe();
        // Schema.DescribeSObjectResult sobj = globalDescribeMap.get(sObjectName).getDescribe();
        try{
            List<String> availableTypes = getAvailableRecordTypeNamesForSObject(globalDescribeMap.get(sObjectName));
            //List<Schema.RecordTypeInfo> recordtypes = sobj.SObjectType.getDescribe().getRecordTypeInfos(); 
            //system.debug('recordtypes'+ recordtypes);
            // recordtypemap = new Map<Id, String>();
            // for(RecordTypeInfo rt : recordtypes){
            //     if(rt.getName() != 'Master' && rt.active){
            //         recordtypemap.put(rt.getRecordTypeId(), rt.getName());
            //     }
            // }        
            return availableTypes;
        } catch (Exception ex) {
            // Convert the error to Aura Exception.            
            throw new AuraHandledException(System.Label.TM_StdErrorMessage);
        } 
    }
    
    /**
     * @description getRecTypeId description
     * @param  recordTypeLabel recordTypeLabel description
     * @param  objName         objName description
     * @return                 return description
     */ 
    @AuraEnabled
    public static Id getRecTypeId(String recordTypeLabel,String objName){
        try{
            /*Id recid = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(recordTypeLabel).getRecordTypeId();        
                return recid;*/
            List<RecordTypeInfo> infos = ((SObject)Type.forName('Schema', objName).newInstance()).getSObjectType().getDescribe().getRecordTypeInfos();
            if (infos.size() > 1) {
                for (RecordTypeInfo info : infos) {
                    if (info.getName() == recordTypeLabel && info.isAvailable() && !info.isMaster() && info.isActive()){
                        return info.getRecordTypeId();
                    }
                }
            }
            return infos[0].getRecordTypeId();
            /*return ((SObject)Type.forName('Schema', objName)
                    .newInstance()
                   )
                .getSObjectType()
                .getDescribe()
                .getRecordTypeInfosByName()
                .get(recordTypeLabel)
                .getRecordTypeId();*/
        } catch (Exception ex) {
            // Convert the error to Aura Exception.            
            throw new AuraHandledException(System.Label.TM_StdErrorMessage);
        } 
    }   
    
    /**
     * @description getOpportunities description
     * @param  oppFilter oppFilter description
     * @return           return description
     */ 
    @AuraEnabled 
    public static List<Opportunity> getOpportunities(String oppFilter){
        try{
            //declare variables
            List<Opportunity> OpportunityList = new List<Opportunity>();
            String roleId;
            User currentUser=[SELECT Id FROM User WHERE Id = :Userinfo.getUserId()];
            if(currentUser.Id!=null){
                roleId =currentUser.Id;
            }
            String query='';
            if(oppFilter==strAll){
                query='SELECT Id,Name,StageName,Amount,CloseDate,Probability,RecordType.Name,AccountId, TM_Projected_Annual_Treasury_Fee_Income__c,TM_Anticipated_Deposit_Amount__c,Account.Name FROM Opportunity WHERE OwnerId = :roleId AND RecordType.Name IN (\'Track Deposit Pipeline\',\'Track Treasury Products Sold\') LIMIT 100'; 
            }else {
                // String oppFilterStr = String.escapeSingleQuotes(oppFilter);
                query='SELECT Id,Name,StageName,Amount,CloseDate,Probability,RecordType.Name,AccountId, TM_Projected_Annual_Treasury_Fee_Income__c,TM_Anticipated_Deposit_Amount__c,Account.Name FROM Opportunity WHERE OwnerId = :roleId AND RecordType.Name IN (\'Track Deposit Pipeline\',\'Track Treasury Products Sold\') AND ' + oppFilter + strLimit ; 
            }
            // System.debug('oppFilter--'+oppFilter);  
            // System.debug('oppty query--'+query);
            if(query.length() > 0){
                OpportunityList = Database.query(query);
            }            
            //List<Opportunity> OpportunityList = Database.query(query);
            //Id oppId = OpportunityList[0].Id;
            //System.debug(oppId);
            return OpportunityList;
            
        } catch (Exception ex) {
            // Convert the error to Aura Exception.            
            throw new AuraHandledException(System.Label.TM_StdErrorMessage);
        }        
    }

    /**
     * @description getAccounts description
     * @param  accFilter accFilter description
     * @return           return description
     */ 
    @AuraEnabled
    public static List<Account> getAccounts(String accFilter) {
        try{
            //declare variables
            List<Account> AccountList = new List<Account>();
            String roleId;
            User currentUser=[SELECT Id FROM User WHERE Id = :Userinfo.getUserId()];
            if(currentUser.Id!=null){
                roleId =currentUser.Id;
            }
            String query='';
            //String noInactiveAccounts = ' Active__c =:yes  ';
            // String recordTypeName = 'Business'; 
            //Schema.SObjectType.Account.getRecordTypeInfosById().get('0124T000000PaQgQAK').getName();//business
            if(accFilter==strAll)       {
                query='SELECT Id,Name,FinServ__Status__c,Type,FinServ__TotalRevenue__c,CF_Type__c,Industry,BillingCity,BillingState,RecordType.Name FROM Account WHERE OwnerId = :roleId LIMIT 100';
               // system.debug('query :: '+query);
            } else {
                // String accFilterStr = '\'' + String.escapeSingleQuotes(accFilter) + '\'';
                query='SELECT Id,Name,FinServ__Status__c,Type,FinServ__TotalRevenue__c,CF_Type__c,Industry,BillingCity,BillingState FROM Account WHERE OwnerId = :roleId '+ strAnd + accFilter +strLimit;    
            } 
            // System.debug('acc accFilter--'+accFilter);   
            // System.debug('acc query--'+query);
            //fire query
            if(query.length() > 0){
                AccountList = Database.query(query);
            }        
            return AccountList; 
        } catch (Exception ex) {
            // Convert the error to Aura Exception.            
            throw new AuraHandledException(System.Label.TM_StdErrorMessage);
        }        
    }
    
    /**
     * @description initMethod description
     * @param  obj obj description
     * @return     return description
     */ 
    @AuraEnabled
    public static wrapperClass initMethod(String obj)    {
        try{
            wrapperClass returnwrapperClass = new  wrapperClass ();
            //declare variables            
            String type=obj;
            //String fieldType = 
            List<String> fieldApi = new List<String>();
            List<String> fieldLabel = new List<String>();
            List<String> fieldType = new List<String>();
            
            //EntityParticle-> gives the list of all the fields label,api
            //declare variable
            List<EntityParticle > lstEP = new List<EntityParticle >();
            //fetch the field name, api and label
            lstEP = [SELECT DataType, QualifiedApiName,Label FROM EntityParticle
                     WHERE  EntityDefinition.QualifiedApiName =:type Order by Label ASC];
            for(EntityParticle objEP:lstEP){
                fieldApi.add(objEP.QualifiedApiName);
                //System.debug('Field Api :: '+fieldApi);
                fieldLabel.add(objEP.Label);
                //System.debug('Field label :: '+fieldLabel);
                fieldType.add(objEP.DataType);
                //System.debug('Field Type :: '+fieldType);
            }
            //returnwrapperClass data
            returnwrapperClass.lstLabel = fieldLabel;
            returnwrapperClass.lstType = fieldType;
            returnwrapperClass.lstApi = fieldApi;
            return returnwrapperClass;  
        } catch (Exception ex) {
            // Convert the error to Aura Exception.            
            throw new AuraHandledException(System.Label.TM_StdErrorMessage);
        }
    }

    /**
     * @description getFilterFields description
     * @param  fieldSetName fieldSetName description
     * @param  obj          obj description
     * @return              return description
     */ 
    @AuraEnabled
    public static wrapperClass getFilterFields(String fieldSetName,String obj){
        try {
            wrapperClass returnwrapperClass = new  wrapperClass ();
            List<String> fieldApi = new List<String>();
            List<String> fieldLabel = new List<String>();
            List<String> fieldType = new List<String>();
            List<Schema.FieldSetMember> fieldSetMemberList =  TM_Utility.readFieldSet(fieldSetName,obj);
            for(Schema.FieldSetMember fieldSetMemberObj : fieldSetMemberList){
                fieldApi.add(fieldSetMemberObj.getFieldPath()); //api name
                fieldLabel.add(fieldSetMemberObj.getLabel());
                fieldType.add(String.valueOf(fieldSetMemberObj.getType()));   //type - STRING,PICKLIST
            }
            returnwrapperClass.lstLabel = fieldLabel;
            returnwrapperClass.lstType = fieldType;
            returnwrapperClass.lstApi = fieldApi;
            return returnwrapperClass;
        } catch (Exception ex) {
            // Convert the error to Aura Exception.            
            throw new AuraHandledException(System.Label.TM_StdErrorMessage);
        }
    }
    
    /**
     * @description getPickListValues description
     * @param  fieldApiName fieldApiName description
     * @param  obj          obj description
     * @return              return description
     */ 
    @AuraEnabled
    public static List<String> getPickListValues(String fieldApiName,String obj) {
        try{
            //Schema.DisplayType getfieldType=getType(stage);
            String type=obj;
            //String fieldLabel;
            //Schema.DisplayType pick=getType('Status');
            
            //get a map with describe information about every single object
            List<String> pickListValuesList = new List<String>();
            // String apiName = fieldMapping.get(stage);
            
            Schema.SObjectType objSchema = Schema.getGlobalDescribe().get(type) ;
            Schema.DescribeSObjectResult objResultSchema  = objSchema.getDescribe() ;
            Map<String,Schema.SObjectField> fields = objResultSchema.fields.getMap() ;
            Schema.DescribeFieldResult fieldResult = fields.get(fieldApiName).getDescribe();
            List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            for( Schema.PicklistEntry pickListVal : ple)        {
                pickListValuesList.add(pickListVal.getLabel());
                //pickListValuesList.sort();
            }        
            return pickListValuesList;
        } catch (Exception ex) {
            // Convert the error to Aura Exception.            
            throw new AuraHandledException(System.Label.TM_StdErrorMessage);
        }   
    }

    /**
     * wrapper or Inner class with @AuraEnabled {get;set;} properties*
     */
    public class wrapperClass{   
     @AuraEnabled public List<String> lstLabel{get;set;}
     @AuraEnabled public List<String> lstType{get;set;}
     @AuraEnabled public List<String> lstApi{get;set;}
     //@AuraEnabled public Map<String,List<String>> fieldValues{get;set;}
     //@AuraEnabled public List<Schema.DisplayType> lstType{get;set;}
    }
   
}