/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class LoansRecalculatorInvoker_v2 {
    global LoansRecalculatorInvoker_v2() {

    }
    @InvocableMethod(label='Loan Recalculation - LoansRecalculatorMapper_v2 Service' description='This resource allows updating of the pricing structure the LoansRecalculatorMapper_v2 service.')
    global static List<LLC_BI.LoansRecalculatorInvoker_v2.OutputParams> invoke(List<LLC_BI.LoansRecalculatorInvoker_v2.InputParams> params) {
        return null;
    }
global class InputParams {
    @InvocableVariable(label='Loan Id' description='The loan Id needed to run the mapper service.' required=true)
    global String loanId;
    global InputParams() {

    }
}
global class OutputParams {
    @InvocableVariable(label='-D AsyncJob Id' description='--DEPRECATED-- The Id of the async job that schedules the mapper service to run.' required=false)
    global String apexAsyncJobId;
    global OutputParams() {

    }
}
}
