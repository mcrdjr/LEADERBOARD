@isTest(SeeAllData=true)
private class Test_TrailheadDataController {
static testMethod void test() {
    TrailheadDataController fe = new TrailheadDataController();
    Test.startTest();
    List<AggregateResult> events = fe.getLeaderboards();
    Test.stopTest();
    System.assertNotEquals(null, events);
}
}