public class LeaderBoardController {

//other links
//view-source:http://www.salesforcetutorial.com/custom-controllers-controller-extensions/
//https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/langCon_apex_loops_for_SOQL.htm
//http://www.nimbleams.com/blog/2013/1/29/variable-binding-in-dynamic-soql/

    //public String vanity { get; set; }    
    
    public String userid { get; set; }   
    public String strhtml { get; set; } 
    public String debugSoql {get { return 'Hello'; } set;}

    //public integer count;
    List<String> someValues = new List<String>{'NOT FOUND', 'ERROR', 'MISSING'};
    
    public String p { get; set; } // = '';    
    public string andclause { get; set; } // = '';
    public string andclause1 {get; set; }
    public String p1 { get; set; } // = '';
//if (ApexPages.currentPage().getParameters().get('Rank')!='' || ApexPages.currentPage().getParameters().get('Rank')!=null)
//{
//    p = ApexPages.currentPage().getParameters().get('Rank');
//    public string andclause = '';
         
//if (p.length() > 0 || p.length() != null) {
//   public String p1 = p.left(12);
//   andclause = ' and Trailhead_Rank__c == \'' + p1 + '\'';
//   ApexPages.Message apexMessage = new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Query String ...' + andclause );
//   ApexPages.addMessage(apexMessage);
//}
//}


