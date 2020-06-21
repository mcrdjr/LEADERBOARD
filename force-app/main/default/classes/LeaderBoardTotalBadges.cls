public class LeaderBoardTotalBadges {
   public List<AggregateResult> getLeaderboards() {
    string results;
    List<String> someValues = new List<String>{'NOT FOUND', 'ERROR', 'MISSING'};
    List<AggregateResult> leaderboardsTtotalBadges = Database.query('SELECT sum(Badges__c) tp FROM Leaderboard__c WHERE UrlStatus__c != :someValues and profile__c > \'\'  ');
    system.debug('Results: ' + leaderboardsTtotalBadges);
    return leaderboardsTtotalBadges;
   }   
}