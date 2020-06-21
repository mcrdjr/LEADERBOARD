@isTest (SeeAllData=true)
private class Test_readhtmlTHBatchClass{
static testMethod void testBatchClass() {

TrailheadData__c newTH = new TrailheadData__c();
newTH.Name__c = 'Master';   
//newTH.id = 'a0141000001ik9QAAQ';
newTH.Trails__c = 0; 
newTH.Modules__c = 0;
newTH.Projects__c = 0;
newTH.SuperBadges__c = 0; 
newTH.THData__c = 'OK';
insert newTH;

Test.startTest();

readhtmlTH bc = new readhtmlTH();

  String userid;
  string strData = 'Junk';
  string strModules='0';
  string strProjects = '0';
  string strTrails = '0';
  integer intSBC = 0;
       
        SingleRequestMock fakeResponse1 = new SingleRequestMock(300,'Complete','https://trailhead.salesforce.com/trails trailhead-active-items 100]', null);
        Test.setMock(HttpCalloutMock.class, fakeResponse1);     
        //TrailheadData.data(); 
  
        //SingleRequestMock fakeResponse2 = new SingleRequestMock(500,'Complete','https://trailhead.salesforce.com/modules trailhead-active-items 200 ]', null);
        //Test.setMock(HttpCalloutMock.class, fakeResponse2);     
        //TrailheadData.data(); 
        
        //SingleRequestMock fakeResponse3 = new SingleRequestMock(500,'Complete','https://trailhead.salesforce.com/projects trailhead-active-items 300 ]', null);
        //Test.setMock(HttpCalloutMock.class, fakeResponse3);     
        //TrailheadData.data(); 
   
        //SingleRequestMock fakeResponse4 = new SingleRequestMock(500,'Complete','https://trailhead.salesforce.com/super_badges trailhead-active-items]', null);
        //Test.setMock(HttpCalloutMock.class, fakeResponse4);     
        //TrailheadData.data(); 
        integer int1;
  
  
 String strid = [SELECT Id FROM TrailheadData__c WHERE name = 'Master' limit 1].id;
    system.debug('Master ID: ' + strid);
 //   TrailheadData__c newTH = new TrailheadData__c();
 //   newTH.Name__c = 'Master';
 //   newTH.id = strid;
 //   newTH.Trails__c = 0; 
 //   newTH.Modules__c = 0;
 //   newTH.Projects__c = 0;
 //   newTH.SuperBadges__c = 0; 
 //   newTH.THData__c = strData;
 //   update newTH;


Database.executeBatch(bc, 1);
Test.stopTest();
}

}