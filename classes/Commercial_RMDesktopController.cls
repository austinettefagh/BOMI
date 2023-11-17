/*********************************************************************************************************
*@author    : PwC Team
*@date      : December 24th 2020
*@description : This class used in lightning component - 
*@Modification Log   :
Change History Story              Modify by               Date                          Desc
                                    Grace                 August 6 2021                 modified fetchRecordTypeValues method to fetch only active recordtypes
                                    Grace                 August 6 2021                 modified getRecTypeId method - added objname parameter
                                    Sagar                 October 24 2021               modified initMethod method
**********************************************************************************************************/
public class Commercial_RMDesktopController { 
    //declare public variables 
    public static Map<Id, String> recordtypemap {get;set;}
    public static String strAll = 'all';
    public static String strLimit = ' LIMIT 100';
    public static String strClosedWon = 'Implementation';
    public static String strAnd = ' AND ';

    // Returns a List of the Names of all RecordTypes
    // available to the running user for a given SOBject type
    public static List<String> GetAvailableRecordTypeNamesForSObject(
        Schema.SObjectType objType
    ) {
        List<String> names = new List<String>();
        List<RecordTypeInfo> infos = objType.getDescribe().getRecordTypeInfos();
        // If there are 2 or more RecordTypes...
        if (infos.size() > 1) {
            for (RecordTypeInfo i : infos) {
                if (i.isAvailable() && !i.isMaster() && i.isActive())
                        names.add(i.getName());
            }
        } 
            // Otherwise there's just the Master record type,
            // so add it in, since it MUST always be available
        else names.add(infos[0].getName());
        return names;
}
    
