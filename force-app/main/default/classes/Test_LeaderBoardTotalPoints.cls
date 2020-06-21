@isTest(SeeAllData=true)
private class Test_LeaderBoardTotalPoints {
static testMethod void test() {
    LeaderBoardTotalPoints fe = new LeaderBoardTotalPoints();
    Test.startTest();
    List<AggregateResult> events = fe.getLeaderboards();
    Test.stopTest();
    System.assertNotEquals(null, events);
}
}