@isTest
private class LeaderBoardTestClass {

    
    static testMethod void validateLeaderboard() {
    
    //Test.StartTest();
    //readhtml2.getbody('');
    
    ApexPages.currentPage().getParameters().put('debugSoql','Hello');
    ApexPages.currentPage().getParameters().get('debugSoql');

    //checkgethttp();
    //checkforshortdata();
    //checkfornodata();
    //checkformissingdata();
    
    

    //Test.StopTest();
   
    
        String userid;
        String strhtml;
        String debugSoql;
        List<String> someValues = new List<String>{'NOT FOUND', 'ERROR', 'MISSING'};
    
        //test for right length and vaild id
        userid = '005500000000000000';
        strhtml = '200';
        debugSoql = 'Goodbye';

        Leaderboard__c newLB = new Leaderboard__c ();
        newLB.Name = userid;
        newLB.userid__c = userid;
        newLB.ProfileUrlLength__c = 100; //strhtml.Length();
        newLB.UrlStatus__c = '200' ; //res.getStatus();
        insert newLB;
        
        system.debug ('Userid: ' + userid);
        System.assertEquals ('005500000000000000', newLB.userid__c);

        
        //https://developer.salesforce.com/forums/?id=906F0000000BMa9IAG
        //https://developer.salesforce.com/forums/?id=906F0000000BMa9IAG
        //this page helped alot
        PageReference pageRef = Page.Leader_Board; 
        pageRef.getParameters().put('userid__c', userid);
        pageRef.getParameters().put('name', userid);
        pageRef.getParameters().put('Goodbye', debugSoql);
        
        pageRef.getParameters().put('strhtml', strhtml);
        
        System.assertEquals ('200',strhtml);
        System.assertEquals ('Goodbye',debugSoql);

        //strhtml='test';
        //System.assertEquals(strhtml, 'test');
        //debugSoql='Hello';
        //System.assertEquals(debugSoql, 'Hello');
        //string p;
        //p ='Hello';
        //System.assertEquals(p, 'Hello');
        
        
        Test.setCurrentPage(pageRef);
        
        LeaderBoardController testCont = new LeaderBoardController();
        testCont.userid = userid;
        //testCont.SaveInfo();
        system.debug('1st - test for right length and valid id');
  
//Test.StopTest();

}



    static testMethod void checkdups() {
    
           SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                 'Complete',
                                                 '[{"Name": "sForceTest1"}]',
                                                 null);
        Test.setMock(HttpCalloutMock.class, fakeResponse);
   
    //Test.StartTest();
    //readhtml2.getbody('');
    
    //ApexPages.currentPage().getParameters().put('debugSoql','blablabla');
    //ApexPages.currentPage().getParameters().get('debugSoql');

    //checkgethttp();
    //checkforshortdata();
    //checkfornodata();
    //checkformissingdata();

    //Test.StopTest();
    
        String userid;
        String strhtml;
        List<String> someValues = new List<String>{'NOT FOUND', 'ERROR', 'MISSING'};
    
        //test for dups
        userid = '005500000060PqcAAE';
        strhtml = '200';

        Leaderboard__c newLB = new Leaderboard__c ();
        newLB.Name = userid;
        newLB.userid__c = userid;
        newLB.ProfileUrlLength__c = 100; //strhtml.Length();
        newLB.UrlStatus__c = '200' ; //res.getStatus();
        insert newLB;
        
        system.debug ('Userid: ' + userid);
        System.assertEquals ('005500000060PqcAAE', newLB.userid__c);

        
        //https://developer.salesforce.com/forums/?id=906F0000000BMa9IAG
        //https://developer.salesforce.com/forums/?id=906F0000000BMa9IAG
        //this page helped alot
        PageReference pageRef = Page.Leader_Board; 
        pageRef.getParameters().put('userid__c', userid);
        pageRef.getParameters().put('name', userid);
        pageRef.getParameters().put('strhtml', strhtml);
        
        System.assertEquals ('200',strhtml);

        
        Test.setCurrentPage(pageRef);
        
