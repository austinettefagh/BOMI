<?xml version="1.0" encoding="UTF-8"?>
<CustomMetadata xmlns="http://soap.sforce.com/2006/04/metadata" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    <label>SBA Collateral Liens</label>
    <protected>false</protected>
    <values>
        <field>MTRNS__Category__c</field>
        <value xsi:type="xsd:string">SBEOC</value>
    </values>
    <values>
        <field>MTRNS__CompiledInstructions__c</field>
        <value xsi:type="xsd:string">[{&quot;id&quot;:&quot;sbeoc-collateralliens-variables-local&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-CollateralLiens-Context&quot;,&quot;valueSource&quot;:&quot;&quot;,&quot;transformationFormula&quot;:&quot;fn:SET_VAR([\&quot;isLienActive\&quot;;fn:BASIC_IF_THEN([./lien/properties/LLC_BI__Active__c/text();\&quot;true\&quot;;fn:TRUE();fn:FALSE()])]);fn:SET_VAR([\&quot;actionInsert\&quot;;\&quot;insert\&quot;])fn:SET_VAR([\&quot;actionUpdate\&quot;;\&quot;update\&quot;]);fn:SET_VAR([\&quot;collateralSequenceNumber\&quot;;del:MTRNS.ResolveFn_v1([\&quot;dataSource\&quot;;\&quot;loans\&quot;;fn:CONCAT([\&quot;./Loans/LLC_BI__Loan__c/Collaterals/Collateral[Id = \\\&quot;\&quot;;./lien/properties/LLC_BI__Collateral__c/text();\&quot;\\\&quot;]/CollateralSequenceNumber/text()\&quot;])])]);fn:SET_VAR([\&quot;collateralLienPosition\&quot;;del:MTRNS.SwitchFn_v1([./lien/properties/LLC_BI__Position__c/text();\&quot;1st=1\&quot;;\&quot;2nd=2\&quot;;\&quot;3rd=3\&quot;;\&quot;=\&quot;])]);fn:SET_VAR([\&quot;collateralLienAction\&quot;;fn:BASIC_IF_THEN([fn:IFEXISTS([fn:CONCAT([\&quot;/SBA_ETran/App/PrimaryKeys/CollateralLiens-\&quot;;$collateralSequenceNumber;\&quot;-\&quot;;$collateralLienPosition\&quot;/\&quot;]);\&quot;dataSource\&quot;;\&quot;extract\&quot;]);fn:TRUE();$actionUpdate;$actionInsert])])&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:0},{&quot;id&quot;:&quot;sba-collateralliens-attribute&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/CollateralLiens[a:action]&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;&quot;,&quot;stateSourceKey&quot;:&quot;&quot;,&quot;valueSource&quot;:&quot;&quot;,&quot;transformationFormula&quot;:&quot;fn:ACTIVE_IF([$isLienActive; fn:TRUE()])&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[{&quot;key&quot;:&quot;action&quot;,&quot;value&quot;:&quot;&quot;,&quot;valueSource&quot;:&quot;$collateralLienAction&quot;,&quot;inheritDataSource&quot;:false,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;extract&quot;,&quot;finalKeyName&quot;:null}],&quot;placementOrder&quot;:1},{&quot;id&quot;:&quot;sbeoc-collateralliens-collateralsequencenmb&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/CollateralLiens/CollateralSequenceNmb&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-CollateralLiens-Context&quot;,&quot;valueSource&quot;:&quot;$collateralSequenceNumber&quot;,&quot;transformationFormula&quot;:&quot;fn:ACTIVE_IF([$isLienActive; fn:TRUE()])&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:2},{&quot;id&quot;:&quot;sbeoc-collateralliens-lienbalanceamt&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/CollateralLiens/LienBalanceAmt&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-CollateralLiens-Context&quot;,&quot;valueSource&quot;:&quot;del:nSBA.SBACurrencyNormalizer(./lien/properties/LLC_BI__Amount__c/text())&quot;,&quot;transformationFormula&quot;:&quot;fn:ACTIVE_IF([$isLienActive; fn:TRUE()])&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:3},{&quot;id&quot;:&quot;sbeoc-collateralliens-lienhldrname&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/CollateralLiens/LienHldrName&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-CollateralLiens-Context&quot;,&quot;valueSource&quot;:&quot;./lien/properties/LLC_BI__Institution__c/text()&quot;,&quot;transformationFormula&quot;:&quot;fn:ACTIVE_IF([$isLienActive; fn:TRUE()])&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:4},{&quot;id&quot;:&quot;sbeoc-collateralliens-lienposition&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/CollateralLiens/LienPosition&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-CollateralLiens-Context&quot;,&quot;valueSource&quot;:&quot;$collateralLienPosition&quot;,&quot;transformationFormula&quot;:&quot;fn:ACTIVE_IF([$isLienActive; fn:TRUE()])&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:5},{&quot;id&quot;:&quot;sbeoc-collateralliens-liensequencenmb&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/CollateralLiens/LienSequenceNmb&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-CollateralLiens-Context&quot;,&quot;valueSource&quot;:&quot;$collateralLienPosition&quot;,&quot;transformationFormula&quot;:&quot;fn:ACTIVE_IF([$isLienActive; fn:TRUE()])&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:6}]</value>
    </values>
    <values>
        <field>MTRNS__Context__c</field>
        <value xsi:type="xsd:string">Loan</value>
    </values>
    <values>
        <field>MTRNS__Differentiator__c</field>
        <value xsi:type="xsd:string">SBA Collateral Liens</value>
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
        <value xsi:type="xsd:string">ncino-84dd7f302ce9f0099496b75f6f12fd70</value>
    </values>
    <values>
        <field>MTRNS__SubContext__c</field>
        <value xsi:type="xsd:string">LoanMapping-CollateralLiens</value>
    </values>
</CustomMetadata>
