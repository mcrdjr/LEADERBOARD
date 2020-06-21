@isTest
public with sharing class Test_readhtml5CalloutServiceMock {

    private static final String WAREHOUSE_URL = 'https://trailhead.salesforce.com/users/profiles/005F0000003u97LIAQ';

    @future(callout=true)
    public static void runWarehouseEquipmentSync(){

        Http h = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndPoint(WAREHOUSE_URL);
        request.setHeader('Content-type', 'text/xml;charset=UTF-8');
        request.setMethod('GET');

        HttpResponse response = h.send(request);
        
    }
}