        LeaderBoardController testCont = new LeaderBoardController();
        testCont.userid = userid;
        //testCont.SaveInfo();
        system.debug('1st - test for dups');
  
//Test.StopTest();

}


   
    
    static testMethod void checkformissingdata() {
    
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                 'Complete',
                                                 '[{"Name": "sForceTest1"}]',
                                                 null);
        Test.setMock(HttpCalloutMock.class, fakeResponse);
    
        String userid;
        String strhtml;
        //Test.StartTest();
        //test for right data
        //userid='005F0000003FmLpIAK';
        userid = '005500000000000000';

        system.debug ('Userid: ' + userid);

        PageReference pageRef4 = Page.Leader_Board; 
        pageRef4.getParameters().put('userid__c', userid);
        pageRef4.getParameters().put('name', userid);
        pageRef4.getParameters().put('strhtml', strhtml);
        Test.setCurrentPage(pageRef4);
        
        LeaderBoardController testCont4 = new LeaderBoardController();

        testCont4.userid = userid;
        testCont4.SaveInfo();
        System.assertEquals ('0055',userid.substring(0,4));
        System.assertEquals (18,userid.length());
 
        system.debug('4th - right data');
        //Test.StopTest();

    }
    

    
       static testMethod void checkfornodata() {
    
        String userid;
        String strhtml;
        //Test.StartTest();
          
        //test for missing data
        userid='';

        //Leaderboard__c newLB3 = new Leaderboard__c ();
        //newLB3.Name = userid;
        //newLB3.userid__c = userid;
        //newLB3.ProfileUrlLength__c = 100; //strhtml.Length();
        //newLB3.UrlStatus__c = '200' ; //res.getStatus();
        //insert newLB3;
        
        system.debug ('Userid: ' + userid);
        
        //System.assertEquals (0, newLB3.userid__c.length());

        PageReference pageRef3 = Page.Leader_Board; 
        pageRef3.getParameters().put('userid__c', userid);
        pageRef3.getParameters().put('name', userid);
        
        Test.setCurrentPage(pageRef3);
        
        LeaderBoardController testCont3 = new LeaderBoardController();
        testCont3.userid = userid;
        testCont3.SaveInfo();
        system.assertEquals(0,userid.length());
 
        system.debug('3rd - missing data');
        
        //Test.StopTest();

    }
    
    
     static testMethod void checkforshortdata() {
    
        String userid;
        String strhtml;
        //Test.StartTest();
        //test for short length
        userid='005';
 
        //Leaderboard__c newLB = new Leaderboard__c ();
        //newLB.Name = userid;
        //newLB.userid__c = userid;
        //newLB.ProfileUrlLength__c = 100; //strhtml.Length();
        //newLB.UrlStatus__c = '200' ; //res.getStatus();
        //insert newLB;
        
        //system.debug ('Userid: ' + userid);
        
        //System.assertEquals ('005', newLB.userid__c);

        PageReference pageRef1 = Page.Leader_Board; 
        pageRef1.getParameters().put('userid__c', userid);
        pageRef1.getParameters().put('name', userid);
        
        Test.setCurrentPage(pageRef1);
        
        LeaderBoardController testCont1 = new LeaderBoardController();
        testCont1.userid = userid;
        testCont1.SaveInfo();
        system.debug('2nd - test for short length');
        //Test.StopTest();

    }
    
    //https://developer.salesforce.com/blogs/developer-relations/2013/03/testing-apex-callouts-using-httpcalloutmock.html
    static testMethod void checkgethttp() {

    String userid;
    String strhtml;
    string debugSoql = 'Hello';
        //Test.StartTest();
        //test for short length
        userid='0055';
         SingleRequestMock fakeResponse = new SingleRequestMock(300,
                                                 'Complete',
                                                 '[{"Name": "sForceTest1"}]',
                                                 null);
        Test.setMock(HttpCalloutMock.class, fakeResponse);

        PageReference pageRef1 = Page.Leader_Board; 
        pageRef1.getParameters().put('userid__c', userid);
        pageRef1.getParameters().put('name', userid);
        pageRef1.getParameters().put('debugSoql', debugSoql);
        
        pageRef1.getParameters().put('strhmtl', strhtml);
        
        Test.setCurrentPage(pageRef1);
        
        String sortOrder = 'badges__c DESC, totalpoints__c DESC';
        String sortDirection = ' '; 

///
    List<String> someValues = new List<String>{'NOT FOUND', 'ERROR', 'MISSING'};
    List<LeaderBoard__c> leaderboards = Database.query(
        'SELECT name, badges__c, commbadges__c, totalpoints__c, userid__c , profile__c , ProfileUrlLength__c , Superbadges__c, First_Ascent__c ' +
        'FROM LeaderBoard__c ' +
        ' WHERE UrlStatus__c != :someValues ' + 
        ' ORDER BY ' + sortOrder + sortDirection + ' NULLS LAST '
    );



///

        LeaderBoardController testCont1 = new LeaderBoardController();
        testCont1.userid = userid;
        testCont1.SaveInfo();
        testCont1.sortByName();
        testCont1.sortByName();
        testCont1.sortByBadges();
        testCont1.sortByBadges();
        testCont1.sortBytotalpoints();
        testCont1.sortBytotalpoints();
        testCont1.sortBySBadges();
        testCont1.sortBySBadges();
        
        sortOrder = 'name';
        sortDirection = ' ASC ';
        testCont1.sortByName();
        
        sortOrder = 'name';
        sortDirection = ' DESC ';
        testCont1.sortByName();
        
        testCont1.getLeaderboards();


        
        
    
        System.assertEquals(debugSoql,'Hello');

          }
    
    
}