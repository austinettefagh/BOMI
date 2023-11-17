<?xml version="1.0" encoding="UTF-8"?>
<CustomMetadata xmlns="http://soap.sforce.com/2006/04/metadata" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    <label>SBA LoanApplication</label>
    <protected>false</protected>
    <values>
        <field>MTRNS__Category__c</field>
        <value xsi:type="xsd:string">SBEOC</value>
    </values>
    <values>
        <field>MTRNS__CompiledInstructions__c</field>
        <value xsi:type="xsd:string">[{&quot;id&quot;:&quot;sbeoc-loanapplication-businessagecd&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/BusinessAgeCd&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-LoanApplication-Context&quot;,&quot;valueSource&quot;:&quot;fn:SET_VAR([\&quot;BusinessAge\&quot;;./Loans/LLC_BI__Loan__c/Account/properties/nSBA__Business_Age__c/text()]);fn:SET_VAR([\&quot;DateOfEstablishment\&quot;;./Loans/LLC_BI__Loan__c/Account/properties/nSBA__Date_Of_Establishment__c/text()]);fn:BASIC_IF_THEN([fn:ISEMPTY([$BusinessAge]);fn:FALSE();$BusinessAge;fn:BASIC_IF_THEN([fn:ISEMPTY([$DateOfEstablishment]);fn:TRUE();\&quot;0\&quot;;fn:BASIC_IF_THEN([del:nSBA.SBADateComparison([\&quot;lte\&quot;;fn:NOW();del:nSBA.SBAAddYearsToDate([$DateOfEstablishment;\&quot;2\&quot;])]);fn:TRUE();\&quot;7\&quot;;\&quot;8\&quot;])])])&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:0},{&quot;id&quot;:&quot;sbeoc-loanapplication-variables-local2&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;extract&quot;,&quot;valueSource&quot;:&quot;&quot;,&quot;transformationFormula&quot;:&quot;fn:SET_VAR([\&quot;isUpdate\&quot;;fn:BASIC_IF_THEN(fn:COUNT_NODES([/SBA_ETran/App]);fn:CEIL(\&quot;0\&quot;);fn:FALSE();fn:TRUE())&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:1},{&quot;id&quot;:&quot;sbeoc-loanapplication-collateralind&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/CollateralInd&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-LoanApplication-Context&quot;,&quot;valueSource&quot;:&quot;del:nSBA.SBAHasCollateralFn(./Loans/LLC_BI__Loan__c/Collaterals/Collateral;\&quot;./CollateralSequenceNumber\&quot;)&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:2},{&quot;id&quot;:&quot;sbeoc-loanapplication-currempqty&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/CurrEmpQty&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-LoanApplication-Context&quot;,&quot;valueSource&quot;:&quot;./Loans/LLC_BI__Loan__c/Applications/LLC_BI__Application__c[1]/properties/nSBA__SBA_Number_Of_Employees__c/text()&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:3},{&quot;id&quot;:&quot;sbeoc-loanapplication-eligpassivecompanyind&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/EligPassiveCompanyInd&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-LoanApplication-Context&quot;,&quot;valueSource&quot;:&quot;fn:BASIC_IF_THEN([fn:LISTCONTAINS([\&quot;EPC\&quot;;./Loans/LLC_BI__Loan__c/Borrowers/LLC_BI__Legal_Entities__c/properties/LLC_BI__Entity_Type__c/text-list()]);fn:TRUE();\&quot;Y\&quot;;\&quot;N\&quot;])&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:4},{&quot;id&quot;:&quot;sbeoc-loanapplication-frnchiseind&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/FrnchiseInd&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-LoanApplication-Context&quot;,&quot;valueSource&quot;:&quot;fn:BASIC_IF_THEN([fn:ISEMPTY([fn:BLANKVALUE([./Loans/LLC_BI__Loan__c/Account/properties/nSBA__Franchise_Code__c/text();./Loans/LLC_BI__Loan__c/Account/properties/nSBA__Franchise_Name__c/text()])]);fn:FALSE();\&quot;Y\&quot;;\&quot;N\&quot;])&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:5},{&quot;id&quot;:&quot;sbeoc-loanapplication-fullamortpymtind&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/FullAmortPymtInd&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-LoanApplication-Context&quot;,&quot;valueSource&quot;:&quot;fn:BASIC_IF_THEN([./Loans/LLC_BI__Loan__c/properties/LLC_BI__Payment_Type__c/text();\&quot;Principal+Interest\&quot;;\&quot;Y\&quot;;\&quot;N\&quot;])&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:6},{&quot;id&quot;:&quot;sbeoc-loanapplication-intereststructurecd&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/InterestStructureCd&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-LoanApplication-Context&quot;,&quot;valueSource&quot;:&quot;fn:BASIC_IF_THEN([fn:MATCHES([./Loans/LLC_BI__Loan__c/properties/LLC_BI__Pricing_Basis__c/text();\&quot;Fixed\&quot;]);fn:TRUE();\&quot;F\&quot;;fn:BASIC_IF_THEN([fn:MATCHES([./Loans/LLC_BI__Loan__c/properties/LLC_BI__Pricing_Basis__c/text();\&quot;Variable\&quot;]);fn:TRUE();\&quot;V\&quot;;fn:BASIC_IF_THEN([fn:MATCHES([./Loans/LLC_BI__Loan__c/properties/LLC_BI__Pricing_Basis__c/text();\&quot;Float\&quot;]);fn:TRUE();\&quot;V\&quot;;\&quot;\&quot;])])])&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:7},{&quot;id&quot;:&quot;sbeoc-loanapplication-injectionind&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/InjectionInd&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-LoanApplication-Context&quot;,&quot;valueSource&quot;:&quot;fn:BASIC_IF_THEN([./Loans/LLC_BI__Loan__c/Applications/LLC_BI__Application__c/properties/nSBA__Injection_Indication__c/text();\&quot;true\&quot;;\&quot;Y\&quot;;fn:BASIC_IF_THEN([fn:COUNT_NODES(./Loans/LLC_BI__Loan__c/Applications/LLC_BI__Application__c/Injections/);fn:CEIL(\&quot;0\&quot;);\&quot;N\&quot;;\&quot;Y\&quot;])])&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:8},{&quot;id&quot;:&quot;sbeoc-loanapplication-jobscreatdqty&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/JobsCreatdQty&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-LoanApplication-Context&quot;,&quot;valueSource&quot;:&quot;./Loans/LLC_BI__Loan__c/Applications/LLC_BI__Application__c[1]/properties/nSBA__Jobs_Created__c/text()&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:9},{&quot;id&quot;:&quot;sbeoc-loanapplication-jobsretaindqty&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/JobsRetaindQty&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-LoanApplication-Context&quot;,&quot;valueSource&quot;:&quot;./Loans/LLC_BI__Loan__c/Applications/LLC_BI__Application__c[1]/properties/nSBA__Jobs_Retained__c/text()&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:10},{&quot;id&quot;:&quot;sbeoc-loanapplication-lenderapplicnmb&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/LenderApplicNmb&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-LoanApplication-Context&quot;,&quot;valueSource&quot;:&quot;./Loans/LLC_BI__Loan__c/Applications/LLC_BI__Application__c[1]/properties/nSBA__Application_Number__c/text()&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:11},{&quot;id&quot;:&quot;sbeoc-loanapplication-lendercntctemail&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/LenderCntctEmail&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-LoanApplication-Context&quot;,&quot;valueSource&quot;:&quot;fn:BASIC_IF_THEN([./Loans/LLC_BI__Loan__c/Users/nSBA__ETran_Lender_Contact__c/properties/Email/text();\&quot;\&quot;;./Loans/LLC_BI__Loan__c/Users/LLC_BI__Loan_Officer__c/properties/Email/text();./Loans/LLC_BI__Loan__c/Users/nSBA__ETran_Lender_Contact__c/properties/Email/text()])&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:12},{&quot;id&quot;:&quot;sbeoc-loanapplication-lendercntctfax&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/LenderCntctFax&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-LoanApplication-Context&quot;,&quot;valueSource&quot;:&quot;del:nSBA.SBAPhoneNumberNormalizer([fn:BASIC_IF_THEN([./Loans/LLC_BI__Loan__c/Users/nSBA__ETran_Lender_Contact__c/properties/Fax/text();\&quot;\&quot;;./Loans/LLC_BI__Loan__c/Users/LLC_BI__Loan_Officer__c/properties/Fax/text();./Loans/LLC_BI__Loan__c/Users/nSBA__ETran_Lender_Contact__c/properties/Fax/text()])])&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:13},{&quot;id&quot;:&quot;sbeoc-loanapplication-lendercntctfirstname&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/LenderCntctFirstName&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-LoanApplication-Context&quot;,&quot;valueSource&quot;:&quot;fn:BASIC_IF_THEN([./Loans/LLC_BI__Loan__c/Users/nSBA__ETran_Lender_Contact__c/properties/FirstName/text();\&quot;\&quot;;./Loans/LLC_BI__Loan__c/Users/LLC_BI__Loan_Officer__c/properties/FirstName/text();./Loans/LLC_BI__Loan__c/Users/nSBA__ETran_Lender_Contact__c/properties/FirstName/text()])&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:14},{&quot;id&quot;:&quot;sbeoc-loanapplication-lendercntctlastname&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/LenderCntctLastName&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-LoanApplication-Context&quot;,&quot;valueSource&quot;:&quot;fn:BASIC_IF_THEN([./Loans/LLC_BI__Loan__c/Users/nSBA__ETran_Lender_Contact__c/properties/LastName/text();\&quot;\&quot;;./Loans/LLC_BI__Loan__c/Users/LLC_BI__Loan_Officer__c/properties/LastName/text();./Loans/LLC_BI__Loan__c/Users/nSBA__ETran_Lender_Contact__c/properties/LastName/text()])&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:15},{&quot;id&quot;:&quot;sbeoc-loanapplication-lendercntctphnnmb&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/LenderCntctPhnNmb&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-LoanApplication-Context&quot;,&quot;valueSource&quot;:&quot;del:nSBA.SBAPhoneNumberNormalizer([fn:BASIC_IF_THEN([./Loans/LLC_BI__Loan__c/Users/nSBA__ETran_Lender_Contact__c/Name/text();\&quot;\&quot;;./Loans/LLC_BI__Loan__c/Users/LLC_BI__Loan_Officer__c/properties/Phone/text();./Loans/LLC_BI__Loan__c/Users/nSBA__ETran_Lender_Contact__c/properties/Phone/text()])])&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:16},{&quot;id&quot;:&quot;sbeoc-loanapplication-lendercntcttitl&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/LenderCntctTitl&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-LoanApplication-Context&quot;,&quot;valueSource&quot;:&quot;fn:BASIC_IF_THEN([./Loans/LLC_BI__Loan__c/Users/nSBA__ETran_Lender_Contact__c/properties/Title/text();\&quot;\&quot;;./Loans/LLC_BI__Loan__c/Users/LLC_BI__Loan_Officer__c/properties/Title/text();./Loans/LLC_BI__Loan__c/Users/nSBA__ETran_Lender_Contact__c/properties/Title/text()])&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:17},{&quot;id&quot;:&quot;sbeoc-loanapplication-lenderloannmb&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/LenderLoanNmb&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-LoanApplication-Context&quot;,&quot;valueSource&quot;:&quot;./Loans/LLC_BI__Loan__c/properties/LLC_BI__lookupKey__c/text()&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:18},{&quot;id&quot;:&quot;sbeoc-loanapplication-loanname&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/LoanName&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-LoanApplication-Context&quot;,&quot;valueSource&quot;:&quot;./Loans/LLC_BI__Loan__c/Name/text()&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:19},{&quot;id&quot;:&quot;sbeoc-loanapplication-underwritingby&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/UnderwritingBy&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-LoanApplication-Context&quot;,&quot;valueSource&quot;:&quot;fn:BASIC_IF_THEN([./Loans/LLC_BI__Loan__c/Applications/LLC_BI__Application__c/properties/nSBA__SBA_Underwriting_Required__c/text();&apos;true&apos;;\&quot;SBA\&quot;;\&quot;\&quot;])&quot;,&quot;transformationFormula&quot;:&quot;fn:ACTIVE_IF([./Loans/LLC_BI__Loan__c/Applications/LLC_BI__Application__c/properties/nSBA__SBA_Underwriting_Required__c/text();\&quot;true\&quot;])&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:20},{&quot;id&quot;:&quot;sbeoc-loanapplication-agentinvolved&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/AgentInvolved&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-LoanApplication-Context&quot;,&quot;valueSource&quot;:&quot;del:nSBA.SBABooleanNormalizer([./Loans/LLC_BI__Loan__c/Applications/LLC_BI__Application__c/properties/nSBA__Is_Agent_Involved__c/text()])&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:21},{&quot;id&quot;:&quot;sbeoc-loanapplication-loantermamortmnths&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/LoanTermAmortMnths&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-LoanApplication-Context&quot;,&quot;valueSource&quot;:&quot;./Loans/LLC_BI__Loan__c/properties/LLC_BI__Amortized_Term_Months__c/text()&quot;,&quot;transformationFormula&quot;:&quot;fn:ACTIVE_IF([fn:BOOL([./Loans/LLC_BI__Loan__c/Products/LLC_BI__Product__c/ProductFeatures/productFeature/properties/LLC_BI__Line_Of_Credit__c/text()]);fn:FALSE()])&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:22},{&quot;id&quot;:&quot;sbeoc-loanapplication-loantermrevlmnths&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/LoanTermRevlMnths&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-LoanApplication-Context&quot;,&quot;valueSource&quot;:&quot;./Loans/LLC_BI__Loan__c/properties/LLC_BI__Amortized_Term_Months__c/text()&quot;,&quot;transformationFormula&quot;:&quot;fn:ACTIVE_IF([./Loans/LLC_BI__Loan__c/Products/LLC_BI__Product__c/ProductFeatures/productFeature/properties/LLC_BI__Line_Of_Credit__c/text();\&quot;true\&quot;])&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:23},{&quot;id&quot;:&quot;sbeoc-loanapplication-loantermmnths&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/LoanTermMnths&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-LoanApplication-Context&quot;,&quot;valueSource&quot;:&quot;./Loans/LLC_BI__Loan__c/properties/LLC_BI__Total_Monthly_Payments__c/text()&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:24},{&quot;id&quot;:&quot;sbeoc-loanapplication-mnthsintrstonlyqty&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/MnthsIntrstOnlyQty&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-LoanApplication-Context&quot;,&quot;valueSource&quot;:&quot;./Loans/LLC_BI__Loan__c/properties/LLC_BI__Interest_Only_Months__c/text()&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:25},{&quot;id&quot;:&quot;sbeoc-loanapplication-naicscd&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/NAICSCd&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-LoanApplication-Context&quot;,&quot;valueSource&quot;:&quot;./Loans/LLC_BI__Loan__c/Account/properties/LLC_BI__Naics_Code__c/text()&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:26},{&quot;id&quot;:&quot;sbeoc-loanapplication-processingmethodcd&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/ProcessingMethodCd&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-LoanApplication-Context&quot;,&quot;valueSource&quot;:&quot;./Loans/LLC_BI__Loan__c/Applications/LLC_BI__Application__c/properties[1]/nSBA__SBA_Processing_Method__c/text()&quot;,&quot;transformationFormula&quot;:&quot;fn:ACTIVE_IF([$isUpdate;fn:FALSE()])&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:27},{&quot;id&quot;:&quot;sbeoc-loanapplication-projectcityname&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/ProjectCityName&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-LoanApplication-Context&quot;,&quot;valueSource&quot;:&quot;./Loans/LLC_BI__Loan__c/Account/properties/BillingCity/text()&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:28},{&quot;id&quot;:&quot;sbeoc-loanapplication-projectstcd&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/ProjectStCd&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-LoanApplication-Context&quot;,&quot;valueSource&quot;:&quot;del:nSBA.SBAStateNormalizer([./Loans/LLC_BI__Loan__c/Account/properties/BillingState/text()])&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:29},{&quot;id&quot;:&quot;sbeoc-loanapplication-projectstrtname1&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/ProjectStrtName1&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-LoanApplication-Context&quot;,&quot;valueSource&quot;:&quot;fn:TRUNCATE([./Loans/LLC_BI__Loan__c/Account/properties/BillingStreet/text();\&quot;80\&quot;])&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:30},{&quot;id&quot;:&quot;sbeoc-loanapplication-projectzipcd&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/ProjectZipCd&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-LoanApplication-Context&quot;,&quot;valueSource&quot;:&quot;del:nSBA.SBAZipCodeNormalizer(./Loans/LLC_BI__Loan__c/Account/properties/BillingPostalCode/text())&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:31},{&quot;id&quot;:&quot;sbeoc-loanapplication-ruralurbanind&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/RuralUrbanInd&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-LoanApplication-Context&quot;,&quot;valueSource&quot;:&quot;./Loans/LLC_BI__Loan__c/Account/properties/nSBA__Rural_Urban_Indicator__c/text()&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:32},{&quot;id&quot;:&quot;sbeoc-loanapplication-pymtamt&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/PymtAmt&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-LoanApplication-Context&quot;,&quot;valueSource&quot;:&quot;./Loans/LLC_BI__Loan__c/properties/LLC_BI__Monthly_Payment__c/text()&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:33},{&quot;id&quot;:&quot;sbeoc-loanapplication-reconsiderationind&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/ReconsiderationInd&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-LoanApplication-Context&quot;,&quot;valueSource&quot;:&quot;del:nSBA.SBABooleanNormalizer(./Loans/LLC_BI__Loan__c/Applications/LLC_BI__Application__c[1]/properties/nSBA__Resubmission__c/text())&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:34},{&quot;id&quot;:&quot;sbeoc-loanapplication-requestedamt&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/RequestedAmt&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-LoanApplication-Context&quot;,&quot;valueSource&quot;:&quot;del:nSBA.SBACustomRoundFn(./Loans/LLC_BI__Loan__c/properties/LLC_BI__Amount__c/text())&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:35},{&quot;id&quot;:&quot;sbeoc-loanapplication-sbagntypct&quot;,&quot;targetDataValueType&quot;:&quot;STRING_TYPE&quot;,&quot;targetPath&quot;:&quot;/root/SBAGntyPct&quot;,&quot;finalTargetPath&quot;:&quot;&quot;,&quot;stateSource&quot;:&quot;dataSource&quot;,&quot;stateSourceKey&quot;:&quot;SBEOC-LoanApplication-Context&quot;,&quot;valueSource&quot;:&quot;del:nSBA.SBAPercentNormalizer([./Loans/LLC_BI__Loan__c/properties/LLC_BI__SBA_Guarantee__c/text()])&quot;,&quot;transformationFormula&quot;:&quot;&quot;,&quot;isActive&quot;:true,&quot;skipTransformationDataValueObtain&quot;:false,&quot;skipValueObtain&quot;:false,&quot;skipAttributeValueObtain&quot;:false,&quot;skipIfBlank&quot;:false,&quot;skipCreatingNewReferences&quot;:false,&quot;useEmptyElementForBlankValue&quot;:false,&quot;attributes&quot;:[],&quot;placementOrder&quot;:36}]</value>
    </values>
    <values>
        <field>MTRNS__Context__c</field>
        <value xsi:type="xsd:string">Loan</value>
    </values>
    <values>
        <field>MTRNS__Differentiator__c</field>
        <value xsi:type="xsd:string">SBA LoanApplication</value>
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
        <value xsi:type="xsd:string">ncino-642220047139921c7387cb6ae3f982aa</value>
    </values>
    <values>
        <field>MTRNS__SubContext__c</field>
        <value xsi:type="xsd:string">LoanMapping-LoanApplication</value>
    </values>
</CustomMetadata>