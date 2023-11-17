<?xml version="1.0" encoding="UTF-8"?>
<CustomMetadata xmlns="http://soap.sforce.com/2006/04/metadata" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    <label>SBA PrincipalRace</label>
    <protected>false</protected>
    <values>
        <field>MTRNS__Category__c</field>
        <value xsi:type="xsd:string">SBEOC</value>
    </values>
    <values>
        <field>MTRNS__CompiledInstructions__c</field>
        <value xsi:type="xsd:string">[{&quot;id&quot;:&quot;sbeoc-principalrace-variables-local&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-PrincipalRace-Context&quot;,&quot;valueSource&quot;:&quot;&quot;,&quot;transformationFormula&quot;:&quot;fn:SET_VAR([\&quot;sbaRace\&quot;;./connectedAccounts/Accounts/connectedTo/Contacts/Contact/properties/nSBA__Race__c/text()]);fn:SET_VAR([\&quot;isIndividual\&quot;;fn:BASIC_IF_THEN([./connectedAccounts/Accounts/connectedTo/properties/nSBA__SBA_Is_Individual__c/text();\&quot;true\&quot;;fn:TRUE();fn:FALSE()])]);fn:SET_VAR([\&quot;actionInsert\&quot;;\&quot;insert\&quot;]);fn:SET_VAR([\&quot;actionUpdate\&quot;;\&quot;update\&quot;]);&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:true,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:0},{&quot;id&quot;:&quot;sba-principalrace-attribute&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/PrincipalRace[a:action]&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-PrincipalRace-Context&quot;,&quot;valueSource&quot;:&quot;&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:true,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[{&quot;key&quot;:&quot;action&quot;,&quot;value&quot;:&quot;&quot;,&quot;valueSource&quot;:&quot;$actionInsert;&quot;,&quot;inheritDataSource&quot;:false,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-PrincipalRace-Context&quot;,&quot;finalKeyName&quot;:null}],&quot;placementOrder&quot;:1},{&quot;id&quot;:&quot;sbeoc-principalrace-businesspersonind&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/PrincipalRace/BusinessPersonInd&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-PrincipalRace-Context&quot;,&quot;valueSource&quot;:&quot;fn:BASIC_IF_THEN([$isIndividual;fn:TRUE();\&quot;P\&quot;;\&quot;B\&quot;])&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:true,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:2},{&quot;id&quot;:&quot;sbeoc-principalrace-racecd&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/PrincipalRace/RaceCd&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-PrincipalRace-Context&quot;,&quot;valueSource&quot;:&quot;fn:BASIC_IF_THEN([$isIndividual;fn:TRUE();fn:BASIC_IF_THEN([fn:ISEMPTY([$sbaRace]);fn:FALSE();$sbaRace;\&quot;6\&quot;]);\&quot;6\&quot;])&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:true,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:3},{&quot;id&quot;:&quot;sbeoc-principalrace-taxid&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/PrincipalRace/TaxId&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-PrincipalRace-Context&quot;,&quot;valueSource&quot;:&quot;del:nSBA.SBATaxIdNormalizer([fn:BASIC_IF_THEN([$isIndividual;fn:TRUE();fn:BASIC_IF_THEN([fn:ISEMPTY([./connectedAccounts/Accounts/connectedTo/Contacts/Contact[properties/LLC_BI__Primary_Contact__c=\&quot;true\&quot;]/properties/LLC_BI__SS_PE__c/text()]);fn:TRUE();./connectedAccounts/Accounts/connectedTo/Contacts/Contact[properties/LLC_BI__Primary_Contact__c=\&quot;true\&quot;]/properties/LLC_BI__SS__c/text();./connectedAccounts/Accounts/connectedTo/Contacts/Contact[properties/LLC_BI__Primary_Contact__c=\&quot;true\&quot;]/properties/LLC_BI__SS_PE__c/text())];  fn:BASIC_IF_THEN([fn:ISEMPTY([./connectedAccounts/Accounts/connectedTo/properties/LLC_BI__Tax_Identification_Number_PE__c/text()]);fn:TRUE();./connectedAccounts/Accounts/connectedTo/properties/LLC_BI__Tax_Identification_Number__c/text();./connectedAccounts/Accounts/connectedTo/properties/LLC_BI__Tax_Identification_Number_PE__c/text()])])])&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:true,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:4}]</value>
    </values>
    <values>
        <field>MTRNS__Context__c</field>
        <value xsi:type="xsd:string">Loan</value>
    </values>
    <values>
        <field>MTRNS__Differentiator__c</field>
        <value xsi:type="xsd:string">SBA PrincipalRace</value>
    </values>
    <values>
        <field>MTRNS__InstructionType__c</field>
        <value xsi:type="xsd:string">OBJ2XML</value>
    </values>
    <values>
        <field>MTRNS__Is_Active__c</field>
        <value xsi:type="xsd:boolean">true</value>
    </values>
    <values>
        <field>MTRNS__PackageName__c</field>
        <value xsi:type="xsd:string">Small Business</value>
    </values>
    <values>
        <field>MTRNS__ProcessingOrder__c</field>
        <value xsi:type="xsd:double">1.0</value>
    </values>
    <values>
        <field>MTRNS__SelectorKey__c</field>
        <value xsi:type="xsd:string">ncino-733640fbe24bf20f9ba8792b8e291b59</value>
    </values>
    <values>
        <field>MTRNS__SubContext__c</field>
        <value xsi:type="xsd:string">LoanMapping-PrincipalRace</value>
    </values>
</CustomMetadata>
