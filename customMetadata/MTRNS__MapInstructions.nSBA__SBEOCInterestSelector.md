<?xml version="1.0" encoding="UTF-8"?>
<CustomMetadata xmlns="http://soap.sforce.com/2006/04/metadata" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    <label>SBA Interest</label>
    <protected>false</protected>
    <values>
        <field>MTRNS__Category__c</field>
        <value xsi:type="xsd:string">SBEOC</value>
    </values>
    <values>
        <field>MTRNS__CompiledInstructions__c</field>
        <value xsi:type="xsd:string">[{&quot;id&quot;:&quot;sbeoc-interest-adjustperiodcd&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/AdjustPeriodCd&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-Interest-Context&quot;,&quot;valueSource&quot;:&quot;del:MTRNS.SwitchFn_v1([./Loans/LLC_BI__Loan__c/properties/LLC_BI__Interest_Rate_Adjustment_Frequency__c/text();\&quot;Annual=A\&quot;;\&quot;Monthly=M\&quot;;\&quot;Quarterly=Q\&quot;;\&quot;Semi-Annual=S\&quot;;\&quot;=X\&quot;])&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:0},{&quot;id&quot;:&quot;sbeoc-interest-baseintrstratepct&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/BaseIntrstRatePct&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-Interest-Context&quot;,&quot;valueSource&quot;:&quot;del:nSBA.SBAPercentNormalizer([./Loans/LLC_BI__Loan__c/properties/LLC_BI__Index_Value__c/text();\&quot;3\&quot;])&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:1},{&quot;id&quot;:&quot;sbeoc-interest-baseratesourctypcd&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/BaseRateSourcTypCd&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-Interest-Context&quot;,&quot;valueSource&quot;:&quot;del:MTRNS.SwitchFn_v1([./Loans/LLC_BI__Loan__c/properties/LLC_BI__Index__c/text();\&quot;WSJP,WSJ=WSJ\&quot;;\&quot;SBA Optional Peg Rate=SBA\&quot;;\&quot;Fixed Interest,Fixed=FBR\&quot;;\&quot;=\&quot;])&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:2},{&quot;id&quot;:&quot;sbeoc-interest-borrintrstratepct&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/BorrIntrstRatePct&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-Interest-Context&quot;,&quot;valueSource&quot;:&quot;del:nSBA.SBAPercentNormalizer([./Loans/LLC_BI__Loan__c/properties/LLC_BI__InterestRate__c/text();\&quot;3\&quot;])&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:3},{&quot;id&quot;:&quot;sbeoc-interest-firstrateadjustdt&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/FirstRateAdjustDt&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-Interest-Context&quot;,&quot;valueSource&quot;:&quot;del:nSBA.SBADateNormalizer([./Loans/LLC_BI__Loan__c/Applications/LLC_BI__Application__c/properties/nSBA__First_Rate_Adjustment_Date__c/text()])&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:4},{&quot;id&quot;:&quot;sbeoc-interest-intrsttypind&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/IntrstTypInd&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-Interest-Context&quot;,&quot;valueSource&quot;:&quot;fn:BASIC_IF_THEN([fn:MATCHES([./Loans/LLC_BI__Loan__c/properties/LLC_BI__Pricing_Basis__c/text();\&quot;Fixed\&quot;;\&quot;i\&quot;]);fn:TRUE();\&quot;F\&quot;;fn:BASIC_IF_THEN([fn:MATCHES([./Loans/LLC_BI__Loan__c/properties/LLC_BI__Pricing_Basis__c/text();\&quot;Variable\&quot;;\&quot;i\&quot;]);fn:TRUE();\&quot;V\&quot;;fn:BASIC_IF_THEN([fn:MATCHES([./Loans/LLC_BI__Loan__c/properties/LLC_BI__Pricing_Basis__c/text();\&quot;Float\&quot;;\&quot;i\&quot;]);fn:TRUE();\&quot;V\&quot;;\&quot;\&quot;])])])&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:5},{&quot;id&quot;:&quot;sbeoc-interest-phase&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/Phase&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;&quot;,&quot;stateSourceKey&quot;:&quot;&quot;,&quot;valueSource&quot;:&quot;&apos;1&apos;&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:6}]</value>
    </values>
    <values>
        <field>MTRNS__Context__c</field>
        <value xsi:type="xsd:string">Loan</value>
    </values>
    <values>
        <field>MTRNS__Differentiator__c</field>
        <value xsi:type="xsd:string">SBA Interest</value>
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
        <value xsi:type="xsd:string">ncino-ad4c453616d6135ed71b97f69e80925b</value>
    </values>
    <values>
        <field>MTRNS__SubContext__c</field>
        <value xsi:type="xsd:string">LoanMapping-Interest</value>
    </values>
</CustomMetadata>
