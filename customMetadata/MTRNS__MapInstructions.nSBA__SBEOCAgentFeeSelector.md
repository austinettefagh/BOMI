<?xml version="1.0" encoding="UTF-8"?>
<CustomMetadata xmlns="http://soap.sforce.com/2006/04/metadata" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    <label>SBA AgentFee</label>
    <protected>false</protected>
    <values>
        <field>MTRNS__Category__c</field>
        <value xsi:type="xsd:string">SBEOC</value>
    </values>
    <values>
        <field>MTRNS__CompiledInstructions__c</field>
        <value xsi:type="xsd:string">[{&quot;id&quot;:&quot;sbeoc-agentfee-variables-local&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-AgentFee-Context&quot;,&quot;valueSource&quot;:&quot;&quot;,&quot;transformationFormula&quot;:&quot;fn:SET_VAR([\&quot;isStatusActive\&quot;;fn:BASIC_IF_THEN([./fees/properties/LLC_BI__Status__c/text();\&quot;Active\&quot;;fn:TRUE();fn:FALSE()]) ]);fn:SET_VAR([\&quot;actionInsert\&quot;;\&quot;insert\&quot;]);fn:SET_VAR([\&quot;actionUpdate\&quot;;\&quot;update\&quot;]);fn:SET_VAR([\&quot;agentSequenceNumber\&quot;;del:nSBA.SBAAutoNumberFn([./fees/FeePayableTo/Name/text()])]);fn:SET_VAR([\&quot;agentServiceTypeCode\&quot;;del:MTRNS.SwitchFn_v1([./fees/properties/LLC_BI__Fee_Type__c/text();\&quot;Loan packaging=1\&quot;;\&quot;Financial statement preparation=2\&quot;;\&quot;Broker or Referral services=3\&quot;;\&quot;Consultant services=4\&quot;;\&quot;=5\&quot;])])fn:SET_VAR([\&quot;agentFeeAction\&quot;;fn:BASIC_IF_THEN([fn:IFEXISTS([fn:CONCAT([\&quot;/SBA_ETran/App/PrimaryKeys/AgentFee-\&quot;;$agentSequenceNumber;\&quot;-\&quot;;$agentServiceTypeCode;\&quot;/\&quot;]);\&quot;dataSource\&quot;;\&quot;extract\&quot;]);fn:TRUE();$actionUpdate;$actionInsert])])&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:0},{&quot;id&quot;:&quot;sba-agentfee-attribute&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/AgentFee[a:action]&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;&quot;,&quot;stateSourceKey&quot;:&quot;&quot;,&quot;valueSource&quot;:&quot;&quot;,&quot;transformationFormula&quot;:&quot;fn:ACTIVE_IF([$isStatusActive; fn:TRUE()])&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[{&quot;key&quot;:&quot;action&quot;,&quot;value&quot;:&quot;&quot;,&quot;valueSource&quot;:&quot;$agentFeeAction&quot;,&quot;inheritDataSource&quot;:false,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;loans&quot;,&quot;finalKeyName&quot;:null}],&quot;placementOrder&quot;:1},{&quot;id&quot;:&quot;sbeoc-agentfee-loanagentappcntpaidamt&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/AgentFee/LoanAgentAppCNTPaidAmt&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-AgentFee-Context&quot;,&quot;valueSource&quot;:&quot;del:nSBA.SBACurrencyNormalizer(./fees/properties/PaidByBorrower/text())&quot;,&quot;transformationFormula&quot;:&quot;fn:ACTIVE_IF([$isStatusActive; fn:TRUE()])&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:2},{&quot;id&quot;:&quot;sbeoc-agentfee-loanagentsbalenderpaidamt&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/AgentFee/LoanAgentSbaLenderPaidAmt&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-AgentFee-Context&quot;,&quot;valueSource&quot;:&quot;del:nSBA.SBACurrencyNormalizer(./fees/properties/PaidByLender/text())&quot;,&quot;transformationFormula&quot;:&quot;fn:ACTIVE_IF([$isStatusActive; fn:TRUE()])&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:3},{&quot;id&quot;:&quot;sbeoc-agentfee-LoanAgentSeqNmb&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/AgentFee/LoanAgentSeqNmb&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-AgentFee-Context&quot;,&quot;valueSource&quot;:&quot;$agentSequenceNumber&quot;,&quot;transformationFormula&quot;:&quot;fn:ACTIVE_IF([$isStatusActive; fn:TRUE()])&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:4},{&quot;id&quot;:&quot;sbeoc-agentfee-loanagentservtypcd&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/AgentFee/LoanAgentServTypCd&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-AgentFee-Context&quot;,&quot;valueSource&quot;:&quot;$agentServiceTypeCode&quot;,&quot;transformationFormula&quot;:&quot;fn:ACTIVE_IF([$isStatusActive; fn:TRUE()])&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:5},{&quot;id&quot;:&quot;sbeoc-agentfee-loanagntservothertype&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/AgentFee/LoanAgntServOtherType&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-AgentFee-Context&quot;,&quot;valueSource&quot;:&quot;fn:TRUNCATE([./fees/properties/LLC_BI__Fee_Type_Description__c/text();\&quot;80\&quot;])&quot;,&quot;transformationFormula&quot;:&quot;fn:ACTIVE_IF([$isStatusActive; fn:TRUE()])&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:6}]</value>
    </values>
    <values>
        <field>MTRNS__Context__c</field>
        <value xsi:type="xsd:string">Loan</value>
    </values>
    <values>
        <field>MTRNS__Differentiator__c</field>
        <value xsi:type="xsd:string">SBA AgentFee</value>
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
        <value xsi:type="xsd:string">ncino-145ddef2707e3ee2f828ac6389ef145d</value>
    </values>
    <values>
        <field>MTRNS__SubContext__c</field>
        <value xsi:type="xsd:string">LoanMapping-AgentFee</value>
    </values>
</CustomMetadata>
