public class LeaderBoardTotalPoints {
   public List<AggregateResult> getLeaderboards() {
    string results;
    List<String> someValues = new List<String>{'NOT FOUND', 'ERROR', 'MISSING'};
    List<AggregateResult> leaderboardsTtotalPoints = Database.query('SELECT sum(TotalPoints__c) tp FROM Leaderboard__c WHERE UrlStatus__c != :someValues and profile__c > \'\'');
    system.debug('Results: ' + leaderboardsTtotalPoints);
    return leaderboardsTtotalPoints;
   }   
}