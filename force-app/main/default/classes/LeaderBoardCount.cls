//interesting stuff
//http://blog.jeffdouglas.com/2010/07/13/building-a-dynamic-search-page-in-visualforce/
public class LeaderBoardCount {
    //private final List<Leaderboard__c> Leaderboard;
    //public String sdate { get; set; }
   //     public static string getAccounts() {
   //    //public static integer getAccounts() {
   //    //return [SELECT count() from  Leaderboard__c];
   //    List<AggregateResult> strDate = [SELECT day_only(LastModifiedDate) FROM Leaderboard__c group by day_only(LastModifiedDate)
   //    order by day_only(LastModifiedDate) desc limit 1];
   //    String sdate = string.valueof(strdate);
   //    system.debug(sdate);
   //    return sdate; 
   //AggregateResult
   public List<AggregateResult> getLeaderboards() {
    string results;
    List<AggregateResult> leaderboards = Database.query(
        'SELECT day_only(convertTimezone(LastModifiedDate)) sdate FROM Leaderboard__c ' + 
        ' WHERE CreatedDate < today ' +
        'group by day_only(convertTimezone(LastModifiedDate)) ' +
        'order by day_only(convertTimezone(LastModifiedDate)) desc limit 1 ' 
    );
    system.debug('Results: ' + leaderboards);
    return leaderboards;
   }   
   public static string strCount() {
   //1000 Trailblazers and counting on this list ...   
   integer count= database.countQuery('select count() from leaderboard__c');
   system.debug(count + ' Trailblazers and counting on this list ... ');
   return count + ' Trailblazers and counting on this list ... ';
   }

}