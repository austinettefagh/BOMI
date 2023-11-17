<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Adverse_Action_Set_Loan_Flag_to_1</fullName>
        <field>LLC_BI__Loan_Flag__c</field>
        <formula>1</formula>
        <name>Adverse Action - Set Loan Flag to &quot;1&quot;</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Adverse_Action_Set_Status_to_Declined</fullName>
        <field>AA_Status__c</field>
        <literalValue>Loan Declined</literalValue>
        <name>Adverse Action - Set Status to Declined</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Adverse_Action_Set_Status_to_Recalled</fullName>
        <field>AA_Status__c</field>
        <literalValue>Recalled</literalValue>
        <name>Adverse Action - Set Status to Recalled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Adverse_Action_Set_Status_to_Rejected</fullName>
        <field>AA_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Adverse Action - Set Status to Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Adverse_Action_Set_Status_to_Under_Rev</fullName>
        <description>When the &apos;Decline Loan&apos; button is pressed, update the AA Status to Under Review</description>
        <field>AA_Status__c</field>
        <literalValue>Under Review</literalValue>
        <name>Adverse Action - Set Status to Under Rev</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
</Workflow>
