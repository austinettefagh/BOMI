<?xml version="1.0" encoding="UTF-8"?>
<CustomMetadata xmlns="http://soap.sforce.com/2006/04/metadata" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    <label>--Deprecated-- SBEOC Interest Rate Optio</label>
    <protected>false</protected>
    <values>
        <field>MTRNS__Category__c</field>
        <value xsi:type="xsd:string">SBEOC</value>
    </values>
    <values>
        <field>MTRNS__CompiledInstructions__c</field>
        <value xsi:type="xsd:string">[{&quot;id&quot;:&quot;sbeoc-interestRateOptions-pricing-basis&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/SBA_ETran[a:version]/App/LoanApplication[a:action]/PricingBasis&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;loans&quot;,&quot;valueSource&quot;:&quot;./Loans/LLC_BI__Loan__c/properties/LLC_BI__Pricing_Basis__c/text()&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:true,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[{&quot;key&quot;:&quot;version&quot;,&quot;value&quot;:&quot;7.1&quot;,&quot;valueSource&quot;:&quot;&quot;,&quot;inheritDataSource&quot;:true,&quot;stateSource&quot;:&quot;&quot;,&quot;stateSourceKey&quot;:&quot;&quot;,&quot;finalKeyName&quot;:null},{&quot;key&quot;:&quot;action&quot;,&quot;value&quot;:&quot;insert&quot;,&quot;valueSource&quot;:&quot;&quot;,&quot;inheritDataSource&quot;:true,&quot;stateSource&quot;:&quot;&quot;,&quot;stateSourceKey&quot;:&quot;&quot;,&quot;finalKeyName&quot;:null}],&quot;placementOrder&quot;:0},{&quot;id&quot;:&quot;sbeoc-interestRateOptions-index&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/SBA_ETran/App/LoanApplication/SBA-Index&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;loans&quot;,&quot;valueSource&quot;:&quot;./Loans/LLC_BI__Loan__c/properties/LLC_BI__Index__c/text()&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:true,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:1},{&quot;id&quot;:&quot;sbeoc-interestRateOptions-interestRate&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/SBA_ETran/App/LoanApplication/SBA-interestRate&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;loans&quot;,&quot;valueSource&quot;:&quot;fn:BASIC_IF_THEN([./Loans/LLC_BI__Loan__c/properties/LLC_BI__Pricing_Basis__c/text();\&quot;Fixed\&quot;;\&quot;6.666\&quot;;./Loans/LLC_BI__Loan__c/properties/LLC_BI__InterestRate__c/text()])&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:true,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:2},{&quot;id&quot;:&quot;sbeoc-interestRateOptions-rate-ceiling&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/SBA_ETran/App/LoanApplication/SBA-rate-ceiling&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;loans&quot;,&quot;valueSource&quot;:&quot;./Loans/LLC_BI__Loan__c/properties/LLC_BI__Rate_Ceiling__c/text()&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:true,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:3},{&quot;id&quot;:&quot;sbeoc-interestRateOptions-spread&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/SBA_ETran/App/LoanApplication/SBA-spread&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;loans&quot;,&quot;valueSource&quot;:&quot;del:MTRNS.SwitchFn_v1([./Loans/LLC_BI__Loan__c/properties/LLC_BI__Pricing_Basis__c/text();\&quot;Fixed=1\&quot;;\&quot;Floating=2\&quot;;\&quot;Variable=3\&quot;;\&quot;=4\&quot;])&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:true,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:4},{&quot;id&quot;:&quot;sbeoc-interestRateOptions-rateFloor&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/SBA_ETran/App/LoanApplication/SBA-rateFloor&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;loans&quot;,&quot;valueSource&quot;:&quot;fn:REQUIRED([./Loans/LLC_BI__Loan__c/properties/LLC_BI__Rate_Floor__c/text()];\&quot;Missing rate floor\&quot;])&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:true,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:5}]</value>
    </values>
    <values>
        <field>MTRNS__Context__c</field>
        <value xsi:type="xsd:string">Loan</value>
    </values>
    <values>
        <field>MTRNS__Differentiator__c</field>
        <value xsi:type="xsd:string">SBEOC Interest Rate Options</value>
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
        <value xsi:type="xsd:string">ncino-f8643cb09edb4b757d38265ad9ea6e7b</value>
    </values>
    <values>
        <field>MTRNS__SubContext__c</field>
        <value xsi:type="xsd:string">TxnMapping-InterestRateOptions</value>
    </values>
</CustomMetadata>
