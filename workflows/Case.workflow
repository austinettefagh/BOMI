<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Adverse_Action_Complain_Notification</fullName>
        <description>Adverse Action Complain Notification</description>
        <protected>false</protected>
        <recipients>
            <recipient>cestes@bankofmissouri.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>lfindlay@bankofmissouri.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rpaul@bankofmissouri.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>sherbst@bankofmissouri.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>tghan@bankofmissouri.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Adverse_Action_Notification</template>
    </alerts>
    <alerts>
        <fullName>BaaS_Approval_Notification</fullName>
        <description>BaaS Approved Notification</description>
        <protected>false</protected>
        <recipients>
            <recipient>BaaS_Tier_I</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <recipient>BaaS_Tier_II</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/BaaS_Material_Approved</template>
    </alerts>
    <alerts>
        <fullName>BaaS_Collateral_Approval</fullName>
        <description>BaaS Collateral Approval</description>
        <protected>false</protected>
        <recipients>
            <recipient>BaaS_Tier_I</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <recipient>BaaS_Tier_II</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/BaaS_Material_Submitted_Approval</template>
    </alerts>
    <alerts>
        <fullName>BaaS_Rejection_Notification</fullName>
        <description>BaaS Rejection Notification</description>
        <protected>false</protected>
        <recipients>
            <recipient>BaaS_Tier_I</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <recipient>BaaS_Tier_II</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/BaaS_Material_Rejected</template>
    </alerts>
    <alerts>
        <fullName>BaaS_Submitted_Approval</fullName>
        <description>BaaS Submitted for Approval</description>
        <protected>false</protected>
        <recipients>
            <recipient>BaaS_Tier_I</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/BaaS_Material_Submitted_Approval</template>
    </alerts>
    <alerts>
        <fullName>CS_Approval_Notification_Tier_II</fullName>
        <description>CS Approval Notification Tier II</description>
        <protected>false</protected>
        <recipients>
            <recipient>bstorm@bankofmissouri.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>hsimmers@bankofmissouri.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mbarker@bankofmissouri.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>smoore@bankofmissouri.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>snichols@cadlaw.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>FSCEmailTemplates/SUPPORTApprovalnotification</template>
    </alerts>
    <alerts>
        <fullName>CS_Approval_Notification_Tier_III</fullName>
        <description>CS Approval Notification Tier III</description>
        <protected>false</protected>
        <recipients>
            <recipient>amoore@bankofmissouri.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bstorm@bankofmissouri.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>hsimmers@bankofmissouri.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kfelkel@bankofmissouri.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kjones@bankofmissouri.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>FSCEmailTemplates/SUPPORTApprovalnotification</template>
    </alerts>
    <alerts>
        <fullName>Collection_Dept_Hardship_Plan</fullName>
        <description>Collection Dept. - Hardship Plan</description>
        <protected>false</protected>
        <recipients>
            <recipient>Collection_Dept</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/New_Dex_Back_Office_Case</template>
    </alerts>
    <alerts>
        <fullName>Coserv_Email_notification_Backoffice</fullName>
        <description>Coserv Email notification Backoffice</description>
        <protected>false</protected>
        <recipients>
            <recipient>Dex_Credit_Card_Back_Office</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <recipient>shart@bankofmissouri.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SUPPORTCaseescalationnotificationSAMPLE</template>
    </alerts>
    <alerts>
        <fullName>Hardship_Plan_Approved</fullName>
        <description>Hardship Plan Approved</description>
        <protected>false</protected>
        <recipients>
            <recipient>Dex_Credit_Card_Back_Office</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SUPPORTCaseescalationnotificationSAMPLE</template>
    </alerts>
    <alerts>
        <fullName>New_Dex_Back_Office_Case</fullName>
        <description>New Dex Back Office Case</description>
        <protected>false</protected>
        <recipients>
            <recipient>Back_Office_Ops</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>shart@bankofmissouri.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/New_Dex_Back_Office_Case</template>
    </alerts>
    <alerts>
        <fullName>New_Dex_Complaint_Case</fullName>
        <description>New Dex Complaint Case</description>
        <protected>false</protected>
        <recipients>
            <recipient>ashewman@bankofmissouri.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>ayoung@bankofmissouri.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/New_Dex_Complaint_Case</template>
    </alerts>
    <alerts>
        <fullName>New_Dex_Loan_Servicing_Case</fullName>
        <description>New Dex Loan Servicing Case</description>
        <protected>false</protected>
        <recipients>
            <recipient>Loan_Servicing</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/New_Dex_Loan_Servicing_Case</template>
    </alerts>
    <alerts>
        <fullName>Pending_Approval_Case_Review</fullName>
        <description>Pending Approval Case Review</description>
        <protected>false</protected>
        <recipients>
            <recipient>Director_of_Relationship_Mgmt</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/BaaS_Material_Approved</template>
    </alerts>
    <alerts>
        <fullName>Underwriters_Alert</fullName>
        <description>Underwriters Alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>cbuchheit@bankofmissouri.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>cestes@bankofmissouri.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jblackman@bankofmissouri.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>lfindlay@bankofmissouri.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>tfriel@bankofmissouri.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SUPPORTCaseescalationnotificationSAMPLE</template>
    </alerts>
    <fieldUpdates>
        <fullName>BaaS_Approval_SLA</fullName>
        <description>Update BaaS approval SLA</description>
        <field>Initial_SLA_in_Working_Days__c</field>
        <formula>IF( RecordType.Id = &quot;BaaS Approval&quot;, 10, null)</formula>
        <name>BaaS Approval SLA</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Back_office</fullName>
        <description>Approved by Underwriter; pending to Back office</description>
        <field>OwnerId</field>
        <lookupValue>Dex_Back_Office</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Back office</name>
        <notifyAssignee>true</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CS_Approval_Subject</fullName>
        <description>Updates the subject to reflect the collateral item.</description>
        <field>Subject</field>
        <formula>IF(NOT(ISBLANK( Collateral_Item__c )), Collateral_Item__c , NULL)</formula>
        <name>CS Approval Subject</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CS_Approval_Tier</fullName>
        <description>SLA for CS Tier 1-3 approvals</description>
        <field>Initial_SLA_in_Working_Days__c</field>
        <formula>IF(ISPICKVAL(Approval_Tier__c, &quot;Tier 1&quot;), 5, (IF(ISPICKVAL(Approval_Tier__c, &quot;Tier 2&quot;), 8,(IF(ISPICKVAL(Approval_Tier__c, &quot;Tier 3&quot;), 10, NULL)))))</formula>
        <name>CS Approval Tier</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CS_Priority_Update</fullName>
        <description>Update priority if case submitted by agency</description>
        <field>Priority</field>
        <literalValue>High</literalValue>
        <name>CS Priority Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Case_Owner_Contract_Services_Tier_I</fullName>
        <description>Update Record Type if Case Owner equals Tier I</description>
        <field>RecordTypeId</field>
        <lookupValue>Contract_Services_Tier_I</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Case Owner Contract Services Tier I</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Case_Status_to_Approved</fullName>
        <description>Updated case status to = approved</description>
        <field>Status</field>
        <literalValue>Approved</literalValue>
        <name>Case Status to Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Case_Status_to_In_Process</fullName>
        <field>Status</field>
        <literalValue>In Process</literalValue>
        <name>Case Status to In Process</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Case_Status_to_Review</fullName>
        <description>Updates case status to In Review</description>
        <field>Status</field>
        <literalValue>In Review</literalValue>
        <name>Case Status to Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Collection_Dept_Hardship_Plan</fullName>
        <field>OwnerId</field>
        <lookupValue>Collection_Dept</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Collection Dept. - Hardship Plan</name>
        <notifyAssignee>true</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Customer_Pmt_Subject</fullName>
        <field>Subject</field>
        <formula>IF(ISPICKVAL( Type , &quot;Customer Payment&quot;), &quot;Customer Payment&quot;, Null)</formula>
        <name>Customer Pmt Subject</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Dex_Back_Office_Case_Owner</fullName>
        <description>Update case owner to Dex Back Office</description>
        <field>OwnerId</field>
        <lookupValue>Dex_Back_Office</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Dex Back Office Case Owner</name>
        <notifyAssignee>true</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Dex_Complaint_Case_Owner_Update</fullName>
        <description>Update case owner to Dex Complaints</description>
        <field>OwnerId</field>
        <lookupValue>Dex_Complaints</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Dex Complaint Case Owner Update</name>
        <notifyAssignee>true</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Dex_Loan_Servicing_Case_Owner</fullName>
        <description>Update case owner to Dex Loan Servicing</description>
        <field>OwnerId</field>
        <lookupValue>Dex_Loan_Servicing</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Dex Loan Servicing Case Owner</name>
        <notifyAssignee>true</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Hardship_Plan_Approved</fullName>
        <description>approved by collection dept</description>
        <field>OwnerId</field>
        <lookupValue>Collection_Dept</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Hardship Plan Approved</name>
        <notifyAssignee>true</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Hardship_Rejected</fullName>
        <description>Rejected</description>
        <field>Status</field>
        <literalValue>Closed</literalValue>
        <name>Hardship Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Rejection</fullName>
        <description>close case if rejected by underwriters</description>
        <field>Status</field>
        <literalValue>Closed</literalValue>
        <name>Rejection</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Update</fullName>
        <field>Status</field>
        <literalValue>In Progress</literalValue>
        <name>Status Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Tier_II_Status_Update</fullName>
        <field>Status</field>
        <literalValue>In Progress</literalValue>
        <name>Tier II Status Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Underwriters</fullName>
        <description>For increase limit, it should be approved by any underwriters before it goes to back office.</description>
        <field>OwnerId</field>
        <lookupValue>Underwriters</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Underwriters</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Approval_Date</fullName>
        <description>Update the TBOM Approval Date</description>
        <field>TBOM_Approval_Date__c</field>
        <formula>Today()</formula>
        <name>Update Approval Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>BaaS Approval SLA</fullName>
        <actions>
            <name>BaaS_Approval_SLA</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>BaaS Approval</value>
        </criteriaItems>
        <description>Add the BaaS Approval SLA</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>CS Approval Subject</fullName>
        <actions>
            <name>CS_Approval_Subject</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>contains</operation>
            <value>CS Relationship Approval</value>
        </criteriaItems>
        <description>Update CS Approval subject to reflect Collateral Item</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>CS Approval Tier SLA</fullName>
        <actions>
            <name>CS_Approval_Tier</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>((1 AND 4) OR (2 AND 4) OR (3 AND 4))</booleanFilter>
        <criteriaItems>
            <field>Case.Approval_Tier__c</field>
            <operation>contains</operation>
            <value>Tier 1</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Approval_Tier__c</field>
            <operation>contains</operation>
            <value>Tier 2</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Approval_Tier__c</field>
            <operation>contains</operation>
            <value>Tier 3</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>contains</operation>
            <value>CS Relationship Approval</value>
        </criteriaItems>
        <description>Set CS approval SLA days based on approval tier.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>CS Customer Pmt Subject</fullName>
        <actions>
            <name>Customer_Pmt_Subject</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Type</field>
            <operation>equals</operation>
            <value>Customer Payment</value>
        </criteriaItems>
        <description>Updating case subject to reflect customer payment</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Dex Back Office Case Owner Update</fullName>
        <actions>
            <name>Dex_Back_Office_Case_Owner</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Category__c</field>
            <operation>equals</operation>
            <value>Customer Information Update,Account Research/Inquiry,Account Maintenance Requests,Transactional Issue,Courtesy Request,Customer Assistance,Special Offer,Supervisor Contact Request,Business Account Request,Back Office Maintenance/Other</value>
        </criteriaItems>
        <description>Update case owner to Dex Back Office based on case category</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Dex Complaint Case Owner Update</fullName>
        <actions>
            <name>Dex_Complaint_Case_Owner_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Category__c</field>
            <operation>equals</operation>
            <value>Customer Complaint</value>
        </criteriaItems>
        <description>Update case owner to Dex Complaint based on case category</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Dex Loan Servicing Case Owner Update</fullName>
        <actions>
            <name>Dex_Loan_Servicing_Case_Owner</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Category__c</field>
            <operation>equals</operation>
            <value>Legal Request,Credit Reporting Disputes</value>
        </criteriaItems>
        <description>Update case owner to Dex Loan Servicing based on case category</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Dex Back Office Case</fullName>
        <actions>
            <name>New_Dex_Back_Office_Case</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Category__c</field>
            <operation>equals</operation>
            <value>Customer Information Update,Account Research/Inquiry,Account Maintenance Requests,Transactional Issue,Courtesy Request,Customer Assistance,Special Offer,Supervisor Contact Request,Business Account Request,Back Office Maintenance/Other</value>
        </criteriaItems>
        <description>Email alert for new Dex Back Office Cases</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Dex Complaint Case</fullName>
        <actions>
            <name>New_Dex_Complaint_Case</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Category__c</field>
            <operation>equals</operation>
            <value>Customer Complaint</value>
        </criteriaItems>
        <description>Email alert for new Dex Complaint Cases</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Dex Loan Servicing Case</fullName>
        <actions>
            <name>New_Dex_Loan_Servicing_Case</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Category__c</field>
            <operation>equals</operation>
            <value>Legal Request,Credit Reporting Disputes</value>
        </criteriaItems>
        <description>Email alert for new Dex Loan Servicing Cases</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Set Priority</fullName>
        <actions>
            <name>CS_Priority_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Contract Services - Tier I,Contract Services - Tier II</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Agency_Receiving_Initial_Complaint__c</field>
            <operation>equals</operation>
            <value>FDIC,Attorney General,Federal Reserve,CFPB,Division of Finance,OCC,Other</value>
        </criteriaItems>
        <description>Set Priority based on agency request</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Case Owner for Contract Services</fullName>
        <actions>
            <name>Case_Owner_Contract_Services_Tier_I</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>equals</operation>
            <value>Contract Services - Tier I</value>
        </criteriaItems>
        <description>Update Case Owner for Contract Services</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
