public class LeaderBoardTotalSBadges {
   public List<AggregateResult> getLeaderboards() {
    string results;
    List<AggregateResult> leaderboardsTtotalSBadges = Database.query('SELECT sum(Superbadges__c) tp FROM Leaderboard__c ');
    system.debug('Results: ' + leaderboardsTtotalSBadges);
    return leaderboardsTtotalSBadges;
   }   
}