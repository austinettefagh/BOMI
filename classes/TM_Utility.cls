/*********************************************************************************************************
*@author    : PwC Team
*@date      : August 12 2020
*@description : This class acts as Utility class
*@Modification Log   :
-----------------------------------------------------------------------------
* Developer                   Date                   Description
* ----------------------------------------------------------------------------                
* 
***************************************************************************************************/
public class TM_Utility {
    private TM_Utility (){}
    private static map<string,string> profilesMap;
    /**
     * @description getprofileInfo description
     * @param  profileNameorId profileNameorId description
     * @return                 return description
     */ 
    public static string getprofileInfo(string profileNameorId) {
        string retValue;
        boolean valueExist= false;
        try{
            if(profilesMap.containsKey(profileNameorId) ){
                valueExist = true;
                retValue = profilesMap.get(profileNameorId);
                return retValue;
            }
        }
        catch(Exception ex){
            valueExist = false;
            profilesMap =new map<string,string>();
        }
        if(!valueExist){
            for(profile prof : [SELECT id,Name FROM Profile WHERE (Name=:profileNameorId or Id=:profileNameorId)]){
                profilesMap.put(prof.Id,prof.Name);
                profilesMap.put(prof.Name,prof.Id);
            }
        }
        retValue = profilesMap.containsKey(profileNameorId) ?profilesMap.get(profileNameorId):null;
        return retValue;
    }
    /**
     * @description readFieldSet description
     * @param  fieldSetName fieldSetName description
     * @param  objectName   ObjectName description
     * @return              return description
     */ 
    public static List<Schema.FieldSetMember> readFieldSet(String fieldSetName, String objectName){
        Map<String, Schema.SObjectType> GlobalDescribeMap = Schema.getGlobalDescribe(); 
        Schema.SObjectType SObjectTypeObj = GlobalDescribeMap.get(objectName);
        Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();
        Schema.FieldSet fieldSetObj = DescribeSObjectResultObj.FieldSets.getMap().get(fieldSetName);
        return fieldSetObj.getFields(); 
    }  
}