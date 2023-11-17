<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>CEA_Scenario_Approval_Email_Notification1</fullName>
        <description>Scenario Approval Email Notification1</description>
        <protected>false</protected>
        <recipients>
            <recipient>rpaul@bankofmissouri.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>TBoM_Email_Templates/CE_Proforma_Approval_Email</template>
    </alerts>
    <fieldUpdates>
        <fullName>Update_Date_Approved</fullName>
        <field>Date_Approved__c</field>
        <formula>TODAY()</formula>
        <name>Update Date Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Date_Approved_field</fullName>
        <field>Date_Approved__c</field>
        <formula>TODAY()</formula>
        <name>Update Date Approved field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Date_Submitted_for_Approval</fullName>
        <field>Date_Submitted_For_Approval__c</field>
        <formula>TODAY()</formula>
        <name>Update Date Submitted for Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Date_Submitted_for_Approval_field</fullName>
        <field>Date_Submitted_For_Approval__c</field>
        <formula>TODAY()</formula>
        <name>Update Date Submitted for Approval field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status1</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>Final</literalValue>
        <name>Update Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_field</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>Final</literalValue>
        <name>Update Status field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
</Workflow>
