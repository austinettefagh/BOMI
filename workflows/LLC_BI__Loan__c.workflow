<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>LLC_BI__Alert_Loan_Withdrawn_Declined</fullName>
        <ccEmails>trialforce@bankr.com</ccEmails>
        <description>Alert Loan Withdrawn / Declined</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>LLC_BI__Bankr_Templates/LLC_BI__Loan_Withdrawn_DeclinedAlert</template>
    </alerts>
    <alerts>
        <fullName>LLC_BI__Alert_Loan_in_Closing_Stage_too_Long</fullName>
        <ccEmails>demo@bankr.com</ccEmails>
        <description>Alert Loan in Closing Stage too Long</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>LLC_BI__Bankr_Templates/LLC_BI__Loan_in_Closing_XDay_Alert</template>
    </alerts>
    <alerts>
        <fullName>LLC_BI__Loan_Closing_E_mail_Alert</fullName>
        <ccEmails>demo@bankr.com</ccEmails>
        <description>Loan Closing E-mail Alert</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>LLC_BI__Bankr_Templates/LLC_BI__Loan_Closing_Termplate</template>
    </alerts>
    <alerts>
        <fullName>LLC_BI__Loan_Lost_Alert</fullName>
        <ccEmails>trialforce@bankr.com</ccEmails>
        <description>Loan Lost Alert</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>LLC_BI__Bankr_Templates/LLC_BI__Loan_Closing_Termplate</template>
    </alerts>
    <alerts>
        <fullName>LLC_BI__Notify_Loan_Reviewed_by_Quality_Compliance</fullName>
        <ccEmails>trialforce@bankr.com</ccEmails>
        <description>Notify Loan Reviewed by Quality (Compliance)</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>LLC_BI__Bankr_Templates/LLC_BI__Loan_Reviewed_by_Compliance</template>
    </alerts>
    <alerts>
        <fullName>LLC_BI__Notify_Roles_of_Lead_Conversion_into_Loan</fullName>
        <ccEmails>demo@bankr.com</ccEmails>
        <description>Notify Roles of Lead Conversion into Loan</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>LLC_BI__Bankr_Templates/LLC_BI__LeadConverted</template>
    </alerts>
    <alerts>
        <fullName>Loan_Alert_RegBDays_MoreThan25</fullName>
        <description>Alert RM and CA for RegBdays crossing 25 days</description>
        <protected>false</protected>
        <recipients>
            <field>CF_Credit_Analyst__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>LLC_BI__Loan_Officer__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>kjmattingly@bankofmissouri.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>TBoM_Email_Templates/TBoM_Alert_RM_CA_for_RegBdays_crossing_25_days</template>
    </alerts>
    <fieldUpdates>
        <fullName>LLC_BI__IsApproved</fullName>
        <field>LLC_BI__Is_Approved__c</field>
        <literalValue>1</literalValue>
        <name>IsApproved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>LLC_BI__IsOriginalDeclinedLoan</fullName>
        <field>LLC_BI__Is_Original_Inactive_Loan__c</field>
        <literalValue>1</literalValue>
        <name>IsOriginalDeclinedLoan</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>LLC_BI__Loan_Balloon_Indicator_Unset</fullName>
        <description>Unset the Loan Balloon Indicator</description>
        <field>LLC_BI__Balloon__c</field>
        <literalValue>0</literalValue>
        <name>Loan Balloon Indicator Unset</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>LLC_BI__Loan_Balloon_Indicator_Update</fullName>
        <description>Update the Loan Balloon Indicator</description>
        <field>LLC_BI__Balloon__c</field>
        <literalValue>1</literalValue>
        <name>Loan Balloon Indicator Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>LLC_BI__Loan_Lost_MTK</fullName>
        <description>Trigger mailerteamkey for Loan Lost Alert</description>
        <field>LLC_BI__MailerTeamKey__c</field>
        <formula>&quot;LoanLost&quot;</formula>
        <name>Loan Lost - MTK</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>LLC_BI__Set_Payoff_Date_on_Paid_Out</fullName>
        <field>LLC_BI__Payoff_Date__c</field>
        <formula>Today()</formula>
        <name>Set Payoff Date on Paid Out</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>LLC_BI__UCC_Update_State</fullName>
        <field>LLC_BI__UCC_State__c</field>
        <formula>LLC_BI__CloseDate__c + 1826</formula>
        <name>UCC Update State</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>LLC_BI__UpdateLoanStage</fullName>
        <field>LLC_BI__Stage__c</field>
        <literalValue>Processing</literalValue>
        <name>Update Loan Stage</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>LLC_BI__Update_HMDA_Record_Type</fullName>
        <description>Updates the HMDA Record Type field based on the date.</description>
        <field>LLC_BI__HMDA_Record_Type__c</field>
        <literalValue>HMDA-Effective-2018</literalValue>
        <name>Update HMDA Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>LLC_BI__Update_UCC_County</fullName>
        <field>LLC_BI__UCC_County__c</field>
        <formula>LLC_BI__CloseDate__c + 1826</formula>
        <name>Update UCC County</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>LLC_BI__Update_isClosed</fullName>
        <field>LLC_BI__isClosed__c</field>
        <literalValue>1</literalValue>
        <name>Update isClosed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>LLC_BI__Update_isClosed_to_True</fullName>
        <description>The loan has closed, so update the isClosed stage to true</description>
        <field>LLC_BI__isClosed__c</field>
        <literalValue>1</literalValue>
        <name>Update isClosed to True</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Loan_Approval_Stage</fullName>
        <field>LLC_BI__Stage__c</field>
        <literalValue>Pre-Closing Due Diligence</literalValue>
        <name>Loan Approval Stage</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Loan_Approval_Status</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>Open</literalValue>
        <name>Loan Approval Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Loan_Approver1_Approved</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>Approver1 Approved</literalValue>
        <name>Loan Approver1 Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Loan_Approver2_Approved</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>Approver2 Approved</literalValue>
        <name>Loan Approver2 Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Loan_Approver3_Approved</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>Approver3 Approved</literalValue>
        <name>Loan Approver3 Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Loan_Board_of_Directors_Approved</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>Board of Directors Approved</literalValue>
        <name>Loan Board of Directors Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Loan_CBP_RBP_RCO_Role_Approved</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>CBP RBP RCO Role Approved</literalValue>
        <name>Loan CBP RBP RCO Role Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Loan_CEO_CCO_CBO_Role_Approved</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>CEO CCO CBO Role Approved</literalValue>
        <name>Loan CEO CCO CBO Role Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Loan_Director_Loan_Committee_Approved</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>Director Loan Committee Approved</literalValue>
        <name>Loan Director Loan Committee Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Loan_Initial_Submission_Stage_Update</fullName>
        <field>LLC_BI__Stage__c</field>
        <literalValue>Credit Decisioning</literalValue>
        <name>Loan Initial Submission Stage Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Loan_Initial_Submission_Status_Update</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>In Review</literalValue>
        <name>Loan Initial Submission Status Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Loan_Internal_Loan_Committee_Approved</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>Internal Loan Committee Approved</literalValue>
        <name>Loan Internal Loan Committee Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Loan_RBP_RCO_Role_Approved</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>RBP RCO Role Approved</literalValue>
        <name>Loan RBP RCO Role Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Loan_RCO_Executive_Team_Role_Approved</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>RCO Executive Team Role Approved</literalValue>
        <name>Loan RCO Executive Team Role Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Loan_Recalled_Stage</fullName>
        <field>LLC_BI__Stage__c</field>
        <literalValue>Credit Underwriting</literalValue>
        <name>Loan Recalled Stage</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Loan_Recalled_Status</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>Open</literalValue>
        <name>Loan Recalled Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Loan_Rejection_Stage</fullName>
        <field>LLC_BI__Stage__c</field>
        <literalValue>Credit Underwriting</literalValue>
        <name>Loan Rejection Stage</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Loan_Rejection_Status</fullName>
        <field>LLC_BI__Status__c</field>
        <literalValue>Rework</literalValue>
        <name>Loan Rejection Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Loan_Set_Credit_Approval_Date_to_Today</fullName>
        <description>The Credit Approval Date will be automatically updated when a loan is approved</description>
        <field>LLC_BI__Credit_Approval_Date__c</field>
        <formula>Today()</formula>
        <name>Loan - Set Credit Approval Date to Today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Loan_Set_Fast_Track_Approved</fullName>
        <field>CF_Fast_Track_Approved__c</field>
        <literalValue>1</literalValue>
        <name>Loan_Set_Fast_Track_Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Uncheck_Is_Review_Ready</fullName>
        <description>After the loan is approved , Is review ready should be unchecked</description>
        <field>LLC_BI__Is_Review_Ready__c</field>
        <literalValue>0</literalValue>
        <name>Uncheck Is Review Ready</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Updating_Original_Approved_Loan_Amount</fullName>
        <description>Maps Loan amount to Original Approved Loan Amount.</description>
        <field>CF_Original_Approved_Loan_Amount__c</field>
        <formula>LLC_BI__Amount__c</formula>
        <name>Updating Original Approved Loan Amount</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>LLC_BI__Alert on Lead Converted into Loan</fullName>
        <actions>
            <name>LLC_BI__Notify_Roles_of_Lead_Conversion_into_Loan</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>LLC_BI__Loan__c.LLC_BI__isConvert__c</field>
            <operation>equals</operation>
            <value>1</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>LLC_BI__HMDA Record Type Check</fullName>
        <actions>
            <name>LLC_BI__Update_HMDA_Record_Type</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Sets the HMDA Record Type field based on the current date</description>
        <formula>TODAY()  &gt;=  DATE(2018,01,01)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>LLC_BI__Loan Closing Alert</fullName>
        <actions>
            <name>LLC_BI__Loan_Closing_E_mail_Alert</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>LLC_BI__Update_isClosed_to_True</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>LLC_BI__Loan__c.LLC_BI__Stage__c</field>
            <operation>equals</operation>
            <value>Closed Funded</value>
        </criteriaItems>
        <criteriaItems>
            <field>LLC_BI__Loan__c.LLC_BI__isClosed__c</field>
            <operation>notEqual</operation>
            <value>True</value>
        </criteriaItems>
        <description>When a loan is set to &quot;Closed Funded&quot; (Update for equivalent) send out the loan closing e-mail alert.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>LLC_BI__Loan In Closing Stages</fullName>
        <active>false</active>
        <criteriaItems>
            <field>LLC_BI__Loan__c.LLC_BI__Stage__c</field>
            <operation>equals</operation>
            <value>Closing</value>
        </criteriaItems>
        <description>Notify respective loan administration / closers and loan team that the loan was moved to closing.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>LLC_BI__Loan Set Balloon Indicator</fullName>
        <actions>
            <name>LLC_BI__Loan_Balloon_Indicator_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Set the Loan Balloon indicator when the Amortization Period (Months) and the Term (Months) are different.</description>
        <formula>AND( ISPICKVAL(LLC_BI__Balloon_Product_Structure__c, &apos;&apos;),   OR ( ISCHANGED( LLC_BI__Amortized_Term_Months__c ) , ISCHANGED( LLC_BI__Term_Months__c )),   (LLC_BI__Amortized_Term_Months__c &lt;&gt;  LLC_BI__Term_Months__c) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>LLC_BI__Loan Un-set Balloon Indicator</fullName>
        <actions>
            <name>LLC_BI__Loan_Balloon_Indicator_Unset</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Un-set the Loan Balloon indicator when the Amortization Period (Months) and the Term (Months) are the same.</description>
        <formula>AND( ISPICKVAL(LLC_BI__Balloon_Product_Structure__c, &apos;&apos;), OR ( ISCHANGED( LLC_BI__Amortized_Term_Months__c ) , ISCHANGED( LLC_BI__Term_Months__c )),  OR(IF(OR( ISBLANK(LLC_BI__Amortized_Term_Months__c), ISBLANK(LLC_BI__Term_Months__c)) , True, False),  (LLC_BI__Amortized_Term_Months__c  =  LLC_BI__Term_Months__c) ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>LLC_BI__Loan Was Lost</fullName>
        <actions>
            <name>LLC_BI__Loan_Lost_MTK</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>LLC_BI__Loan__c.LLC_BI__Stage__c</field>
            <operation>equals</operation>
            <value>Complete</value>
        </criteriaItems>
        <criteriaItems>
            <field>LLC_BI__Loan__c.LLC_BI__Status__c</field>
            <operation>equals</operation>
            <value>Withdrawn</value>
        </criteriaItems>
        <description>When a loan stage is complete and the status is lost</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>LLC_BI__Loan Withdrawn %2F Declined</fullName>
        <actions>
            <name>LLC_BI__Alert_Loan_Withdrawn_Declined</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>LLC_BI__Loan__c.LLC_BI__Stage__c</field>
            <operation>equals</operation>
            <value>Complete</value>
        </criteriaItems>
        <criteriaItems>
            <field>LLC_BI__Loan__c.LLC_BI__Status__c</field>
            <operation>equals</operation>
            <value>Withdrawn,Declined</value>
        </criteriaItems>
        <description>Notify appropriate individuals / department (loan ops)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>LLC_BI__Loan Withdrawn Declined Product Package</fullName>
        <actions>
            <name>LLC_BI__IsOriginalDeclinedLoan</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>LLC_BI__Loan__c.LLC_BI__Status__c</field>
            <operation>equals</operation>
            <value>Withdrawn,Paid Out,Declined</value>
        </criteriaItems>
        <description>Sets the original declined loan field when a loan is loaded with declined or withdrawn status.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>LLC_BI__Notify Loan Stage Change</fullName>
        <active>false</active>
        <criteriaItems>
            <field>LLC_BI__Loan__c.LLC_BI__Stage__c</field>
            <operation>equals</operation>
            <value>Loan Committee,Credit Underwriting,Processing,Doc Review,Doc Prep,Closing</value>
        </criteriaItems>
        <description>Based on the criteria, notify the loan team that the loan stage has been changed.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>LLC_BI__On Closed Set isClosed</fullName>
        <actions>
            <name>LLC_BI__Update_isClosed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>LLC_BI__Loan__c.LLC_BI__Stage__c</field>
            <operation>equals</operation>
            <value>Closed Funded</value>
        </criteriaItems>
        <description>For simpler reporting purposes, if the loan has been closed at any point, set isClosed.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>LLC_BI__Reviewed By Quality</fullName>
        <actions>
            <name>LLC_BI__Notify_Loan_Reviewed_by_Quality_Compliance</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>LLC_BI__Loan__c.LLC_BI__Reviewed_by_Compliance__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Loan has been reviewed by compliance</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>LLC_BI__Set Payoff Date</fullName>
        <actions>
            <name>LLC_BI__Set_Payoff_Date_on_Paid_Out</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>LLC_BI__Loan__c.LLC_BI__Status__c</field>
            <operation>equals</operation>
            <value>Paid Out</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>LLC_BI__Stage Change to Compliance</fullName>
        <active>false</active>
        <criteriaItems>
            <field>LLC_BI__Loan__c.LLC_BI__Stage__c</field>
            <operation>equals</operation>
            <value>Compliance</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>notEqual</operation>
            <value>Compliance</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>LLC_BI__Update UCC Dates</fullName>
        <actions>
            <name>LLC_BI__UCC_Update_State</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>LLC_BI__Update_UCC_County</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>LLC_BI__Loan__c.LLC_BI__Stage__c</field>
            <operation>equals</operation>
            <value>Closed Funded,Closed</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
