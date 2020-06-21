@isTest (SeeAllData=true)
private class Test1_readhtml2{


integer plen = 600;
static string text = ' ';
integer i = 0;
string charset = 'abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ $&*+-./:!@#^&()_=[{}];,<>?|~';
integer cslen = charset.length();
double d = 0;
integer decval = 0;

{
for (i = 0; i < plen-1; i++) {
    d = math.random();
    decval = integer.valueof(math.floor(d * cslen));
    text += charset.mid(decval,1);
}
}

  static testMethod void Test_readhtml2(){ 
  
//integer plen = 600;
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
//}

 string strhtml = '<html>'  + text + ' /images/trailhead/badges/superbadges Superbadges stats_number<124>stats_text flag.png flag.png <b>120930</b>Trailhead Points Earned!' + text + 'Superbadges </html>'; 
        SingleRequestMock fakeResponse1 = new SingleRequestMock(300,'Complete',strhtml, null);
        Test.setMock(HttpCalloutMock.class, fakeResponse1);
        readhtml2.getbody('005F0000004ss8EIAQ');       
  }
  
           static testMethod void checkfordata() {
           
           //integer plen = 600;
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

           // string strhtml = '<html>'  + text + ' /images/trailhead/badges/superbadges Superbadges stats_number<124>stats_text flag.png flag.png <b>120930</b>Trailhead Points Earned!' + text + 'Superbadges </html>'; 
 string strhtml = '<html>Superbadges stats_number<124>stats_text flag.png flag.png <b>120930</b>Trailhead Points Earned! </html>';
 
        SingleRequestMock fakeResponse1 = new SingleRequestMock(200,'Complete',strhtml, null);
        Test.setMock(HttpCalloutMock.class, fakeResponse1);
        readhtml2.getbody('005F0000004ss8EIAQ'); 
               
        //SingleRequestMock fakeResponse2 = new SingleRequestMock(200,'Complete',strhtml, null);
        //Test.setMock(HttpCalloutMock.class, fakeResponse2);
        //readhtml2.getbody('005F0000004ss8EIAQ'); 
               
        //SingleRequestMock fakeResponse3 = new SingleRequestMock(301,'Complete',strhtml, null);
        //Test.setMock(HttpCalloutMock.class, fakeResponse3);
        //readhtml2.getbody('005F0000004ss8EIAQ'); 
         
         }
         
     
  }