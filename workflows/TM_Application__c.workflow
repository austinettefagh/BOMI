<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Alert_When_New_Application_has_been_Created</fullName>
        <description>Alert When New Application has been Created</description>
        <protected>false</protected>
        <recipients>
            <recipient>TM_Review_Treasury_Application_Group</recipient>
            <type>group</type>
        </recipients>
        <senderAddress>noreply@bankofmissouri.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/TM_New_Application_Created</template>
    </alerts>
</Workflow>
