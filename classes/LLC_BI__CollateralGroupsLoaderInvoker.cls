/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class CollateralGroupsLoaderInvoker {
    global CollateralGroupsLoaderInvoker() {

    }
    @InvocableMethod(label='Collateral Groups Loader' description='This invocable method loads Collateral Groups')
    global static List<LLC_BI.CollateralGroupsLoaderInvoker.OutputParams> invoke(List<LLC_BI.CollateralGroupsLoaderInvokerArgDto> args) {
        return null;
    }
global class OutputParams {
    @AuraEnabled
    @InvocableVariable(label='Collateral Groups' description='Output response from Collateral Groups Loader Service.' required=true)
    global List<LLC_BI.CollateralGroupInvokerDto> collateralGroups;
    global OutputParams() {

    }
}
}
