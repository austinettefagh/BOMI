/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class CollateralGroupsLoaderInvokerArgDto {
    @AuraEnabled
    @InvocableVariable(label='Account Collateral Response Model' description='A model that enables consumers to customize the service response beyond the default model.' required=false)
    global String accountCollateralResponseModelDto;
    @AuraEnabled
    @InvocableVariable(label='Account Ids' description='A list of account IDs to load.' required=false)
    global List<String> accountIds;
    @AuraEnabled
    @InvocableVariable(label='Associated Collateral Response Model' description='A model that enables consumers to customize the service response beyond the default model.' required=false)
    global String associatedCollateralResponseModelDto;
    @AuraEnabled
    @InvocableVariable(label='Collateral Group Ids' description='A list of collateral group IDs to load.' required=false)
    global List<String> collateralGroupIds;
    @AuraEnabled
    @InvocableVariable(label='Group Connection Response Model' description='A model that enables consumers to customize the service response beyond the default model.' required=false)
    global String groupConnectionResponseModelDto;
    @AuraEnabled
    @InvocableVariable(label='Group Types' description='A list of group types to filter by.' required=false)
    global List<String> groupTypes;
    @AuraEnabled
    @InvocableVariable(label='Response Model DTO' description='A model that enables consumers to customize the service response beyond the default model.' required=false)
    global String responseModelDto;
    global CollateralGroupsLoaderInvokerArgDto() {

    }
}
