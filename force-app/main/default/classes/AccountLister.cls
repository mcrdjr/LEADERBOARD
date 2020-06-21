public class AccountLister {
     public Map<ID, Leaderboard__c > AccountMap {get;set;}
    public AccountLister() {
       AccountMap = new Map<ID, Leaderboard__c >([SELECT Id, Name, Badges__c FROM Leaderboard__c]);
    }
}