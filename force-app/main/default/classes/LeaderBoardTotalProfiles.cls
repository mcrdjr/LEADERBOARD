public class LeaderBoardTotalProfiles {
   public List<AggregateResult> getLeaderboards() {
    string results;
    List<String> someValues = new List<String>{'NOT FOUND', 'ERROR', 'MISSING'};
    List<AggregateResult> leaderboardsTotalProfiles = Database.query('SELECT count(id) tp FROM Leaderboard__c WHERE UrlStatus__c != :someValues and profile__c > \'\' ');
    system.debug('Total Profiles: ' + leaderboardsTotalProfiles);
    return leaderboardsTotalProfiles;
   }   
}