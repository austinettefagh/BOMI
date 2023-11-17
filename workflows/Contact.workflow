<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Contact_Alert_Portal_Loan_Status_Change</fullName>
        <description>Contact_Alert_Portal_Loan_Status_Change</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderAddress>noreply@bankofmissouri.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>TBoM_Email_Templates/TBoM_PreComp_Loan_Status_Email</template>
    </alerts>
    <alerts>
        <fullName>Contact_Alert_When_User_Not_Uploaded_Document_3days_Of_Request</fullName>
        <description>Contact_Alert_When_User_Not_Uploaded_Document_3days_Of_Request</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderAddress>noreply@bankofmissouri.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>TBoM_Email_Templates/TBOM_LDC_Upload_document_alert</template>
    </alerts>
    <fieldUpdates>
        <fullName>LLC_BI__Set_Contact_Business_Record_Type</fullName>
        <field>RecordTypeId</field>
        <lookupValue>LLC_BI__Business_Contact</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Set Contact Business Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>LLC_BI__Set_Contact_Individual_Record_Type</fullName>
        <field>RecordTypeId</field>
        <lookupValue>LLC_BI__Individual_Contact</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Set Contact Individual Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>LLC_BI__Contact Set Business Record Type</fullName>
        <actions>
            <name>LLC_BI__Set_Contact_Business_Record_Type</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contact.LLC_BI__Primary_Contact__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>sets Record Type to Business if Contact is not marked as primary</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>LLC_BI__Contact Set Individual Record Type</fullName>
        <actions>
            <name>LLC_BI__Set_Contact_Individual_Record_Type</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contact.LLC_BI__Primary_Contact__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>sets Record Type to Individual if Contact is marked as primary</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
