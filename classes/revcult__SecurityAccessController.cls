/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class SecurityAccessController {
    global SecurityAccessController() {

    }
    global static List<FieldDefinition> FieldToolingQuery(String queryString) {
        return null;
    }
    global static Set<Id> GetUserIdsFromGroups(Set<Id> groupids, Map<String,List<Id>> userIdsByType) {
        return null;
    }
    global static Set<Id> GetUserIdsFromGroups(Set<Id> groupids, Map<String,List<Id>> userIdsByType, List<String> debugs) {
        return null;
    }
    global static String StringToolingQuery(String queryString) {
        return null;
    }
    global static revcult.SecurityAccessController.ToolingQueryResult ToolingQuery(String queryString) {
        return null;
    }
    @RemoteAction
    global static Object badIdea() {
        return null;
    }
    @RemoteAction
    global static Boolean checkIndividualEnabled() {
        return null;
    }
    @RemoteAction
    global static Boolean checkMetadataApi() {
        return null;
    }
    @RemoteAction
    global static Boolean checkPMCServiceAuth() {
        return null;
    }
    global static void coverMe() {

    }
    global static List<EntityDefinition> entityToolingQuery(String queryString) {
        return null;
    }
    global static Object getAccess(Id recordId) {
        return null;
    }
    @RemoteAction
    global static Object getAccessStress(Id recordId) {
        return null;
    }
    global static Object getAccess(Id recordId, Map<String,String> sharingModels) {
        return null;
    }
    global static Set<Id> getAllSubRoleIds(Set<Id> roleIds) {
        return null;
    }
    @RemoteAction
    global static String getBaseUrl() {
        return null;
    }
    global static Set<String> getExpiredPackageNamespaces() {
        return null;
    }
    @RemoteAction
    global static Set<Id> getExternalProfileIds() {
        return null;
    }
    @RemoteAction
    global static Object getFieldAccess(String userId, Id recordId) {
        return null;
    }
    @RemoteAction
    global static List<SObject> getNameFromId(Id anId) {
        return null;
    }
    @RemoteAction
    global static Map<String,String> getObjectNameMap() {
        return null;
    }
    @RemoteAction
    global static Object getObjectSharingModel(String objectTypeName) {
        return null;
    }
    @RemoteAction
    global static String getPMCUrl() {
        return null;
    }
    @RemoteAction
    global static Set<Id> getRecentlyLoggedInUserIdsByProfile(Id profileId) {
        return null;
    }
    global static List<Object> getRecordsFromToolingResult(String toolingQueryResultString) {
        return null;
    }
    @RemoteAction
    global static Object getSelectedFromId(Id anId) {
        return null;
    }
    @RemoteAction
    global static Object getSpecificUserAccess(Id recordId, Map<String,String> sharingModels, List<Id> userIds) {
        return null;
    }
    @RemoteAction
    global static Set<Id> getStandardUserIds() {
        return null;
    }
    @RemoteAction
    global static Object getUserAccess(Id recordId, Map<String,String> sharingModels) {
        return null;
    }
    @RemoteAction
    global static Integer getWswRecordsAccessBatchSize() {
        return null;
    }
    global static Boolean idIsCollaborationGroup(Id idInQuestion) {
        return null;
    }
    global static Boolean idIsGroup(Id idInQuestion) {
        return null;
    }
    global static Boolean idIsRole(Id idInQuestion) {
        return null;
    }
    global static Boolean idIsUser(Id idInQuestion) {
        return null;
    }
    @RemoteAction
    global static Boolean isId(String inputString) {
        return null;
    }
    global static void processSharingRecord(Id userId, String accessLevel, String rowCause, String recordId, String sharingSettingsLink, String createdByName, String createdDate, Map<Id,List<revcult.SecurityAccessController.sharingRecordInformation>> mapUserIdToSharingInformation) {

    }
    global static Object sObjectSearch(String searchString) {
        return null;
    }
    global static Object sObjectSearch(List<String> params) {
        return null;
    }
    @RemoteAction
    global static Object sObjectSearch(String searchString, List<String> objectApiNames) {
        return null;
    }
    @RemoteAction
    global static void sendErrorEmail(String errorString) {

    }
    global static Boolean sharingListHasDel(List<revcult.SecurityAccessController.sharingRecordInformation> sharingList) {
        return null;
    }
    global static Boolean sharingListHasEdit(List<revcult.SecurityAccessController.sharingRecordInformation> sharingList) {
        return null;
    }
    global static Boolean sharingListHasRead(List<revcult.SecurityAccessController.sharingRecordInformation> sharingList) {
        return null;
    }
    @RemoteAction
    global static String stepUp2TheStreets() {
        return null;
    }
global class FieldAccess {
}
global class FieldAccessReason {
}
global class GenericToolingQueryResult {
    global GenericToolingQueryResult() {

    }
}
global class ToolingQueryResult {
    global ToolingQueryResult() {

    }
}
global class UserAccess {
    global UserAccess() {

    }
}
global class UserAccessDetail {
}
global class UserAccessReasonDetail {
}
global class UserAccessReasonItem {
}
global class UserAccessReasons {
    global UserAccessReasons() {

    }
}
global class sharingRecordInformation {
    global sharingRecordInformation(String reason, String link, String accessLevel) {

    }
}
}
