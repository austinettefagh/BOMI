/*********************************************************************************************************
*@author    : PwC Team
*@date      : August 12 2020
*@description : This class acts as generic lookup controller class
*@Modification Log   :
-----------------------------------------------------------------------------
* Developer                   Date                   Description
* ----------------------------------------------------------------------------                
* 
***************************************************************************************************/
public with sharing class TM_GenericLookupController {
   @AuraEnabled(cacheable=true)  
   public static List<sobject> findRecords(String searchKey, String objectName,String lookupFilterId) {  
       try{
            // string searchText = '\'' + String.escapeSingleQuotes(searchKey) + '%\'';  
            // string filterId = '\'' + String.escapeSingleQuotes(lookupFilterId) + '\'';  
            string query = 'SELECT Id, Name FROM ' +String.escapeSingleQuotes(objectName)+ ' WHERE IsActive = true AND Name LIKE '+'\'' + String.escapeSingleQuotes(searchKey) + '%\''+' LIMIT 6'; 
            if(!String.isBlank(lookupFilterId)){
                query = 'SELECT Id, Name FROM ' +String.escapeSingleQuotes(objectName)+ ' WHERE IsActive = true AND Name LIKE '+'\'' + String.escapeSingleQuotes(searchKey) + '%\''+' AND AccountId = '+'\'' + String.escapeSingleQuotes(lookupFilterId) + '\''+' LIMIT 6';
            }
            return Database.query(query);
       } catch (Exception ex) {
            // "Convert" the exception into an AuraHandledException
            //usage of custom labels for error messages
            throw new AuraHandledException(System.Label.TM_StdErrorMessage);    
       }
   }  
}