public class TrailheadDataController {
   public List< AggregateResult > getLeaderboards() {
   string strname = 'Master';
    List< AggregateResult > leaderboards = Database.query(
         'SELECT thdata__c ' +
        'FROM trailheaddata__c ' +
        ' WHERE name__c = :strname  ' +
        ' group by thdata__c limit 1'
    );
    system.debug('Results: ' + leaderboards);
    return leaderboards;
   }   
}