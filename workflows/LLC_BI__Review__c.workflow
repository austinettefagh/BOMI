<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>ANN_Approved_Record_Type_Update</fullName>
        <field>RecordTypeId</field>
        <lookupValue>LLC_BI__Account_Review_Complete</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>ANN Approved Record Type Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ANN_Recalled_Record_Type_Update</fullName>
        <field>RecordTypeId</field>
        <lookupValue>LLC_BI__Account_Review_In_Progress</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>ANN Recalled Record Type Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ANN_Rejected_Record_Type_Update</fullName>
        <field>RecordTypeId</field>
        <lookupValue>LLC_BI__Account_Review_In_Progress</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>ANN Rejected Record Type Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ad_Hoc_Approval_Record_Type_Update</fullName>
        <field>RecordTypeId</field>
        <lookupValue>LLC_BI__Account_Review_Complete</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Ad-Hoc Approval Record Type Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ad_Hoc_Approval_Status_Update</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Ad-Hoc Approval Status Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ad_Hoc_Recalled_Record_Type_Update</fullName>
        <field>RecordTypeId</field>
        <lookupValue>LLC_BI__Account_Review_In_Progress</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Ad-Hoc Recalled Record Type Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ad_Hoc_Recalled_Status_Update</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>Recalled</literalValue>
        <name>Ad-Hoc Recalled Status Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ad_Hoc_Rejected_Record_Type_Update</fullName>
        <field>RecordTypeId</field>
        <lookupValue>LLC_BI__Account_Review_In_Progress</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Ad-Hoc Rejected Record Type Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ad_Hoc_Rejected_Status_Update</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Ad-Hoc Rejected Status Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Approved_Date</fullName>
        <description>Update the approved date to current date</description>
        <field>CF_Approved_Date__c</field>
        <formula>TODAY()</formula>
        <name>Update Approved Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Review_Status</fullName>
        <description>Updates Review Status to Approved</description>
        <field>LLC_BI__Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Update Review Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>Recalled</literalValue>
        <name>Update Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_To_Rejected</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Update Status To Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_to_Approved</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Update Status to Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_to_Submitted</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>Submitted for Approval</literalValue>
        <name>Update Status to Submitted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Watch_List_Approval_Record_Type</fullName>
        <field>RecordTypeId</field>
        <lookupValue>REV_Watch_List_Review_Complete</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Watch List Approval Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Watch_List_Approval_status_Field_Type</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Watch List Approval status Field Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Watch_List_REV_Initial_Submission_Action</fullName>
        <field>CF_Watch_List_Status__c</field>
        <literalValue>Submitted for Approval</literalValue>
        <name>Watch List REV Initial Submission Action</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Watch_List_REV_Initial_Submission_status</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>Submitted for Approval</literalValue>
        <name>Watch List REV Initial Submission status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Watch_List_REV_Rejection_Action</fullName>
        <field>CF_Watch_List_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Watch List REV Rejection Action</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Watch_List_REV_Rejection_status</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Watch List REV Rejection status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Watch_List_Rejection_Record_Type_Update</fullName>
        <field>RecordTypeId</field>
        <lookupValue>REV_Watch_List_In_Progress</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Watch List Rejection Record Type Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Watch_List_Status_Approval_Record_Type</fullName>
        <field>CF_Watch_List_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Watch List Status Approval Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
</Workflow>