    public PageReference Saveinfo() {
    
        pattern p = pattern.compile('^[a-z][a-z0-9-]{0,127}[a-z0-9]$');
        //pattern p = pattern.compile('^[a-z][a-z0-9-]{4,127}[a-z0-9]$');
        matcher pm = p.matcher(userid);
        if (pm.matches()) {
            System.Debug('match:' + pm);
        } else
        {
            System.Debug('No Match:' + pm);
        }
        
        if (userid.length()!=18) {
            if (pm.matches()) {
                ApexPages.Message apexMessage = new ApexPages.Message(ApexPages.Severity.INFO, 'Looks like a vanity name ... Let it pass');
                ApexPages.addMessage(apexMessage);
                //return null;   
            } else {
                ApexPages.Message apexMessage = new ApexPages.Message(ApexPages.Severity.ERROR, 'Data not in correct format ...');
                ApexPages.addMessage(apexMessage);
                return null;
            }
        }
        

        String s = userid;
        for (Leaderboard__c a : [SELECT userid__c, name from Leaderboard__c where userid__c = : s limit 1 ]) {
            //readhtml2.getbody(userid); 
            system.debug('userid updated: ' + userid);
            ApexPages.Message apexMessage = new ApexPages.Message(ApexPages.Severity.INFO, 'This ID exists, please recheck your ID... ' + a.userid__c);
            ApexPages.addMessage(apexMessage);
            return null;
        }

        
        //if (count == 1 ) {
        //    ApexPages.Message apexMessage = new ApexPages.Message(ApexPages.Severity.ERROR, 'Count ' + count);
        //    ApexPages.addMessage(apexMessage);
        //    return null;
        //}
        
        if (((userid.substring(0,4)=='0055' || userid.substring(0,4) == '0051' || userid.substring(0,4) == '0052') && userid.length()==18) || pm.matches())  {
              
        //http://salesforce.stackexchange.com/questions/105654/get-html-source-code-with-curl-in-salesforce
        //https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_restful_http_httpresponse.htm
        Http h = new Http();

        // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
        HttpRequest req = new HttpRequest();
        //req.setEndpoint('https://developer.salesforce.com/forums/ForumsTrailheadProfile?userId=' + userid);
        //req.setEndPoint('https://trailhead.salesforce.com/users/profiles/'+ userid);
        req.setEndPoint('https://trailblazer.me/id/'+ userid);
        req.setMethod('GET');

        // Send the request, and return a response
        HttpResponse res = h.send(req);
        strhtml = res.getBody(); //res.getBody();
        
        //system.debug('html body:' + strhtml);
        
         system.debug('Start Insert Data...');
        Leaderboard__c newLB = new Leaderboard__c ();
        newLB.Name = userid;
        newLB.userid__c = userid;
        newLB.profile__c = 'https://trailblazer.me/id/' + userid;
        newLB.ProfileUrlLength__c = strhtml.Length();
        newLB.UrlStatus__c = res.getStatus();
        insert newLB;
        ApexPages.Message apexMessage = new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Your changes saved  successfully...It may take a couple of hours to RANK you...Please check back...');
        ApexPages.addMessage(apexMessage);
        system.debug('End Insert...');
        //readhtml2.getbody(userid); 
        return null;
        }
        else
        { 
            ApexPages.Message apexMessage = new ApexPages.Message(ApexPages.Severity.ERROR, 'Data not in correct format ...');
            ApexPages.addMessage(apexMessage);
            return null; 
        }
    }



private String sortOrder = 'badges__c DESC, totalpoints__c DESC';
private String sortDirection = ' '; 
//= ' DESC ';
  

  
public List<LeaderBoard__c> getLeaderboards() {

andclause = '';
//https://developer.salesforce.com/forums/?id=906F000000090keIAA val='\'%' + String.escapeSingleQuotes(inVal.trim()) + '%\'';
string inVal = 'Hide';
string hide1 ='\'%' + String.escapeSingleQuotes(inVal.trim()) + '%\'';
//' LIKE ' + val;

andclause1 = ' and ( not Bio_Data__c LIKE ' + hide1 + ') ';
p = ApexPages.currentPage().getParameters().get('Rank');
//if (p.length() > 0 || p.length() != null) {
if (p != Null) {
p1 = p.left(12);
andclause = ' and Trailhead_Rank__c = \'' + p1 + '\'';
Boolean x10= False;
Boolean x9= False;
Boolean x8= False;
Boolean x7= False;
Boolean x6= False;
Boolean x5= False;
Boolean x4= False;
Boolean x3= False;
Boolean x2= False;
Boolean Ranger =  False;

x10=p.contains('x10');
x9=p.contains('x9');
x8=p.contains('x8');
x7=p.contains('x7');
x6=p.contains('x6');
x5=p.contains('x5');
x4=p.contains('x4');
x3=p.contains('x3');
x2=p.contains('x2');
Ranger = p.contains('Ranger');

if (Ranger)
{
andclause = ' and badges__c >=100 and badges__c <=199';
} 
if (x10) {
andclause = ' and badges__c >999 ';
} 
if (x9) {
andclause = ' and badges__c >=900  and badges__c <=999 ';
} 
if (x8) {
andclause = ' and badges__c >=800  and badges__c <=899 ';
} 
if (x7) {
andclause = ' and badges__c >=700 and badges__c <=799';
} 
if (x6) {
andclause = ' and badges__c >=600 and badges__c <=699';
} 
if (x5) {
andclause = ' and badges__c >=500 and badges__c <=599';
} 
if (x4) {
andclause = ' and badges__c >=400 and badges__c <=499';
} 
if (x3)
{
andclause = ' and badges__c >299 and badges__c <=399';
}
if (x2)
{
andclause = ' and badges__c >199 and badges__c <=299';
} 


//ApexPages.Message apexMessage = new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Query String ...' + andclause );
//ApexPages.addMessage(apexMessage);
}

    List<LeaderBoard__c> leaderboards = Database.query(
        'SELECT name, badges__c, commbadges__c, totalpoints__c, userid__c , profile__c , ProfileUrlLength__c , Superbadges__c, First_Ascent__c, Trailhead_Rank__c, TrailBlazerSince__c ' +
        ' ,AvePoint2Badge__c, Trails__c, Certs__c FROM LeaderBoard__c ' +
        ' WHERE profile__c > \'\' and totalpoints__c >= 0 and UrlStatus__c != :someValues ' + andclause +
        ' ORDER BY ' + sortOrder + sortDirection + ' NULLS LAST LIMIT 1000'
    );
    System.Debug('query: ' + 'SELECT name, badges__c, commbadges__c, totalpoints__c, userid__c , profile__c , ' + 
    'ProfileUrlLength__c , Superbadges__c, First_Ascent__c, Trailhead_Rank__c, TrailBlazerSince__c ' +
        ' ,AvePoint2Badge__c, Trails__c, Certs__c FROM LeaderBoard__c ' +
        ' WHERE totalpoints__c >= 0 and UrlStatus__c != :someValues ' + andclause +
        ' ORDER BY ' + sortOrder + sortDirection + ' NULLS LAST LIMIT 1000');
    return leaderboards;
}

public void sortByName() {
    this.sortOrder = 'name';
    if (this.sortDirection==' ASC ') 
    {this.sortDirection=' DESC ';}
    else 
    {this.sortDirection=' ASC ';}
}

public void sortByBadges() {
    if (this.sortOrder == 'badges__c DESC, totalpoints__c DESC')
    {this.sortOrder = 'badges__c ASC, totalpoints__c ASC';
    this.sortDirection = '';
    }
    else
    {this.sortOrder = 'badges__c DESC, totalpoints__c DESC';
    this.sortDirection = '';
    }
}
    public void sortBytotalpoints() {
        this.sortOrder = 'totalpoints__c';
        if (this.sortDirection==' ASC ') 
        {this.sortDirection=' DESC ';}
        else 
        {this.sortDirection=' ASC ';}
    }

public void sortBySBadges() {
    if (this.sortOrder == 'superbadges__c DESC, totalpoints__c DESC')
    {this.sortOrder = 'superbadges__c ASC, totalpoints__c ASC';
    this.sortDirection = '';
    }
    else
    {this.sortOrder = 'superbadges__c DESC, totalpoints__c DESC';
    this.sortDirection = '';
    }
}

    //AvePoint2Badge__c
    public void sortByScore_old() {
        this.sortOrder = 'AvePoint2Badge__c';
        if (this.sortDirection==' ASC ') 
        {this.sortDirection=' DESC ';}
        else 
        {this.sortDirection=' ASC ';}
    }
    
    
    public void sortByScore() {
    if (this.sortOrder == 'AvePoint2Badge__c DESC, totalpoints__c DESC')
    {this.sortOrder = 'AvePoint2Badge__c ASC, totalpoints__c ASC';
    this.sortDirection = '';
    }
    else
    {this.sortOrder = 'AvePoint2Badge__c DESC, totalpoints__c DESC';
    this.sortDirection = '';
    }
    }
    
    public void sortByTrails() {
    if (this.sortOrder == 'Trails__c DESC, totalpoints__c DESC')
    {this.sortOrder = 'Trails__c ASC, totalpoints__c ASC';
    this.sortDirection = '';
    }
    else
    {this.sortOrder = 'Trails__c DESC, totalpoints__c DESC';
    this.sortDirection = '';
    }
}
    
}