/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class CollateralGroupsSaverInvokerArgDto {
    @AuraEnabled
    @InvocableVariable(label='Account Collateral Fieldset Name' description='The field set name for Account Collateral for which fields should be saved.' required=false)
    global String accountCollateralFieldSet;
    @AuraEnabled
    @InvocableVariable(label='Collateral Group Fieldset Name' description='The field set name for Collateral Group for which fields should be saved.' required=false)
    global String collateralGroupFieldSet;
    @AuraEnabled
    @InvocableVariable(label='Collateral Groups' description='List of collateral groups to save.' required=true)
    global List<LLC_BI.CollateralGroupInvokerDto> collateralGroups;
    @AuraEnabled
    @InvocableVariable(label='Group Connection Fieldset Name' description='The field set name for Group Connection for which fields should be saved.' required=false)
    global String groupConnectionFieldSet;
    global CollateralGroupsSaverInvokerArgDto() {

    }
}
