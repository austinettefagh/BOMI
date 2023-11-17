/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class CollateralPledgesLoaderInvokerArgDto {
    @AuraEnabled
    @InvocableVariable(label='Collateral Ids' description='A list of collateral IDs used to load a pledge.' required=false)
    global List<String> collateralIds;
    @AuraEnabled
    @InvocableVariable(label='Loan Ids' description='A list of loan IDs used to load a pledge.' required=false)
    global List<String> loanIds;
    @AuraEnabled
    @InvocableVariable(label='Pledge Ids' description='A list of pledge IDs to load.' required=false)
    global List<String> pledgeIds;
    @AuraEnabled
    @InvocableVariable(label='Response Model DTO' description='A model that enables consumers to customize the service response beyond the default model.' required=false)
    global String responseModelDto;
    global CollateralPledgesLoaderInvokerArgDto() {

    }
}
