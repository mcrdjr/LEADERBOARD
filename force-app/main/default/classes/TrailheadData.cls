public class TrailheadData {
//manually run this to update Trailhead Website Data 
//https://developer.salesforce.com/docs/atlas.en-us.apex_workbook.meta/apex_workbook/apex_scheduling_1.htm

    //public String controllerValue;

    //public void setControllerValue (String s) {
    //    controllerValue = s.toUpperCase();
    //}
    //public static String getControllerValue() {
    //    return controllerValue;
    //}

public static string data() {
    string strhtml;
    string strData;
    Http h = new Http();
    HttpRequest req = new HttpRequest();
    
    req.setEndPoint('https://trailhead.salesforce.com/trails');
    req.setMethod('GET');
    HttpResponse res = h.send(req);
    strhtml = res.getBody(); 
    integer int1 = strhtml.indexof('trailhead-active-items');
    string strTrails = strhtml.mid(int1,40);
    system.debug('Trails Count: ' + strTrails.replaceAll('[^0-9]', ''));
    strData = 'There are currently (ACTIVE) ' + strTrails.replaceAll('[^0-9]', '') + ' Trails, ' + '\n';
    //return('Trails Count: ' + strTrails.replaceAll('[^0-9]', ''));
    
    
    req.setEndPoint('https://trailhead.salesforce.com/modules');
    req.setMethod('GET');
    res = h.send(req);
    strhtml = res.getBody(); 
    int1 = strhtml.indexof('trailhead-active-items');
    string strModules = strhtml.mid(int1,40);
    system.debug('Modules Count: ' + strModules.replaceAll('[^0-9]', ''));
    strData +=  strModules.replaceAll('[^0-9]', '') + ' Modules, ' + '\n';
    //return('Modules Count: ' + strModules.replaceAll('[^0-9]', ''));
    
    
    //HttpRequest req = new HttpRequest();
    req.setEndPoint('https://trailhead.salesforce.com/projects');
    req.setMethod('GET');
    res = h.send(req);
    strhtml = res.getBody(); 
    int1 = strhtml.indexof('trailhead-active-items');
    string strProjects = strhtml.mid(int1,40);
    system.debug('Projects Count: ' + strProjects.replaceAll('[^0-9]', ''));
    strData += strProjects.replaceAll('[^0-9]', '') + ' Projects ' + '\n';
    //return('Projects Count: ' + strProjects.replaceAll('[^0-9]', ''));
    
    //HttpRequest req = new HttpRequest();
    req.setEndPoint('https://trailhead.salesforce.com/superbadges');
    req.setMethod('GET');
    res = h.send(req);
    strhtml = res.getBody(); 
    //integer intSBC = strhtml.countMatches('_70/learn/Superbadges/');
    //
    int1 = strhtml.indexof('Superbadges ('); 
    string strSBC = strhtml.mid(int1,20);
    integer intSBC = Integer.ValueOf(strSBC.replaceAll('[^0-9]', ''));

    system.debug('Superbadges:' + intSBC);
    strData += ' and ' + intSBC + ' Superbadges as of ' + date.today().format();
    //return('Superbadges:' + intSBC);
    system.debug(strData);

    //https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/langCon_apex_SOQL_single_row.htm
    String strid = [SELECT Id FROM TrailheadData__c WHERE name = 'Master' limit 1].id;
    system.debug('Master ID: ' + strid);
    TrailheadData__c newTH = new TrailheadData__c();
    newTH.Name__c = 'Master';
    newTH.id = strid;
    newTH.Trails__c = decimal.valueof(strTrails.replaceAll('[^0-9]', '')); 
    newTH.Modules__c = decimal.valueof(strModules.replaceAll('[^0-9]', ''));
    newTH.Projects__c = decimal.valueof(strProjects.replaceAll('[^0-9]', ''));
    newTH.SuperBadges__c = intSBC; 
    newTH.THData__c = strData;
    update newTH;

    return(strData);
    }
}