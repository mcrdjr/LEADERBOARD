@isTest
private class testMyController1
{
    private static testMethod void testAutoRun() {
        
        test.startTest();
        PageReference pageRef = Page.Leader_Board;
        LeaderBoard__c acc = new LeaderBoard__c(userid__c='00500000000000000');
        insert acc;
        Test.setCurrentPage(pageRef);
        
        test.stopTest();
    }

}