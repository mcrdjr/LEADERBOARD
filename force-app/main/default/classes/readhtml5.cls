//https://cloudyaffair.wordpress.com/2015/07/22/bulk-scheduling-dashboard-refresh/
//http://blog.shivanathd.com/2013/01/how-to-write-batch-class-in.html
//https://developer.salesforce.com/forums/?id=906F00000008yFvIAI - schedule job every 10 minutes
//Schedulereadhtml5RefreshBatchSch c = new Schedulereadhtml5RefreshBatchSch();
//String sch = '0 10 * * * ?';
//System.schedule('Schedule Job2', sch, c);
//10 20 30 40 50 60
//
//Schedulereadhtml5RefreshBatchSch  c = new Schedulereadhtml5RefreshBatchSch();
//String sch = '10 00 * * * ?';
//String sch = '11 30 00,04,08,12,16,20 * * ?';
//System.schedule('Schedule readhtml5-Every 2 Hours', sch, c);

public class readhtml5 implements Database.Batchable<sObject>,Database.AllowsCallouts, Database.Stateful {
    
    public Database.QueryLocator start(Database.BatchableContext bc) { 
        
        List<String> someValues = new List<String>{'NOT FOUND', 'ERROR', 'MISSING'};
            //order by badges__c desc
            String queryString = 'SELECT id, userid__c, profile__c FROM LeaderBoard__c WHERE UrlStatus__c != :someValues and Trailhead_Rank__c Like \'Ranger%\' and profile__c > \'\'  order by lastmodifieddate  '; 
        //my id  and id=\'a00410000012m66AAA\'
        return Database.getQueryLocator(queryString);
    }
    public void execute(Database.BatchableContext bc, List<sObject> scope) { 
        string strhtml;
        try {
            for(Sobject s : scope){
                LeaderBoard__c dr = (LeaderBoard__c)s;
                String requestURL;
                requestURL = 'https://phantomjscloud.com/api/browser/v2/ak-z07m3-g2d2e-7s21v-j43ca-nhv2n/?request={url:%22https://trailblazer.me/id/' +  dr.userid__c + '%22,renderType:%22plaintext%22}';
                //requestURL = 'https://phantomjscloud.com/api/browser/v2/a-demo-key-with-low-quota-per-ip-address/?request={url:%22https://trailblazer.me/id/' +  dr.userid__c + '%22,renderType:%22plaintext%22}';
              
                system.debug('User: ' + dr.userid__c);
                Http http = new Http();
                HttpRequest req = new HttpRequest();
                req.setTimeout(10000);
                req.setEndpoint(requestUrl);
                req.setMethod('GET');
                HTTPResponse res = http.send(req);
                strhtml = res.getBody();
                system.debug('getbody: ' + strhtml);
 
            Integer intStatus = 0;
            intStatus = res.getStatusCode();
 
            if (intStatus != 200) {
                System.Debug('Status:' + intStatus);
                //or might have exceeded phantomjs limits
                //LeaderBoard__c newLB = new LeaderBoard__c();
                //newLB.ID = dr.id;
                //newLB.UrlStatus__c = 'ERROR';
                //update newLB;
                //System.Debug('Looks like this page doesn\'t exist.');
                
                return;
            }
            
               
            integer intUN;
            integer inteli;
            integer ss;
            integer es;
            string strname;
                
                intUN = strhtml.IndexOf('Log In');
                
                String temp=strhtml.mid(intUN + 6, 30);
                System.Debug('temp:' + temp);
                Integer i=0;
                Integer intCount = 0;
                do{
                    if(i<temp.length()){
                        //temp.substirng(i,i+1) is what you use to get each character
                        //system.debug('\n\n'+temp.substring(i,i+1));
                        if (temp.substring(i,i+1)==' '){
                            intCount = intCount + 1;
                            System.Debug('Space:' + i + ':' + temp.mid(0,i));
                            if (intCount == 2) {
                                System.Debug('This is the one we want Space:' + i + ':' + temp.mid(0,i));   
                                strname = temp.mid(0,i);
                                //break;
                            }
                        }
                    }
                    i=i+1;
                }while(i < temp.length());            
                //strname = strhtml.mid(intUN + 6, 20);
                
                system.debug('Name: ' + strname);   
                
                

            
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
                
                string strSB;
                string strhtmlSB = strhtml; 
                intc1 = strhtml.indexof('SUPERBADGES');
                intc1 = intc1 - 4;
                strbc = strhtmlSB.mid(intc1, 4);
                strSB = strbc.replaceAll('[^0-9]', '');
                //system.debug('Position Info: ' + intc1 + ' ' + strbc);
                system.debug('SUPERBADGES: ' + strSB);      
            

            string strCerts;
            string strhtmlCerts = strhtml; 
            intc1 = strhtml.indexof('CERTIFICATIONS');
            intc1 = intc1 - 4;
            strbc = strhtmlCerts.mid(intc1, 4);
            strCerts = strbc.replaceAll('[^0-9]', '');
            //system.debug('Position Info: ' + intc1 + ' ' + strbc);
            system.debug('CERTIFICATIONS: ' + strCerts);    
                if (strCerts == ''){
                    strCerts = '0';
                }
                if (strSB == ''){
                    strSB = '0';
                }     
                

            if (strPoints>'') {
                LeaderBoard__c newLB = new LeaderBoard__c();
                newLB.NameT__c = strname;
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
                
                newLB.SuperBadges__c = decimal.valueof(strSB.replaceAll('[^0-9]', ''));
                newLB.Certs__c = decimal.valueof(strCerts.replaceAll('[^0-9]', ''));
                
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
        readhtml_mcrdjr_plus_1  readhtml_mcrdjr_plus_1OBJ = new readhtml_mcrdjr_plus_1();
        database.executebatch(readhtml_mcrdjr_plus_1OBJ,1);  
    }
}