    /*
    * Method Name : fetchRecordTypeValues
    * Parameters  : Null
    * Return Type : List<String>
    */
    @AuraEnabled        
    public static List<String> fetchRecordTypeValues(String sObjectName){
        Map<String, Schema.SObjectType> globalDescribeMap = Schema.getGlobalDescribe();
        // Schema.DescribeSObjectResult sobj = globalDescribeMap.get(sObjectName).getDescribe();
        try{
            List<String> availableTypes = GetAvailableRecordTypeNamesForSObject(globalDescribeMap.get(sObjectName));
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
    
    /*
    * Method Name : getRecTypeId
    * Parameters  : String recordTypeLabel
    * Return Type : Id 
    */
    @AuraEnabled
    public static Id getRecTypeId(String recordTypeLabel,String objName){
        try{
            /*Id recid = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(recordTypeLabel).getRecordTypeId();        
                return recid;*/
            List<RecordTypeInfo> infos = ((SObject)Type.forName('Schema', objName).newInstance()).getSObjectType().getDescribe().getRecordTypeInfos();
            if (infos.size() > 1) {
                for (RecordTypeInfo i : infos) {
                    if (i.getName() == recordTypeLabel && i.isAvailable() && !i.isMaster() && i.isActive())
                        return i.getRecordTypeId();
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
    
    /*
    * Method Name : getOpportunities
    * Parameters  : String oppFilter
    * Return Type : List<Opportunity>
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
                query='SELECT Id,Name,StageName,Amount,CloseDate,Probability,RecordType.Name,AccountId,'+
                    'TM_Projected_Annual_Treasury_Fee_Income__c,TM_Anticipated_Deposit_Amount__c,Account.Name FROM Opportunity '+
                    'WHERE OwnerId = :roleId AND RecordType.Name = \'Loan\'  LIMIT 100';   
                // IN (\'Track Deposit Pipeline\',\'Track Treasury Products Sold\')
            }else {
                // String oppFilterStr = String.escapeSingleQuotes(oppFilter);
                query='SELECT Id,Name,StageName,Amount,CloseDate,Probability,RecordType.Name,AccountId,'+
                    'TM_Projected_Annual_Treasury_Fee_Income__c,TM_Anticipated_Deposit_Amount__c,Account.Name FROM Opportunity '+
                    'WHERE OwnerId = :roleId AND RecordType.Name = \'Loan\' AND '+oppFilter+strLimit ; 
                // IN (\'Track Deposit Pipeline\',\'Track Treasury Products Sold\')
            }
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
    
    /*
    @AuraEnabled 
    public static List<Opportunity> getOppor(String oppFilter){
        try{
            String roleId;
            User currentUser=[SELECT Id FROM User WHERE Id = :Userinfo.getUserId()];
            if(currentUser.Id!=null){
                roleId =currentUser.Id;
            }
            String query='';

            if(oppFilter==strAll  || oppFilter==null){
                query='SELECT Id,Name,StageName,Amount,CloseDate,LastActivityDate,ETA__c FROM Opportunity WHERE OwnerId = :roleId LIMIT 100'; 
            }
            else {
                query='SELECT Id,Name,StageName,Amount,CloseDate,LastActivityDate,ETA__c FROM Opportunity WHERE OwnerId = :roleId AND '+oppFilter+strLimit ; 
            } 

            }else {
                query='SELECT Id,Name,StageName,Amount,CloseDate,LastActivityDate,ETA__c FROM Opportunity WHERE OwnerId = :roleId AND '+oppFilter+strLimit ; 
            }            
            List<Opportunity> OpportunityList = Database.query(query);
            return OpportunityList;
            
        } catch (Exception ex) {
            // Convert the error to Aura Exception.            
            throw new AuraHandledException(System.Label.TM_StdErrorMessage);
        }        
    }
    */
    /*
    @AuraEnabled 
    public static List<Opportunity> getOppor(String oppFilter){
        try{
            String roleId;
            User currentUser=[SELECT Id FROM User WHERE Id = :Userinfo.getUserId()];
            if(currentUser.Id!=null){
                roleId =currentUser.Id;
            }

            String query='';
            if(oppFilter==strAll  || oppFilter==null){
                query='SELECT Id,Name,StageName,Amount,CloseDate,LastActivityDate,ETA__c FROM Opportunity WHERE OwnerId = :roleId LIMIT 100'; 
            }
            else {
                query='SELECT Id,Name,StageName,Amount,CloseDate,LastActivityDate,ETA__c FROM Opportunity WHERE OwnerId = :roleId AND '+oppFilter+strLimit ; 
            }

            }else {
                query='SELECT Id,Name,StageName,Amount,CloseDate,LastActivityDate,ETA__c FROM Opportunity WHERE OwnerId = :roleId AND '+oppFilter+strLimit ; 
            }            
            List<Opportunity> OpportunityList = Database.query(query);
            return OpportunityList;
            
        } catch (Exception ex) {
            // Convert the error to Aura Exception.            
            throw new AuraHandledException(System.Label.TM_StdErrorMessage);
        }        
    }

    */
    
    /*
    * Method Name : getOpportunitiesSM
    * Parameters  : String oppFilter
    * Return Type : List<Opportunity>
    */
    @AuraEnabled
    public static List<Opportunity> getOpportunitiesSM(String oppFilter) {
        try{
            String query='';
            Map<Id,UserRole> myTeamRoleMap;       
            Id roleId;
            Map<Id,User> myteam;
            // get loggedin user's role
            User currentUser=[SELECT Id,UserRoleId FROM User WHERE Id = :Userinfo.getUserId()];        
            if(currentUser.UserRoleId!=null){
                roleId =currentUser.UserRoleId;  
            }            
            myTeamRoleMap = new Map<Id,UserRole>([SELECT Id FROM UserRole WHERE ParentRoleId = :roleId AND ParentRoleID != null]);
            
            // get all of the ids for the users in those roles
            myteam = new Map<Id, User>([SELECT Id, Name, fullphotoURL FROM User WHERE UserRoleId IN :myTeamRoleMap.KeySet()]);
            Set<Id> myteamIds= myteam.KeySet();
            if(oppFilter==strAll  || oppFilter==null){
                query='SELECT Id,Name,StageName,Amount,Owner.Name,CloseDate,Probability FROM Opportunity WHERE OwnerId IN:myteamIds LIMIT 100';                                          
            } else {
                // String oppFilterStr = '\'' + String.escapeSingleQuotes(oppFilter) + '\'';
                query='SELECT Id,Name,StageName,Amount,Owner.Name,CloseDate,Probability FROM Opportunity where OwnerId IN:myteamIds AND '+oppFilter+strLimit ;    
            }            
            List<Opportunity> OpportunityList = Database.query(query);
            List<Opportunity> OpportunityListToReturn= new List<Opportunity>();
            List<Opportunity> OpportunityListClosedWon = new List<Opportunity>();
            List<Opportunity> OpportunityListOthers = new List<Opportunity>();
            if(OpportunityList!=null && OpportunityList.size()>0) {
                for(Opportunity OppObj: OpportunityList){
                    if(OppObj.StageName== strClosedWon){
                        OpportunityListClosedWon.add(OppObj);
                    }else{
                        OpportunityListOthers.add(OppObj);
                    }                    
                }
                If(OpportunityListClosedWon.size()>0 ){
                    OpportunityListToReturn.addAll(OpportunityListClosedWon);
                }
                If(OpportunityListOthers.size()>0 ){
                    OpportunityListToReturn.addAll(OpportunityListOthers);
                }
            }
            return OpportunityListToReturn;
        } catch (Exception ex) {
            // Convert the error to Aura Exception.            
            throw new AuraHandledException(System.Label.TM_StdErrorMessage);
        }
    }    
    
    /*
    * Method Name : getLeads
    * Parameters  : String leadFilter
    * Return Type : List<Lead>
    */
    // @AuraEnabled
    // public static List<Lead> getLeads(String leadFilter) {        
    //     try{
    //         //declare variables
    //         List<Lead> leadList = new List<Lead>();
    //         List<String> lstDeveloperNames = new List<String>();
    //         //Add RecordType Filters for Commercial Banking
    //         lstDeveloperNames.add('Personal_Lead');
    //         lstDeveloperNames.add('Business_Lead');
    //         String query='';
    //         if(leadFilter==strAll )  {
    //             query='SELECT Id,Name,Status,Company,LeadSource,Phone,LastActivityDate,FinServ__ExpressedInterest__c,FinServ__PotentialValue__c,Activity_Needed__c,Specific_Product_Interest__c FROM Lead WHERE RecordType.DeveloperName=:lstDeveloperNames LIMIT 100';                                          
    //         }else if(leadFilter.contains('recordtype')){
    //             // String leadFilterStr = '\'' + String.escapeSingleQuotes(leadFilter) + '\'';
    //             query='SELECT Id,Name,Status,Company,LeadSource,Phone,LastActivityDate,FinServ__ExpressedInterest__c,FinServ__PotentialValue__c,Activity_Needed__c,Specific_Product_Interest__c FROM Lead WHERE '+leadFilter + strLimit ;
    //         } else {
    //             // String leadFilterStr = '\'' + String.escapeSingleQuotes(leadFilter) + '\'';
    //             query='SELECT Id,Name,Status,Company,LeadSource,Phone,LastActivityDate,FinServ__ExpressedInterest__c,FinServ__PotentialValue__c,Activity_Needed__c,Specific_Product_Interest__c FROM Lead WHERE RecordType.DeveloperName=:lstDeveloperNames AND '+leadFilter + strLimit ;    
    //         }
    //         //fire query
    //         //System.debug('demo query'+query);
    //         if(query.length() > 0){
    //             leadList = Database.query(query);
    //         }
    //         return leadList;
    //     } catch (Exception ex) {
    //         // Convert the error to Aura Exception.            
    //         throw new AuraHandledException(System.Label.TM_StdErrorMessage);
    //     }        
    // }
    
    /*
    * Method Name : getLeadsForFinFlowsHome
    * Parameters  : String leadFilter
    * Return Type : List<Lead>
    */
    // @AuraEnabled 
    // public static List<Lead> getReferralsForFinFlowsHome(String leadFilter) {        
    //     try{
    //         //declare variables
    //         List<String> lstDeveloperNames = new List<String>();
    //         Id UserId = UserInfo.getUserId();
    //         //Add RecordType Filters for Commercial Banking
    //         lstDeveloperNames.add('Personal_Lead');
    //         lstDeveloperNames.add('Business_Lead');
    //         //fire query
    //         List<Lead> leadList = [SELECT Id, RecordTypeId, Name, Company, IsConverted, Status, OwnerId,
    //                                       Activity_Needed__c, FinServ__ExpressedInterest__c, FinServ__PotentialValue__c,
    //                                       FinServ__ReferredByContact__c,FinServ__ReferredByUser__c 
    //                                  FROM Lead 
    //                                  WHERE IsConverted = false 
    //                                  AND RecordType.DeveloperName in : lstDeveloperNames // ('0124T000000PaRAQA0','0124T000000PaR8QAK') 
    //                                  AND status NOT IN ('unqualified','nurturing') 
    //                                  AND ((FinServ__ReferredByContact__c!=NULL AND FinServ__ReferredByUser__c=NULL) OR
    //                                       (FinServ__ReferredByContact__c=NULL AND FinServ__ReferredByUser__c!=NULL))
    //                                  AND OwnerId =: UserId];
    //         return leadList;
    //     } catch (Exception ex) {
    //         // Convert the error to Aura Exception.            
    //         throw new AuraHandledException(System.Label.TM_StdErrorMessage);
    //     }        
    // }
    
    /*
    * Method Name : getReferralsForFinFlowsHome
    * Parameters  : String leadFilter
    * Return Type : List<Lead>
    */
    // @AuraEnabled 
    // public static List<Lead> getLeadsForFinFlowsHome(String leadFilter) {        
    //     try{
    //         //declare variables
    //         List<String> lstDeveloperNames = new List<String>();
    //         Id UserId = UserInfo.getUserId();
    //         //Add RecordType Filters for Commercial Banking
    //         lstDeveloperNames.add('Personal_Lead');
    //         lstDeveloperNames.add('Business_Lead');
    //         //fire query
    //         List<Lead> leadList = [Select Id, RecordTypeId, Name, Company, IsConverted, Status, OwnerId,
    //                                       Activity_Needed__c, FinServ__ExpressedInterest__c, FinServ__PotentialValue__c,
    //                                       FinServ__ReferredByContact__c, FinServ__ReferredByUser__c 
    //                                FROM Lead 
    //                                WHERE IsConverted = false
    //                                AND RecordType.DeveloperName in : lstDeveloperNames // ('0124T000000PaRAQA0','0124T000000PaR8QAK') 
    //                                AND status NOT IN ('unqualified','nurturing') 
    //                                AND FinServ__ReferredByContact__c=NULL 
    //                                AND FinServ__ReferredByUser__c=NULL 
    //                                AND OwnerId =: UserId];
                                   
                                   
    //         return leadList;
    //     } catch (Exception ex) {
    //         // Convert the error to Aura Exception.            
    //         throw new AuraHandledException(System.Label.TM_StdErrorMessage);
    //     }        
    // }
    
    /*
    * Method Name : getAccounts
    * Parameters  : String accFilter
    * Return Type : List<Account>
    */
    @AuraEnabled
    public static List<Account> getAccounts(String accFilter) {
        try{
            //declare variables
            List<Account> AccountList = new List<Account>();
            String query='';
            String yes = 'Inactive';
            String noNullStatusValues = ' FinServ__Status__c!=NULL ';
            String noNullRevenueValues = ' FinServ__TotalRevenue__c!=NULL ';
            //String noInactiveAccounts = ' Active__c =:yes  ';
            String recordTypeName = 'Business'; //Schema.SObjectType.Account.getRecordTypeInfosById().get('0124T000000PaQgQAK').getName();//business
            if(accFilter==strAll)       {
                query='SELECT Id,Name,FinServ__Status__c,Type,FinServ__TotalRevenue__c,CF_Type__c,Industry,BillingCity,BillingState,RecordType.Name FROM Account WHERE FinServ__Status__c !=:yes AND RecordType.Name=:recordTypeName '+'AND' +noNullStatusValues+ strAnd + noNullRevenueValues + 'LIMIT 100';
               // system.debug('query :: '+query);
            } else {
                // String accFilterStr = '\'' + String.escapeSingleQuotes(accFilter) + '\'';
                query='SELECT Id,Name,FinServ__Status__c,Type,FinServ__TotalRevenue__c,CF_Type__c,Industry,BillingCity,BillingState FROM Account WHERE FinServ__Status__c !=:yes AND RecordType.Name=:recordTypeName '+ strAnd +accFilter + strAnd +noNullStatusValues + strAnd + noNullRevenueValues +strLimit ;    
            }    
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
    
    /*
    * Method Name : getWealthClients
    * Parameters  : String accFilter
    * Return Type : List<Account>
    * Description : get the person accounts for Wealth HomePage
    */
    @AuraEnabled
    public static List<Account> getWealthClients(String accFilter){
        try{
            //declare variables
            String query='';
            String yes = 'Inactive';
            String noNullStatusValues = ' FinServ__Status__c!=NULL ';
            String noNullRevenueValues = ' FinServ__TotalRevenue__c!=NULL ';
           // String noInactiveAccounts = ' Active__c =:yes  ';
            String recordTypeName = 'Person Account'; //Schema.SObjectType.Account.getRecordTypeInfosById().get('0124T000000PfZ7QAK').getName();//person
            if(accFilter==strAll || accFilter==null ){
                query='SELECT Id,Name,FinServ__Status__c,Type,FinServ__TotalRevenue__c,Rag_Status__c,Industry,BillingCity,BillingState,RecordType.Name FROM Account WHERE FinServ__Status__c !=:yes AND RecordType.Name=:recordTypeName '+'AND' +noNullStatusValues+ strAnd + noNullRevenueValues + 'LIMIT 100';
            } else {
                // String accFilterStr = '\'' + String.escapeSingleQuotes(accFilter) + '\'';
                query='SELECT Id,Name,FinServ__Status__c,Type,FinServ__TotalRevenue__c,Rag_Status__c,Industry,BillingCity,BillingState FROM Account WHERE FinServ__Status__c !=:yes AND RecordType.Name=:recordTypeName '+ strAnd +accFilter + strAnd +noNullStatusValues + strAnd + noNullRevenueValues +strLimit ;    
            }
            //fire query
            List<Account> AccountList = Database.query(query);        
            return AccountList; 
        } catch (Exception ex) {
            // Convert the error to Aura Exception.            
            throw new AuraHandledException(System.Label.TM_StdErrorMessage);
        }
    }
    
    /*
    * Method Name : initMethod
    * Parameters  : String obj
    * Return Type : wrapperClass 
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
            
            //List<String> Api = new List<String>();
            
            //List<Schema.DisplayType> fieldType = new List<Schema.DisplayType>();
            
            //get a map with describe information about every single object
            Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
            // Schema.SObjectType leadSchema = schemaMap.get(type);
            //Map<String, Schema.SObjectField> fieldMap = leadSchema.getDescribe().fields.getMap();
            
            /*Api.addAll(fieldMap.keySet());
            Api.sort();
            for(String fieldName : Api){
                fieldApi.add(String.valueOf(fieldMap.get(fieldName)));
                system.debug('Field API :: '+fieldApi);
                fieldLabel.add(fieldMap.get(fieldName).getDescribe().getLabel());
                system.debug('Field Label :: '+fieldLabel);
                fieldType.add(String.valueOf(fieldMap.get(fieldName).getDescribe().getType()));
                System.debug('Field Type :: '+fieldType);
            }*/
            
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
            /*for (String fieldName: fieldMap.keySet()) {
                //Schema.DisplayType strSchedule = Schema.Opportunity.fields.Name.getDescribe().getType();
                //fieldType.add(String.valueOf(Schema.getGlobalDescribe().get(type).getDescribe().fields.getMap().get(fieldName).getDescribe().getType().name().toupperCase()));
                //System.debug(String.ValueOf(fieldTypeName));
                
                //Schema.SObjectType t = Schema.getGlobalDescribe().get(type);
                //Schema.DescribeSObjectResult r = t.getDescribe();
                //Schema.DescribeFieldResult f = r.fields.getMap().get(fieldName).getDescribe();
                //fieldType.add(String.valueOf(f.getType()));
                //System.debug(fieldType);
                fieldApi.add(String.valueOf(fieldName));
                //fieldApi.sort();
                //system.debug('Field API :: '+fieldApi);
                fieldLabel.add(fieldMap.get(fieldName).getDescribe().getLabel());
                //fieldLabel.sort();
                //system.debug('Field Label :: '+fieldLabel);
                 fieldType.add(String.valueOf(fieldMap.get(fieldName).getDescribe().getType()));
                //fieldType.add(fieldName.getType());
                //fieldType.sort();
                system.debug('Field type :: '+fieldType);
                //fieldType.add(fieldMap.get(fieldName).getDescribe().getType());
            }*/
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
     * Parameters  : String fieldSetName
     *               String obj
     * @return   return description
     */ 
    @AuraEnabled
    public static wrapperClass getFilterFields(String fieldSetName,String obj){
        try {
            wrapperClass returnwrapperClass = new  wrapperClass ();
            List<String> fieldApi = new List<String>();
            List<String> fieldLabel = new List<String>();
            List<String> fieldType = new List<String>();
            List<Schema.FieldSetMember> fieldSetMemberList =  TM_Utility.readFieldSet(fieldSetName,obj);
            for(Schema.FieldSetMember fieldSetMemberObj : fieldSetMemberList)
            {
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
    
    /*
    * Method Name : getPickListValues
    * Parameters  : String stage
    *               String obj
    * Return Type : List<String> 
    */
    @AuraEnabled
    public static List<String> getPickListValues(String fieldApiName,String obj) {
        try{
            //Schema.DisplayType getfieldType=getType(stage);
            String type=obj;
            //String fieldLabel;
            //Schema.DisplayType pick=getType('Status');
            
            //get a map with describe information about every single object
            // Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
            // Schema.SObjectType leadSchema = schemaMap.get(type);
            // Map<String, Schema.SObjectField> fieldMap = leadSchema.getDescribe().fields.getMap();        
            // Map<String,String> fieldMapping =new Map<String,String>();
            
            // for (String fieldName: fieldMap.keySet()) {            
            //     fieldMapping.put(fieldMap.get(fieldName).getDescribe().getLabel(),fieldName);            
            // }
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
    
    /*
    * Method Name : getStageWiseData
    * Parameters  : NULL
    * Return Type : wrapperMyteamsDashboard 
    */
    @AuraEnabled
    public static wrapperMyteamsDashboard getStageWiseData(){ 
        //List<String> CommercialStages = ['Prospecting','Prescreening','Underwriting','Negotiation','Closed Lost','Closed Won'];
        Decimal totalProspecting ,totalPrescreening ,totalUnderwriting ,totalNegotiation , totalClosedLost, totalClosedWon;
        wrapperMyteamsDashboard myTeamsOpps = new wrapperMyteamsDashboard();
        Map<Id, Map<String, Decimal >> OwnerIdOpsStageAmountMap = new Map<Id, Map<String, Decimal >>();
        try{
            AggregateResult[] groupedResultsMyTeam = [SELECT StageName,Sum(Amount)sumStage,Owner.Name, OwnerId FROM Opportunity WHERE RecordType.DeveloperName = 'OPP_nCino_Opportunity'  GROUP BY OwnerID,Owner.Name,StageName ORDER BY OwnerId ASC];
            
            totalProspecting = totalPrescreening = totalUnderwriting = totalNegotiation= totalClosedLost=totalClosedWon= 0;
            
            if(groupedResultsMyTeam!=null){
                for(AggregateResult Ops: groupedResultsMyTeam){
                    Id ownerId= (String)Ops.get('OwnerId');
                    String stageName = (String)Ops.get('StageName');
                    Decimal sum= (Decimal)Ops.get('sumStage');
                    if (!OwnerIdOpsStageAmountMap.containsKey(ownerId)){
                        OwnerIdOpsStageAmountMap.put(ownerId,new Map<String, Decimal>());
                        OwnerIdOpsStageAmountMap.get(ownerId).put(stageName,sum);
                    } else if(OwnerIdOpsStageAmountMap.containsKey(ownerId)){
                        OwnerIdOpsStageAmountMap.get(ownerId).put(stageName,sum);
                    }
                }
                //system.debug('OwnerIdOpsStageAmountMap.Keyset()-->'+ OwnerIdOpsStageAmountMap.Keyset());
                //system.debug('OwnerIdOpsStageAmountMap.values()-->'+ OwnerIdOpsStageAmountMap.values());
                //system.debug('OwnerIdOpsStageAmountMap.Keyset()-->'+ OwnerIdOpsStageAmountMap.Keyset());
                //system.debug('OwnerIdOpsStageAmountMap.values()-->'+ OwnerIdOpsStageAmountMap.values());
            }
            Map<Id,User> userData =  new Map<Id,User>([SELECT Id, Name, FullPhotoURL FROM User WHERE Id IN : OwnerIdOpsStageAmountMap.KeySet()]);
            myTeamsOpps.oppsPerUser= new List<wrapperOppsByStage>();
            wrapperOppsByStage userRecordStage; //= new wrapperOppsByStage() ;
            for(Id userId : OwnerIdOpsStageAmountMap.KeySet()) { 
                userRecordStage = new wrapperOppsByStage() ;
                userRecordStage.UserFullName = userData.get(userId).Name;
                userRecordStage.UserShortImgUrl = userData.get(userId).FullPhotoURL;
                //for(String stage: CommercialStages){
                if(OwnerIdOpsStageAmountMap.get(userId).containsKey('Prospecting')){
                    userRecordStage.Prospecting = String.valueOf(OwnerIdOpsStageAmountMap.get(userId).get('Prospecting').divide(1000000, 2)) + ' M';
                    totalProspecting += OwnerIdOpsStageAmountMap.get(userId).get('Prospecting');
                } else{ 
                    userRecordStage.Prospecting = '0';
                }
                
                if(OwnerIdOpsStageAmountMap.get(userId).containsKey('Prescreening')){
                    userRecordStage.Prescreening = String.valueOf(OwnerIdOpsStageAmountMap.get(userId).get('Prescreening').divide(1000000, 2)) + ' M';
                    totalPrescreening += OwnerIdOpsStageAmountMap.get(userId).get('Prescreening');
                } else{ 
                    userRecordStage.Prescreening = '0';
                }
                
                if(OwnerIdOpsStageAmountMap.get(userId).containsKey('Underwriting')){
                    userRecordStage.Underwriting = String.valueOf(OwnerIdOpsStageAmountMap.get(userId).get('Underwriting').divide(1000000, 2)) + ' M';
                    totalUnderwriting += OwnerIdOpsStageAmountMap.get(userId).get('Underwriting');
                } else {
                    userRecordStage.Underwriting = '0';
                }
                
                if(OwnerIdOpsStageAmountMap.get(userId).containsKey('Negotiation')){
                    userRecordStage.Negotiation = String.valueOf(OwnerIdOpsStageAmountMap.get(userId).get('Negotiation').divide(1000000, 2)) + ' M';
                    totalNegotiation += OwnerIdOpsStageAmountMap.get(userId).get('Negotiation');
                } else{ 
                    userRecordStage.Negotiation = '0';
                }
                
                if(OwnerIdOpsStageAmountMap.get(userId).containsKey('Closed Lost')){
                    userRecordStage.ClosedLost = String.valueOf(OwnerIdOpsStageAmountMap.get(userId).get('Closed Lost').divide(1000000, 2)) + ' M';
                    totalClosedLost += OwnerIdOpsStageAmountMap.get(userId).get('Closed Lost');
                } else {
                    userRecordStage.ClosedLost = '0';
                }
                
                if(OwnerIdOpsStageAmountMap.get(userId).containsKey(strClosedWon)){
                    userRecordStage.ClosedWon = String.valueOf(OwnerIdOpsStageAmountMap.get(userId).get(strClosedWon).divide(1000000, 2)) + ' M';
                    totalClosedWon += OwnerIdOpsStageAmountMap.get(userId).get(strClosedWon);
                } else {
                    userRecordStage.ClosedWon = '0';    
                    myTeamsOpps.oppsPerUser.add(userRecordStage); 
                }            
            }
            
            myTeamsOpps.totalProspecting= String.valueOf(totalProspecting.divide(1000000, 2)) + ' M';
            myTeamsOpps.totalPrescreening= String.valueOf(totalPrescreening.divide(1000000, 2)) + ' M';
            myTeamsOpps.totalUnderwriting= String.valueOf(totalUnderwriting.divide(1000000, 2)) + ' M';
            myTeamsOpps.totalNegotiation= String.valueOf(totalNegotiation.divide(1000000, 2)) + ' M';
            myTeamsOpps.totalClosedLost= String.valueOf(totalClosedLost.divide(1000000, 2)) + ' M';
            myTeamsOpps.totalClosedWon= String.valueOf(totalClosedWon.divide(1000000, 2)) + ' M';
            
            //system.debug(myTeamsOpps);
            return myTeamsOpps;
        } catch (Exception ex) {
            // Convert the error to Aura Exception.            
            throw new AuraHandledException(System.Label.TM_StdErrorMessage);
        }   
    }
    
    // wrapper or Inner class with @AuraEnabled {get;set;} properties*    
    public class wrapperClass{   
     @AuraEnabled public List<String> lstLabel{get;set;}
     @AuraEnabled public List<String> lstType{get;set;}
     @AuraEnabled public List<String> lstApi{get;set;}
     //@AuraEnabled public Map<String,List<String>> fieldValues{get;set;}
     //@AuraEnabled public List<Schema.DisplayType> lstType{get;set;}
    }
    
    // wrapper or Inner class with @AuraEnabled {get;set;} properties*    
    public class wrapperOppsByStage {   
         @AuraEnabled public String Prospecting{get;set;}
         @AuraEnabled public String Prescreening{get;set;}
         @AuraEnabled public String Underwriting{get;set;}
         @AuraEnabled public String Negotiation{get;set;}
         @AuraEnabled public String ClosedLost{get;set;}
         @AuraEnabled public String ClosedWon{get;set;}         
         @AuraEnabled public String UserShortImgUrl{get;set;}
         @AuraEnabled public String UserFullName{get;set;}
    }
    
    // declare wrapperMyteamsDashboard
    public class wrapperMyteamsDashboard{ 
        @AuraEnabled public String totalProspecting {get;set;}
        @AuraEnabled public String totalPrescreening {get;set;}
        @AuraEnabled public String totalUnderwriting {get;set;}
        @AuraEnabled public String totalNegotiation {get;set;}
        @AuraEnabled public String totalClosedLost {get;set;}
        @AuraEnabled public String totalClosedWon{get;set;}
        @AuraEnabled public List<wrapperOppsByStage> oppsPerUser{get;set;}
    }
    
    /*@AuraEnabled 
    public static List<Opportunity> getOppor(String oppFilter){
        try{
            String roleId;
            User currentUser=[SELECT Id FROM User WHERE Id = :Userinfo.getUserId()];
            if(currentUser.Id!=null){
                roleId =currentUser.Id;
            }
            String query='';
            if(oppFilter==strAll  || oppFilter==null){
                query='SELECT Id,Name,StageName,Amount,CloseDate,LastActivityDate,ETA__c FROM Opportunity WHERE OwnerId = :roleId LIMIT 100'; 
            }
            else {
                query='SELECT Id,Name,StageName,Amount,CloseDate,LastActivityDate,ETA__c FROM Opportunity WHERE OwnerId = :roleId AND '+oppFilter+strLimit ; 
            } 

            }
            else {
                query='SELECT Id,Name,StageName,Amount,CloseDate,LastActivityDate,ETA__c FROM Opportunity WHERE OwnerId = :roleId AND '+oppFilter+strLimit ; 
            }            
            List<Opportunity> OpportunityList = Database.query(query);
            return OpportunityList;
            
        } catch (Exception ex) {
            // Convert the error to Aura Exception.            
            throw new AuraHandledException(System.Label.TM_StdErrorMessage);
        }        
    }
    */
   
}