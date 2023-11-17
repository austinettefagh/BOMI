/**
 * @description TM_UtilityTest
 */ 
@isTest(SeeAllData=FALSE) 
private class TM_UtilityTest {

    /**
     * @description utilityTestMethod description
     */ 
    static testMethod void utilityTestMethod(){
        test.startTest();
        // test getprofileInfo
        System.assertNotEquals(null, TM_Utility.getprofileInfo(UserInfo.getProfileId()));
        // test readFieldSet
        System.assertNotEquals(null, TM_Utility.readFieldSet('TM_RM_Accounts','Account'));
        test.stopTest();
    }
}