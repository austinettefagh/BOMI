<?xml version="1.0" encoding="UTF-8"?>
<CustomMetadata xmlns="http://soap.sforce.com/2006/04/metadata" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    <label>SBA Injection</label>
    <protected>false</protected>
    <values>
        <field>MTRNS__Category__c</field>
        <value xsi:type="xsd:string">SBEOC</value>
    </values>
    <values>
        <field>MTRNS__CompiledInstructions__c</field>
        <value xsi:type="xsd:string">[{&quot;id&quot;:&quot;sbeoc-injection-variables-local&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-Injection-Context&quot;,&quot;valueSource&quot;:&quot;&quot;,&quot;transformationFormula&quot;:&quot;fn:SET_VAR([\&quot;isInjection\&quot;;fn:BASIC_IF_THEN([./nSBA__Injections__c/properties/nSBA__Injection_Type_Code__c/text();\&quot;\&quot;;fn:FALSE();fn:BASIC_IF_THEN([./nSBA__Injections__c/properties/nSBA__Injection_Type_Code__c/text();\&quot;6\&quot;;fn:FALSE();fn:TRUE()])])]);fn:SET_VAR([\&quot;actionInsert\&quot;;\&quot;insert\&quot;]);fn:SET_VAR([\&quot;actionUpdate\&quot;;\&quot;update\&quot;]);fn:SET_VAR([\&quot;injectionCode\&quot;;del:MTRNS.SwitchFn_v1([./nSBA__Injections__c/properties/nSBA__Injection_Type_Code__c/text();\&quot;1=A\&quot;;\&quot;2=C\&quot;;\&quot;3=D\&quot;;\&quot;4=G\&quot;;\&quot;5=O\&quot;;\&quot;66=S\&quot;;\&quot;7=F\&quot;;\&quot;8=P\&quot;;\&quot;=\&quot;])])fn:SET_VAR([\&quot;injectionAction\&quot;;fn:BASIC_IF_THEN([fn:IFEXISTS([fn:CONCAT([\&quot;/SBA_ETran/App/PrimaryKeys/Injection-\&quot;;$injectionCode;\&quot;/\&quot;]);\&quot;dataSource\&quot;;\&quot;extract\&quot;]);fn:TRUE();$actionUpdate;$actionInsert])]);&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:0},{&quot;id&quot;:&quot;sba-injection-attribute&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/Injection[a:action]&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;&quot;,&quot;stateSourceKey&quot;:&quot;&quot;,&quot;valueSource&quot;:&quot;&quot;,&quot;transformationFormula&quot;:&quot;fn:ACTIVE_IF([$isInjection;fn:TRUE()])&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[{&quot;key&quot;:&quot;action&quot;,&quot;value&quot;:&quot;&quot;,&quot;valueSource&quot;:&quot;$injectionAction&quot;,&quot;inheritDataSource&quot;:false,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;extract&quot;,&quot;finalKeyName&quot;:null}],&quot;placementOrder&quot;:1},{&quot;id&quot;:&quot;sbeoc-injection-injctnamt&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/Injection/InjctnAmt&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-Injection-Context&quot;,&quot;valueSource&quot;:&quot;del:nSBA.SBACurrencyNormalizer(./nSBA__Injections__c/properties/nSBA__Injection_Amount__c/text())&quot;,&quot;transformationFormula&quot;:&quot;fn:ACTIVE_IF([$isInjection;fn:TRUE()])&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:2},{&quot;id&quot;:&quot;sbeoc-injection-injctnothdesctxt&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/Injection/InjctnOthDescTxt&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-Injection-Context&quot;,&quot;valueSource&quot;:&quot;./nSBA__Injections__c/properties/nSBA__Injection_Other_Description__c/text()&quot;,&quot;transformationFormula&quot;:&quot;fn:ACTIVE_IF([fn:CONTAINS([(./nSBA__Injections__c/properties/nSBA__Injection_Type_Code__c/text(); \&quot;5\&quot;]);fn:TRUE()])&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:3},{&quot;id&quot;:&quot;sbeoc-injection-injctntermnotlessthanyrnmb&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/Injection/InjctnTermNotLessThanYrNmb&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-Injection-Context&quot;,&quot;valueSource&quot;:&quot;del:MTRNS.ResolveFn_v1([\&quot;dataSource\&quot;;\&quot;loans\&quot;;\&quot;./Loans/LLC_BI__Loan__c/Applications/LLC_BI__Application__c/properties/nSBA__Subordinate_Funding_Term_In_Years__c/text()\&quot; ])&quot;,&quot;transformationFormula&quot;:&quot;fn:ACTIVE_IF([del:MTRNS.SwitchFn_v1([./nSBA__Injections__c/properties/nSBA__Injection_Type_Code__c/text();\&quot;3,5=true\&quot;;\&quot;=false\&quot;]);\&quot;true\&quot;])&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:4},{&quot;id&quot;:&quot;sbeoc-injection-injctntypcd&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/Injection/InjctnTypCd&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-Injection-Context&quot;,&quot;valueSource&quot;:&quot;$injectionCode&quot;,&quot;transformationFormula&quot;:&quot;fn:ACTIVE_IF([$isInjection;fn:TRUE()])&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:5}]</value>
    </values>
    <values>
        <field>MTRNS__Context__c</field>
        <value xsi:type="xsd:string">Loan</value>
    </values>
    <values>
        <field>MTRNS__Differentiator__c</field>
        <value xsi:type="xsd:string">SBA Injection</value>
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
        <value xsi:type="xsd:string">ncino-578901830d4a902a3ed806e481413514</value>
    </values>
    <values>
        <field>MTRNS__SubContext__c</field>
        <value xsi:type="xsd:string">LoanMapping-Injection</value>
    </values>
</CustomMetadata>
