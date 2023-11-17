/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class LiensLoaderInvoker {
    global LiensLoaderInvoker() {

    }
    @InvocableMethod(label='Liens Loader' description='This invocable method loads liens.')
    global static List<LLC_BI.LiensLoaderInvoker.OutputParams> invoke(List<LLC_BI.LiensLoaderInvokerArgDto> args) {
        return null;
    }
global class OutputParams {
    @AuraEnabled
    @InvocableVariable( required=false)
    global List<LLC_BI.LienInvokerDto> liens;
    global OutputParams() {

    }
}
}
