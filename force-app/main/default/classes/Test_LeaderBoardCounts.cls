@isTest(SeeAllData=true)
private class Test_LeaderBoardCounts {
static testMethod void test() {
    LeaderBoardCount fe = new LeaderBoardCount();
    Test.startTest();
    List<AggregateResult> events = fe.getLeaderboards();
    Test.stopTest();
    System.assertNotEquals(null, events);
}
}