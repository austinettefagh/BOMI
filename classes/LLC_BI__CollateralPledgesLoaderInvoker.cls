/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class CollateralPledgesLoaderInvoker {
    global CollateralPledgesLoaderInvoker() {

    }
    @InvocableMethod(label='Collateral Pledges Loader' description='This invocable method loads pledges.')
    global static List<LLC_BI.CollateralPledgesLoaderInvoker.OutputParams> invoke(List<LLC_BI.CollateralPledgesLoaderInvokerArgDto> args) {
        return null;
    }
global class OutputParams {
    @AuraEnabled
    @InvocableVariable( required=false)
    global List<LLC_BI.CollateralPledgedInvokerDto> pledges;
    global OutputParams() {

    }
}
}
