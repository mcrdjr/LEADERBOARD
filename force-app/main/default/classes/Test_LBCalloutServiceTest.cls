@isTest
    private class Test_LBCalloutServiceTest {
    @isTest static void testCallout(){

    //Test.setMock(HttpcalloutMock.class, new WarehouseCalloutService());

    HttpRequest result = new HttpRequest();
    result.setEndPoint('https://trailhead.salesforce.com/users/profiles/005F0000003u97LIAQ');
    result.setHeader('Content-type', 'application/xml');
    result.setMethod('GET');
    

    Test.startTest();
    //WarehouseCalloutService.runWarehouseEquipmentSync();
    Test.stopTest();
    

        }

}