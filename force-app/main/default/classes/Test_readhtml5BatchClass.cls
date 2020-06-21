@isTest //(SeeAllData=true)
private class Test_readhtml5BatchClass{
static testMethod void testBatchClass() {

Leaderboard__c newLB = new Leaderboard__c ();
        newLB.Name = 'Michael Rucker';
        newLB.userid__c = '005F0000004ss8EIAQ';
        newLB.ProfileUrlLength__c = 0;
        newLB.UrlStatus__c = 'OK';
        insert newLB;
        
Test.startTest();
 
readhtml5 bc = new readhtml5();

integer plen = 100;
string text = ' ';
integer i = 0;
string charset = 'abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ $&*+-./:!@#^&()_=[{}];,<>?|~';
integer cslen = charset.length();
double d = 0;
integer decval = 0;
for (i = 0; i < plen-1; i++) {
    d = math.random();
    decval = integer.valueof(math.floor(d * cslen));
    text += charset.mid(decval,1);
    //system.debug(decval + ' ' + charset.mid(decval,1));
}
//system.debug('text: ' + text);
///
text = text + ' ' + 'data-test-user-name' + ' ' + text + 'Michael Rucker';
text = text + ' ' + 'data-test-badges-count' + ' ' + text + '999' ;
text = text + ' ' + 'data-test-points-count' + ' ' + text + '999,999';
text = text + ' ' + 'profile/AboutMe' + text;
text = text + ' ' + 'created_at' + text + ' ' + '2017-01-01';
text = text + ' ' + '_flag.png' + ' ' + 9;
text = text + ' ' + 'Badges' + ' ' + 9;
string strhtml = '<html>'  + text + 'leading-marg-m' + text + '999' + 'leading-marg-m' + text + '999,999' + ' SuperBadges </html>'; 

strhtml = 'data-test-user-name </h1> Michael Rucker' + 'data-test-points-count>253,354</div>';


//string strhtml = '<html>'  + text + ' leading-marg-m /images/trailhead/badges/superbadges Superbadges stats_number<124>stats_text flag.png flag.png <b>120930</b>Trailhead Points Earned!' + text + 'Superbadges </html>'; 
//string strhtml = '<html>Superbadges stats_number<124>stats_text flag.png flag.png <b>120930</b>Trailhead Points Earned!</html>'; 
        SingleRequestMock fakeResponse1 = new SingleRequestMock(300,'Complete',strhtml, null);
        Test.setMock(HttpCalloutMock.class, fakeResponse1);
  
        system.debug('fake response: ' + fakeResponse1);

Database.executeBatch(bc, 200); 
Test.stopTest();
}



//static testMethod void testBatchClass2() {
//Test.startTest();
//readhtml5 bc = new readhtml5();

//integer plen = 100;
//string text = ' ';
//integer i = 0;
//string charset = 'abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ $&*+-./:!@#^&()_=[{}];,<>?|~';
//integer cslen = charset.length();
//double d = 0;
//integer decval = 0;
//for (i = 0; i < plen-1; i++) {
//    d = math.random();
//    decval = integer.valueof(math.floor(d * cslen));
//    text += charset.mid(decval,1);
//    //system.debug(decval + ' ' + charset.mid(decval,1));
//}
////system.debug('text: ' + text);
///

// //string strhtml = '<html>'  + text + ' /images/trailhead/badges/superbadges Superbadges stats_number<124>stats_text flag.png flag.png <b>120930</b>Trailhead Points Earned!' + text + 'Superbadges </html>'; 
//string strhtml = '<html>leading-marg-m Superbadges stats_number<124>stats_text flag.png flag.png <b>120930</b>Trailhead Points Earned!</html>'; 
//        SingleRequestMock fakeResponse1 = new SingleRequestMock(200,'Complete',strhtml, null);
//        Test.setMock(HttpCalloutMock.class, fakeResponse1);
//  
//        system.debug('fake response: ' + fakeResponse1);

//Database.executeBatch(bc, 200); //was 200
//Test.stopTest();
//}


}