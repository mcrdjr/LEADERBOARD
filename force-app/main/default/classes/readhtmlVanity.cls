//public class readhtmlVanity {
//https://trailhead.salesforce.com/me/tmyersucop
public class readhtmlVanity {
    public static void getbody(string userid) {
        Http h = new Http();
        string strhtml;
        integer intUN;
        integer inteli;
        integer ss;
        integer es;
        string strname;
        integer points;
        string requestURL;
        string loc;
        List<String> someValues = new List<String>{'NOT FOUND', 'ERROR', 'MISSING'};
            
            List<LeaderBoard__c> workLB = [SELECT id, userid__c, profile__c FROM LeaderBoard__c WHERE userid__c = :userid  ];
        Map<String, LeaderBoard__c> oldLB = new Map<String, LeaderBoard__c>();
        for (LeaderBoard__c lb : workLB) {
            oldLB.put(lb.id, lb);
            //system.debug(lb.id + ' ' + lb.userid__c);
        }
        //system.debug('Size: ' + workLB.size());
        
        List<LeaderBoard__c> LBToInsert = new List<LeaderBoard__c>();
        
        for(LeaderBoard__c nLB: workLB)
        {
            //system.debug('Next ID: ' + nlb.id + ' ' + nlb.userid__c);
            HttpRequest req = new HttpRequest();
            //requestURL = 'https://trailhead.salesforce.com/users/profiles/'+ nLB.userid__c;
            requestURL = 'https://trailhead.salesforce.com/en/me/' + userid;
            //requestURL = nLB.Profile__c;
            loc = requestURL;
            system.debug(requestURL);
            req.setEndPoint(requestURL);
            req.setTimeout(20000);
            req.setMethod('GET');
            
            HttpResponse res = h.send(req);
            strhtml = res.getBody(); //res.getBody();
            //system.debug('getbody: ' + strhtml.length());
            //system.debug('status 1' + res.getHeader('Location'));   
            system.debug('status code 1 ' + res.getStatusCode());     
            
            ///////////

            boolean redirect = false;
            integer i = 0;
			/*
            if(res.getStatusCode() >=300 && res.getStatusCode() <= 307 && res.getStatusCode() != 306) {
                do {
                    system.Debug(res.getStatusCode() + ' ' + redirect + ' ' + Limits.getCallouts() + ' ' + Limits.getLimitCallouts());
                    redirect = false; // reset the value each time
                    loc = res.getHeader('Location'); // get location of the redirect
                    
                    //System.Debug('location1:' + loc);
                    if(loc == null) {
                        redirect = false;
                        continue;
                    }
                    req = new HttpRequest();
                    req.setEndpoint(loc);
                    req.setTimeout(20000);
                    req.setMethod('GET');
                    res = h.send(req);
                    System.Debug('location2:' + loc);
                    //if(res.getStatusCode() != 500) { // 500 = fail
                        if(res.getStatusCode() >=300 && res.getStatusCode() <= 307 && res.getStatusCode() != 306) {
                            redirect= true;
                            loc = res.getHeader('Location'); 
                        }
                    //}
                    i++;
                } while (Limits.getCallouts() <= i || res.getStatusCode() != 200 );
                //while (redirect && Limits.getCallouts() != Limits.getLimitCallouts());
            } 
            */
            strhtml = res.getBody(); 
  
            integer intSB_New = strhtml.countmatches('70/learn/superbadges/superbadge-');
            System.Debug('intSB_New:' + intSB_New);
            integer intSB_New1 = strhtml.countmatches('70/learn/superbadges/superbadge_');
            System.Debug('intSB_New1:' + intSB_New1);
            
            integer intSB1 = strhtml.countmatches('superbadges/trailhead');
            System.Debug('intSB1:' + intSB1);
            integer intSB = intSB_New + intSB1 + intSB_New1;
            system.debug('Total SB: ' + intSB);
            //intUN = strhtml.IndexOf('data-test-user-name');
            intUN = strhtml.indexof('og:title');
            //inteli = strhtml.IndexOf('</h1>', intUN + 1);
            inteli = strhtml.IndexOf('/>', intUN);
            ss = intUN + 42;  //was 21
            es = (inteli - intUN - 44 );
            strname = strhtml.mid(ss, es);
            System.Debug('pos:' + intUN + ':' + inteli + ':' + ss + ':' + es);
            system.debug('Name: ' + strname);   

            integer intCommunityB = 0;
            intCommunityB = strhtml.countMatches('/images/trailhead/badges/community');
            //system.debug('Community: ' + intCommunityB);
            
            integer intProjectB = 0;
            intProjectB = strhtml.countMatches('/images/trailhead/badges/projects');
            
            integer intFirstAscent = 0;
            intFirstAscent = strhtml.countMatches('_flag.png'); 
            //system.debug('1st Ascent: ' + intFirstAscent);

            string strPoints;
            string strCB; 
            integer intc1 = strhtml.indexof('data-test-badges-count');
            intc1 = intc1 + 23;
            string strbc = strhtml.mid(intc1, 3);
            strCB = strbc.replaceAll('[^0-9]', '');
            //system.debug('Position Info: ' + intc1 + ' ' + strbc);
            system.debug('Badges: ' + strCB);
            
            string strP;
            string strhtmlP = strhtml.mid(intc1+1,1000);
            intc1 = strhtmlP.indexof('data-test-points-count');
            intc1 = intc1 + 23;
            strbc = strhtmlP.mid(intc1, 8);
            strP = strbc.replaceAll('[^0-9]', '');
            system.debug('Points: ' + strP);
            strPoints = strP;
            
            //data-test-trails-count
            string strTrails;
            //system.debug('html:' + strhtml);
            string strhtmlTrails = strhtml; //.mid(intc1+1,1000);
            //system.debug('html:' + strhtmlTrails);
            intc1 = strhtmlTrails.indexof('data-test-trails-count');
            system.debug('trail:' + intc1);
            intc1 = intc1 + 23;
            strbc = strhtmlTrails.mid(intc1, 8);
            strTrails = strbc.replaceAll('[^0-9]', '');
            system.debug('Trails: ' + strTrails);      
            
            string jsondata;
            integer intj1 = strhtml.indexof('all:');
            integer intj2 = strhtml.indexof('"}]');
            jsondata = strhtml.mid(intj1+5,intj2-intj1+3);

            if (1==1) {
                //create a document
                Document d = new Document(); 
                d.Name = 'Profile for Michael Rucker'; 
                String myContent = '{"all" : ' + jsondata + '}'; 
                d.Body = Blob.valueOf(myContent); 
                d.ContentType = 'text/plain';
                d.Type = 'txt';
                d.FolderID= '00541000000lGUrAAM';
                insert d;
            }

            integer intsince = strhtml.indexof('profile/AboutMe');
            System.Debug('Found Since:' + intsince);
            string strSince = strhtml.mid(intsince, 2500);
            integer intdiv = strSince.indexof('created_at');
            system.debug('created_at loc: ' + intdiv);
            string strca = strSince.mid(intdiv+23,10);
            system.debug('created_at string: ' + strca);

            if (strPoints>'') {
                LeaderBoard__c newLB = new LeaderBoard__c();
                newLB.NameT__c = strname;
                newLB.ID = nlb.id;

                newLB.BadgesT__c = decimal.valueof(strCB); //intCB; // - intCommunityB - intCBIP;
                newLB.First_AscentT__c = intFirstAscent;// /2;
                newLB.CommBadges__c = intCommunityB;
                newLB.TotalPointsT__c = decimal.valueof(strPoints.replaceAll('[^0-9]', ''));
                newLB.SuperBadgesT__c = intSB; //intSB11 +  intSB12 +  intSB13 + intSB14 +  intTSB; 
                
                //live fields
                newLB.Badges__c = decimal.valueof(strCB); //intCB;  // - intCommunityB - intCBIP;
                newLB.First_Ascent__c = intFirstAscent;// /2;
                newLB.TotalPoints__c = decimal.valueof(strPoints.replaceAll('[^0-9]', ''));
                newLB.SuperBadges__c = intSB; //intSB11 +  intSB12 +  intSB13 + intSB14 +  intTSB; 
                newLB.Name = strname;

                newLB.Profile__c = loc;
                newLB.TrailblazerSince__c = strca; //strSince.mid(0,intdiv);
                
                newLB.Trails__c = decimal.valueof(strTrails.replaceAll('[^0-9]', ''));
                //commented out for now
                update newLB;
                System.Debug('Updated OK');
            }
        }
    }  
}