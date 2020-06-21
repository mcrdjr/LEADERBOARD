@isTest (SeeAllData=true)
private class Test2_readhtml2{
  static testMethod void Test_readhtml2(){ 
  String userid;
  string strpoints = '1000';
        
        SingleRequestMock fakeResponse2 = new SingleRequestMock(200,'Complete','Superbadges]', null);
        Test.setMock(HttpCalloutMock.class, fakeResponse2);     
  readhtml2.getbody('005500000060PqcAAE'); 
  //005500000060PqcAAE
  //005F0000004ss8EIAQ
    
       if (strpoints > '' ) {   
             LeaderBoard__c newLB = new LeaderBoard__c();
             newLB.NameT__c = 'Michael Rucker';
             newLB.ID = 'a00410000012m66AAA';
             newLB.BadgesT__c = 1;
             newLB.First_AscentT__c = 1;
             newLB.TotalPointsT__c = 1;
             newLB.SuperBadgesT__c = 1; 
             
             //live fields
             newLB.Badges__c = 1; //intCB;  // - intCommunityB - intCBIP;
             newLB.First_Ascent__c = 1;
             newLB.TotalPoints__c = 1;
             newLB.SuperBadges__c = 1; 
             newLB.Name = 'Michael Rucker';

             update newLB;
             }
              
  }
  }