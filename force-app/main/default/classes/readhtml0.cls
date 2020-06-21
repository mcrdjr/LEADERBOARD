//use this to run manually
//readhtml0  refreadhtml0Obj = new readhtml0();
//database.executebatch(refreadhtml0Obj,1);

public class readhtml0 implements Database.Batchable<sObject>,Database.AllowsCallouts, Database.Stateful {
    
    public Database.QueryLocator start(Database.BatchableContext bc) { 
        
        List<String> someValues = new List<String>{'NOT FOUND', 'ERROR', 'MISSING'};
            //order by badges__c desc
            String queryString = 'SELECT id, userid__c, profile__c FROM LeaderBoard__c WHERE UrlStatus__c != :someValues and profile__c > \'\'  and Badges__c = 0 order by lastmodifieddate  '; 
        //my id  and id=\'a00410000012m66AAA\'
        return Database.getQueryLocator(queryString);
    }
    public void execute(Database.BatchableContext bc, List<sObject> scope) { 
        string strhtml;
        try {
            for(Sobject s : scope){
                LeaderBoard__c dr = (LeaderBoard__c)s;
                String requestURL;
                //key for mcrdjr@gmail.com
                //ak-xzh5z-8n5h7-fcs7k-680cx-75a05
                 requestURL = 'https://phantomjscloud.com/api/browser/v2/a-demo-key-with-low-quota-per-ip-address/?request={url:%22https://trailblazer.me/id?uid=' +  dr.userid__c + '%26cmty=trailhead%22,renderType:%22plaintext%22}';
                System.Debug(requestURL);
                system.debug('User: ' + dr.userid__c);
                Http http = new Http();
                HttpRequest req = new HttpRequest();
                req.setTimeout(10000);
                req.setEndpoint(requestUrl);
                req.setMethod('GET');
                HTTPResponse res = http.send(req);
                strhtml = res.getBody();
                //system.debug('getbody: ' + strhtml);
 
            Integer intStatus = 0;
            intStatus = res.getStatusCode();
 
            if (intStatus != 200) {
                //System.Debug('Status:' + intStatus);
                //LeaderBoard__c newLB = new LeaderBoard__c();
                //newLB.ID = dr.id;
                //newLB.UrlStatus__c = 'ERROR';
                //update newLB;
                System.Debug('Looks like this page doesn\'t exist.');
                
                return;
            }
            
               
            integer intUN;
            integer inteli;
            integer ss;
            integer es;
            string strname;

            
                string strPoints;
                string strCB; 
                integer intc1 = strhtml.indexof('Badges');
                intc1 = intc1 - 10;
                string strbc = strhtml.mid(intc1, 10);
                strCB = strbc.replaceAll('[^0-9]', '');
                //system.debug('Position Info: ' + intc1 + ' ' + strbc);
                system.debug('Badges: ' + strCB);
                
                string strP;
                intc1 = strhtml.indexof('Points');
                intc1 = intc1 - 8;
                strbc = strhtml.mid(intc1, 7);
                strP = strbc.replaceAll('[^0-9]', '');
                //system.debug('Position Info: ' + intc1 + ' ' + strbc);
                system.debug('Points: ' + strP);
                strPoints = strP;
                
                string strTrails;
                string strhtmlTrails = strhtml; 
                intc1 = strhtml.indexof('Trails');
                intc1 = intc1 - 4;
                strbc = strhtmlTrails.mid(intc1, 4);
                strTrails = strbc.replaceAll('[^0-9]', '');
                //system.debug('Position Info: ' + intc1 + ' ' + strbc);
                system.debug('Trails: ' + strTrails);   
                

            if (strPoints>'') {
                LeaderBoard__c newLB = new LeaderBoard__c();
                //newLB.NameT__c = strname;
                newLB.ID = dr.id;

                newLB.BadgesT__c = decimal.valueof(strCB); //intCB; // - intCommunityB - intCBIP;
                //newLB.First_AscentT__c = intFirstAscent;// /2;
                //newLB.CommBadges__c = intCommunityB;
                newLB.TotalPointsT__c = decimal.valueof(strPoints.replaceAll('[^0-9]', ''));
                //newLB.SuperBadgesT__c = intSB; //intSB11 +  intSB12 +  intSB13 + intSB14 +  intTSB; 
                
                //live fields
                newLB.Badges__c = decimal.valueof(strCB); //intCB;  // - intCommunityB - intCBIP;
                //newLB.First_Ascent__c = intFirstAscent;// /2;
                newLB.TotalPoints__c = decimal.valueof(strPoints.replaceAll('[^0-9]', ''));
                //newLB.SuperBadges__c = intSB; //intSB11 +  intSB12 +  intSB13 + intSB14 +  intTSB; 
                //newLB.Name = strname;

                newLB.Profile__c = 'https://trailblazer.me/id/' + dr.userid__c ;
                //newLB.TrailblazerSince__c = strca; //strSince.mid(0,intdiv);
                
                newLB.Trails__c = decimal.valueof(strTrails.replaceAll('[^0-9]', ''));
                //commented out for now
                newLB.UrlStatus__c = 'OK';
                update newLB;
                System.Debug('Updated OK');

                
                }
            }
        } catch(Exception ex){
            system.debug('>>>>Refresh failed Due to :'+ ex.getmessage());
        }
        
    }
    public void finish(Database.BatchableContext bc) {
    }
}