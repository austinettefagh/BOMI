<?xml version="1.0" encoding="UTF-8"?>
<CustomMetadata xmlns="http://soap.sforce.com/2006/04/metadata" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    <label>--Deprecated-- SBEOC Loan Officer Info</label>
    <protected>false</protected>
    <values>
        <field>MTRNS__Category__c</field>
        <value xsi:type="xsd:string">SBEOC</value>
    </values>
    <values>
        <field>MTRNS__CompiledInstructions__c</field>
        <value xsi:type="xsd:string">[{&quot;id&quot;:&quot;sbeoc-loanOfficerInfo-email&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/Email&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;loans&quot;,&quot;valueSource&quot;:&quot;fn:REQUIRED([./Loans/LLC_BI__Loan__c/Users/LLC_BI__Loan_Officer__c/properties/Email/text()];\&quot;Missing Loan Officer email\&quot;])&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:true,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:0}]</value>
    </values>
    <values>
        <field>MTRNS__Context__c</field>
        <value xsi:type="xsd:string">Loan</value>
    </values>
    <values>
        <field>MTRNS__Differentiator__c</field>
        <value xsi:type="xsd:string">SBEOC Loan Officer Info</value>
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
        <value xsi:type="xsd:string">SBEOC ETran Integration</value>
    </values>
    <values>
        <field>MTRNS__ProcessingOrder__c</field>
        <value xsi:type="xsd:double">1.0</value>
    </values>
    <values>
        <field>MTRNS__SelectorKey__c</field>
        <value xsi:type="xsd:string">ncino-4679a44db17182542666b13a0e7cdcc8</value>
    </values>
    <values>
        <field>MTRNS__SubContext__c</field>
        <value xsi:type="xsd:string">TxnMapping-LoanOfficerInfo</value>
    </values>
</CustomMetadata>
