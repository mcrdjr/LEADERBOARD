public class readhtml2 {
    //@InvocableMethod(label='Get Data ' description='Gets Data from TrailBlazer.me')
    //public static void getbody(List <String> userid) {
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
            HttpRequest req = new HttpRequest();
            //requestURL = 'https://phantomjscloud.com/api/browser/v2/ak-z07m3-g2d2e-7s21v-j43ca-nhv2n/?request={url:%22https://trailblazer.me/id/maverick%22,renderType:%22plaintext%22}';
            //requestURL = 'https://phantomjscloud.com/api/browser/v2/ak-z07m3-g2d2e-7s21v-j43ca-nhv2n/?request={url:%22https://trailblazer.me/id/' +  nLB.userid__c + '%22,renderType:%22html%22}';
            
            requestURL = 'https://phantomjscloud.com/api/browser/v2/ak-z07m3-g2d2e-7s21v-j43ca-nhv2n/?request={url:%22https://trailblazer.me/id/' +  nLB.userid__c + '%22,renderType:%22plaintext%22}';
            
            
            //html
            //requestURL = 'https://phantomjscloud.com/api/browser/v2/a-demo-key-with-low-quota-per-ip-address/?request={url:%22https://trailblazer.me/id/' +  nLB.userid__c + '%22,renderType:%22plaintext%22}';

            loc = requestURL;
            system.debug(requestURL);
            req.setEndPoint(requestURL);
            req.setTimeout(20000);
            req.setMethod('GET');
            HttpResponse res = h.send(req);
            strhtml = res.getBody(); //res.getBody();
            system.debug('getbody: ' + strhtml.length());
            system.debug('getbody: ' + strhtml);
            Integer intStatus = 0;
            intStatus = res.getStatusCode();
 
            if (intStatus != 200) {
                System.Debug('Status:' + intStatus);
                
                //LeaderBoard__c newLB = new LeaderBoard__c();
                //newLB.ID = nlb.id;
                //newLB.UrlStatus__c = 'ERROR';
                //update newLB;
                System.Debug('Looks like this page doesn\'t exist.');
                
                return;
            }

            //System.Debug('Create Document');
            //create a document
            
            /*
            Document d = new Document(); 
            d.Name = 'Profile for ' + nLB.userid__c; 
            //String myContent = '{"all" : ' + jsondata + '}'; 
            String myContent = strhtml;
            d.Body = Blob.valueOf(myContent); 
            d.ContentType = 'text/plain';
            d.Type = 'txt';
            d.FolderID= '00541000000lGUrAAM';
            insert d;
            return;
			*/

    
            //intUN = strhtml.IndexOf('data-test-user-name');
            //intUN = strhtml.indexof('og:title');
            //inteli = strhtml.IndexOf('</h1>', intUN + 1);
            //inteli = strhtml.IndexOf('/>', intUN);
            //ss = intUN + 42;  //was 21
            //es = (inteli - intUN - 44 );
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

            //integer intCount = 0;
            //intCount = strhtml.countMatches('tds-tally__count tds-tally__count_success'); 
            //System.Debug('tds-tally__count tds-tally__count_success: ' + intCount);
            
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
            intc1 = strhtml.indexof('CERTIFICATION');
            intc1 = intc1 - 4;
            strbc = strhtmlCerts.mid(intc1, 4);
            strCerts = strbc.replaceAll('[^0-9]', '');
            
            if (strCerts == ''){
                strCerts = '0';
            }
            if (strSB == ''){
                strSB = '0';
            } 
            
            //system.debug('Position Info: ' + intc1 + ' ' + strbc);
            system.debug('CERTIFICATIONS: ' + strCerts);    
            
            /*
            integer intsince = strhtml.indexof('profile/AboutMe');
            System.Debug('Found Since:' + intsince);
            string strSince = strhtml.mid(intsince, 2500);
            integer intdiv = strSince.indexof('created_at');
            system.debug('created_at loc: ' + intdiv);
            string strca = strSince.mid(intdiv+23,10);
            system.debug('created_at string: ' + strca);
			*/
            
            if (strPoints>'') {
                LeaderBoard__c newLB = new LeaderBoard__c();
                newLB.NameT__c = strname;
                newLB.ID = nlb.id;

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

                newLB.Profile__c = 'https://trailblazer.me/id/' + nLB.userid__c ;
                //newLB.TrailblazerSince__c = strca; //strSince.mid(0,intdiv);
                
                newLB.Trails__c = decimal.valueof(strTrails.replaceAll('[^0-9]', ''));
                //commented out for now
                //
                newLB.UrlStatus__c = 'OK';
                update newLB;
                System.Debug('Updated OK');
            }
        }
    }  
}