<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>FSCNewReferralNotification</fullName>
        <description>Email alert for a new referral</description>
        <protected>false</protected>
        <recipients>
            <field>FinServ__ReferredByContact__c</field>
            <type>contactLookup</type>
        </recipients>
        <recipients>
            <field>FinServ__ReferredByUser__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>FSCEmailTemplates/FSCNewReferralNotification</template>
    </alerts>
    <alerts>
        <fullName>Partner_with_Us_lead</fullName>
        <description>Partner with Us lead</description>
        <protected>false</protected>
        <recipients>
            <recipient>Partner_with_Us_leads</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/LeadsWebtoLeademailresponseSAMPLE</template>
    </alerts>
</Workflow>
