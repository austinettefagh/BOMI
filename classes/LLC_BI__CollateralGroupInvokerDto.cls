/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class CollateralGroupInvokerDto extends LLC_BI.AModeledInvokerTransferableData {
    @AuraEnabled
    @InvocableVariable(label='Account Collaterals' description='This output value contains a list of account collaterals.' required=false)
    global List<LLC_BI.AccountCollateralInvokerDto> accountCollaterals;
    @AuraEnabled
    @InvocableVariable(label='Key Value Pair List' description='This output value contains a list of pipe delimited key value pairs (ex. "key|value")' required=false)
    global List<String> attributeValuePairs;
    @AuraEnabled
    @InvocableVariable(label='Group Connections' description='This output value contains a list of group connections.' required=false)
    global List<LLC_BI.GroupConnectionInvokerDto> groupConnections;
    @AuraEnabled
    @InvocableVariable(label='Collateral Group Identity' description='Collateral Salesforce Id' required=false)
    global String identity;
    global CollateralGroupInvokerDto() {

    }
}
