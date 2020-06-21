public class readhtmlTH implements Database.Batchable<sObject>,Database.AllowsCallouts, Database.Stateful {

    public Database.QueryLocator start(Database.BatchableContext bc) { 

        //List<String> someValues = new List<String>{'NOT FOUND', 'ERROR', 'MISSING'};
        //List<LeaderBoard__c> workLB = [SELECT id, userid__c FROM LeaderBoard__c WHERE UrlStatus__c != :someValues order by LastModifiedDate asc limit 10  ];
        
        List<TrailheadData__c> workLB = [SELECT Id FROM TrailheadData__c WHERE name = 'Master' limit 1];
        
        Map<String, TrailheadData__c> oldLB = new Map<String, TrailheadData__c>();
        for (TrailheadData__c lb : workLB) {
            oldLB.put(lb.id, lb);
          }
        system.debug('Size: ' + workLB.size());

        //String queryString = 'SELECT id, userid__c FROM LeaderBoard__c WHERE UrlStatus__c != :someValues '; 
        String queryString = 'SELECT Id FROM TrailheadData__c  limit 1'; 
        return Database.getQueryLocator(queryString);
    }
    public void execute(Database.BatchableContext bc, List<sObject> scope) { 
    string strhtml;
        try {
            for(Sobject s : scope){
                //LeaderBoard__c dr = (LeaderBoard__c)s;
                //string strhtml;
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
                //integer intSBC = strhtml.countMatches('tile-type-super_badge');
                //int1 = strhtml.indexof('Superbadges ('); 
                int1 = strhtml.indexof('en/content/learn/superbadges/superbadge_');
                string strSBC = strhtml.mid(int1,40);
                system.Debug(strSBC);
                
                Integer intSBCount = strhtml.countMatches('en/content/learn/superbadges/superbadge_');
                System.Debug('Count:' + intSBCount);
                
                //integer intSBC = Integer.ValueOf(strSBC.replaceAll('[^0-9]', ''));
                
                Integer intSBC = intSBCount / 2 ;
                system.debug('Superbadges:' + intSBC);
                strData += ' and ' + intSBC + ' Superbadges as of ' + date.today().format();
                system.debug(strData);
                
            
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

            }
        } catch(Exception ex){
            system.debug('>>>>Refresh failed Due to :'+ ex.getmessage());
        }
         
    }
     public void finish(Database.BatchableContext bc) {
    }
}