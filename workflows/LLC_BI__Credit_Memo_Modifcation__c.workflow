<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>LLC_BI__Alert_Credit_Memo_Mod_has_been_approved</fullName>
        <ccEmails>trialforce@bankr.com</ccEmails>
        <description>Alert Credit Memo Mod has been approved</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>LLC_BI__Bankr_Templates/LLC_BI__Credit_Memo_Mod_Approved</template>
    </alerts>
    <fieldUpdates>
        <fullName>AStatus_In_Review_with_Pricing_Committee</fullName>
        <field>LLC_BI__Approval_Status__c</field>
        <literalValue>In Review with Pricing Committee</literalValue>
        <name>AStatus In Review with Pricing Committee</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Memo_Set_Status_to_Recalled</fullName>
        <field>LLC_BI__Approval_Status__c</field>
        <literalValue>Recalled</literalValue>
        <name>Change Memo - Set Status to Recalled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>LLC_BI__Update_Approval_Status_Field_Approved</fullName>
        <field>LLC_BI__Approval_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Update Approval Status Field To Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>LLC_BI__Update_Approval_Status_Field_Rejected</fullName>
        <field>LLC_BI__Approval_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Update Approval Status Field To Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>LLC_BI__Update_Approval_Status_Field_Review</fullName>
        <field>LLC_BI__Approval_Status__c</field>
        <literalValue>In Review</literalValue>
        <name>Update Approval Status Field In Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Approval_Status</fullName>
        <field>LLC_BI__Approval_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Update Approval Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>LLC_BI__Notify Credit Memo Mod Approved</fullName>
        <actions>
            <name>LLC_BI__Alert_Credit_Memo_Mod_has_been_approved</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>LLC_BI__Credit_Memo_Modifcation__c.LLC_BI__Approval_Status__c</field>
            <operation>equals</operation>
            <value>Approved</value>
        </criteriaItems>
        <description>--DEPRECATED--general workflow - notify users, roles, etc that a mod has been approved</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
