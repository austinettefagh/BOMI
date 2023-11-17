/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class LiensLoaderInvokerArgDto {
    @AuraEnabled
    @InvocableVariable(label='Lien Ids' description='A list of lien IDs to load.' required=false)
    global List<String> lienIds;
    @AuraEnabled
    @InvocableVariable(label='Response Model DTO' description='A model that enables consumers to customize the service response beyond the default model.' required=false)
    global String responseModelDto;
    global LiensLoaderInvokerArgDto() {

    }
}
