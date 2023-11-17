<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>LLC_BI__approval_ready_for_review</fullName>
        <description>approval ready for review</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>LLC_BI__Primary_Officer__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>LLC_BI__Bankr_Templates/LLC_BI__Product_Package_Ready_For_Approval</template>
    </alerts>
    <alerts>
        <fullName>PP_Product_Package_Approved</fullName>
        <description>Product Package Approved Alert RM/LA</description>
        <protected>false</protected>
        <recipients>
            <field>CF_Loan_Assistant__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>CF_Relationship_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>TBoM_Email_Templates/PP_Product_Package_Approved</template>
    </alerts>
    <alerts>
        <fullName>PP_Product_Package_Approved_Fast_forward_approval</fullName>
        <description>Product Package Approved Alert RM/LA (for Fast forward approval)</description>
        <protected>false</protected>
        <recipients>
            <field>CF_Loan_Assistant__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>CF_Relationship_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>TBoM_Email_Templates/PP_Product_Package_Approved</template>
    </alerts>
    <fieldUpdates>
        <fullName>CBP_RBP_RCO_Role_Approved</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>CBP RBP RCO Role Approved</literalValue>
        <name>CBP RBP RCO Role Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CEO_CCO_CBO_Role_Approved</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>CEO CCO CBO Role Approved</literalValue>
        <name>CEO CCO CBO Role Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CLR_APP3</fullName>
        <description>Clear Approver 3 on PP</description>
        <field>CF_Approver_3__c</field>
        <name>CLR APP3</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CLR_APP_1</fullName>
        <description>Clear Approver 1 on PP</description>
        <field>CF_Approver_1__c</field>
        <name>CLR APP 1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CLR_APP_11</fullName>
        <description>Clear Approver 1 on PP</description>
        <field>CF_Approver_1__c</field>
        <name>CLR APP 1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CLR_APP_2</fullName>
        <description>Clear Approver 2</description>
        <field>CF_Approver_2__c</field>
        <name>CLR APP 2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CLR_APP_21</fullName>
        <description>Clear Approver 2</description>
        <field>CF_Approver_2__c</field>
        <name>CLR APP 2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CLR_APP_4</fullName>
        <description>Clear Approver 4 on PP</description>
        <field>CF_Approver_4__c</field>
        <name>CLR APP 4</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CLR_APP_41</fullName>
        <description>Clear Approver 4 on PP</description>
        <field>CF_Approver_4__c</field>
        <name>CLR APP 4</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Clear_Approver_1</fullName>
        <description>Clear Approver 1 on PP</description>
        <field>CF_Approver_1__c</field>
        <name>Clear Approver 1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Clear_Approver_2</fullName>
        <description>Clear Approver 2 on PP</description>
        <field>CF_Approver_2__c</field>
        <name>Clear Approver 2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Clear_Approver_3</fullName>
        <description>Clear Approver 3 on PP</description>
        <field>CF_Approver_3__c</field>
        <name>Clear Approver 3</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Clear_Approver_4</fullName>
        <description>Clear Approver 4 on PP</description>
        <field>CF_Approver_4__c</field>
        <name>Clear Approver 4</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>LLC_BI__Product_Package_Status_Approved</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Product Package Status: Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>LLC_BI__Product_Package_Status_In_Review</fullName>
        <description>Product Package Status: In Review</description>
        <field>LLC_BI__Status__c</field>
        <literalValue>In Review</literalValue>
        <name>Product Package Status: In Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>LLC_BI__Product_Package_Status_Itm_Approved</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>Intermediately Approved</literalValue>
        <name>Product Package Status: Itm Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>LLC_BI__Product_Package_Status_Recalled</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>Recalled</literalValue>
        <name>Product Package Status: Recalled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>LLC_BI__Product_Package_Status_Rejected</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Product Package Status: Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>LLC_BI__Work_Package_Status_In_Review</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>In Review</literalValue>
        <name>Work Package Status: In Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>LLC_BI__approve_update</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>Intermediately Approved</literalValue>
        <name>approve update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>LLC_BI__itm_approve</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>Approved</literalValue>
        <name>itm approve2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>LLC_BI__itm_reject</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>itm reject</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>LLC_BI__update_approval_field</fullName>
        <description>Updates a secondary Approval Status, used to trigger next steps in a reverse propagation approval process</description>
        <field>LLC_BI__Approval_Status__c</field>
        <literalValue>Pending</literalValue>
        <name>Update Approval Status Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PP_Approval_Stage_Update</fullName>
        <field>LLC_BI__Stage__c</field>
        <literalValue>Complete</literalValue>
        <name>PP Approval Stage Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PP_Approver1_Approved</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>Approver1 Approved</literalValue>
        <name>PP Approver1 Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PP_Approver2_Approved</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>Approver2 Approved</literalValue>
        <name>PP Approver2 Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PP_Approver3_Approved</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>Approver3 Approved</literalValue>
        <name>PP Approver3 Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PP_Board_of_Directors_Approved</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>Board of Directors Approved</literalValue>
        <name>PP Board of Directors Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PP_Director_Loan_Committee_Approved</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>Director Loan Committee Approved</literalValue>
        <name>PP Director Loan Committee Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PP_Initial_Submission_Stage_Update</fullName>
        <field>LLC_BI__Stage__c</field>
        <literalValue>Credit Decisioning</literalValue>
        <name>PP Initial Submission Stage Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PP_Internal_Loan_Committee_Approved</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>Internal Loan Committee Approved</literalValue>
        <name>PP Internal Loan Committee Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PP_Recalled_Stage_Update</fullName>
        <field>LLC_BI__Stage__c</field>
        <literalValue>Credit Underwriting</literalValue>
        <name>PP Recalled Stage Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PP_Recalled_Status</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>Open</literalValue>
        <name>PP Recalled Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PP_Rejected_Stage_Update</fullName>
        <field>LLC_BI__Stage__c</field>
        <literalValue>Credit Underwriting</literalValue>
        <name>PP Rejected Stage Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PP_Rejection_Status_Update</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>Rework</literalValue>
        <name>PP Rejection Status Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>RBP_RCO_Role_Approved</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>RBP RCO Role Approved</literalValue>
        <name>RBP RCO Role Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>RCO_Executive_Team_Role_Approved</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>RCO Executive Team Role Approved</literalValue>
        <name>RCO Executive Team Role Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>LLC_BI__Package Approval Ready</fullName>
        <actions>
            <name>LLC_BI__approval_ready_for_review</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <formula>AND( ISPICKVAL(LLC_BI__Approval_Status__c, &apos;Ready&apos;), ISPICKVAL(PRIORVALUE(LLC_BI__Approval_Status__c), &apos;Pending&apos;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <tasks>
        <fullName>LLC_BI__Product_Package_Next_Review_Task</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>LLC_BI__Product_Package__c.LLC_BI__Next_Review_Date__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Product Package Review</subject>
    </tasks>
</Workflow>
