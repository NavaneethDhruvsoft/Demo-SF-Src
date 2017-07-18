public class mycntrl 
{

    Public String Response{Set;Get;}
    Public String AToken{Set;Get;}
    Public String WebServiceResponse{Set;Get;}
    public string resbody{set;get;}
    public position__c p;
    public string posid {get;set;}
    public string posid1 {get;set;}
    public string name {get;set;}
    public string email {get;set;}
    public string cl {get;set;}
    Public list<String> Posname{Set;Get;}
    Public list<String> posid2{Set;Get;}
    public webser__c ws= webser__c.getInstance();
    
   
   
     public pagereference redirect()
    {
        string url1 ='https://login.salesforce.com/services/oauth2/authorize?response_type=code&client_id=3MVG9ZL0ppGP5UrDcnnGVlPsj6Y1veRtfzVubFACP5ebolOskROcEVwhE_oqvdlmkIs18E9gMLknHPZuYq09I&redirect_uri=https://c.ap2.visual.force.com/apex/vfws'; 
        pagereference pg  = new pagereference(url1 );
        return pg;
    }
    
     public void RefreshAndAccessToken()
    {    
        String code=Apexpages.currentpage().getParameters().get('code');
        String endpoint='https://login.salesforce.com/services/oauth2/token?grant_type=authorization_code&client_id=3MVG9ZL0ppGP5UrDcnnGVlPsj6Y1veRtfzVubFACP5ebolOskROcEVwhE_oqvdlmkIs18E9gMLknHPZuYq09I&client_secret=7402946565675167536&redirect_uri=https://c.ap2.visual.force.com/apex/vfws&code='+code;
        HttpRequest req=new HttpRequest();
        req.setEndPoint(endpoint);        
        req.setMethod('POST');
        
        Http p=new Http();
        
        HttpResponse res=new HttpResponse();
        
        res = p.send(req);
        Response= 'Request Status ::'+res.getStatus()+'\n Status code ::'+res.getStatusCode()+'\n Response Body ::\n '+res.getBody();
        
                
                
        JSonParser par= JSON.CreateParser(res.getBody());
        
        parseMe pp=new parseMe();
        while(par.nextToken()!=null)
        {
            if(par.getCurrentToken() == JsonToken.START_OBJECT)
            {
                pp=(parseMe)par.readvalueas(parseMe.class);
            }
            
        }
        AToken = pp.access_token;
        
    }
        
    Public class parseMe
    {
        Public  String access_token;
        Public String token_type;
    }
    
    Public class parseMe1
    {
        Public  String name;
        Public String id;
    }
    Public void CallWebservice()
    {
        if(ws.Active__c == true)
        {
            posname = new list<string>();
            posid2 = new list<string>();
            String ePoint= 'https://ap2.salesforce.com/services/apexrest/positions';
            HttpRequest req=new HttpRequest();
            req.setEndPoint(ePoint);
            req.setMethod('GET');
            req.setHeader('Authorization','Bearer '+AToken);
            
            Http p=new Http();
            HttpResponse res = p.send(req);
            WebServiceResponse = 'Request Status ::'+res.getStatus()+'\n Status code ::'+res.getStatusCode()+'\n Response Body ::\n '+res.getBody();
            resbody = res.getbody();
            string resbd = resbody .replaceAll('[__c]',' ');
            resbody = resbd;
            system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>'+res+'<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<');
            
            JSonParser par1= JSON.CreateParser(res.getBody());
            
            parseMe1 pp=new parseMe1();
            while(par1.nextToken()!=null)
            {
                if(par1.getCurrentToken() == JsonToken.START_OBJECT)
                {
                    pp=(parseMe1)par1.readvalueas(parseMe1.class);
                }
                Posname.add(pp.name);
                posid2.add(pp.id);
                
            }
        }
        else
        {
             WebServiceResponse = 'Oooooopsssss.........Out of Service.......';
        }
   }
        
         
     
    //a0528000001IG8XAAW
    
    Public void GETPositionDetail()
    {
        String ePoint= 'https://ap2.salesforce.com/services/apexrest/GETPositionDetail/'+posid;
        HttpRequest req=new HttpRequest();
        req.setEndPoint(ePoint);
        req.setMethod('GET');
        req.setHeader('Authorization','Bearer '+AToken);
        
        Http p=new Http();
       HttpResponse res = p.send(req);
        WebServiceResponse = 'Request Status ::'+res.getStatus()+'\n Status code ::'+res.getStatusCode()+'\n Response Body ::\n '+res.getBody();
        resbody = res.getbody();
        system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>'+res+'<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<');
         
         
        
    }
    
    Public void POSTApplication()
    {
        String ePoint= 'https://ap2.salesforce.com/services/apexrest/POSTApplication/';
        HttpRequest req=new HttpRequest();
        req.setEndPoint(ePoint);
        req.setMethod('POST');
      //  req.setHeader('Authorization','Bearer '+AToken);
        String fn = '"name":"'+name+'",';
       //String ln = '"lname":"'+lname+'",';
       String em = '"email":"'+email+'",';
       String cl1 = '"coverletter":"'+cl+'"';
       String pid='"posid":"'+posid+'",';
       String body='{'+fn+em+pid+cl1+'}';
       // string body = '{"posid":"'+posid+'","name":"'+name+'","email":"'+email+'","coverletter":"'+cl+'"}';
        req.setBody(body);
        //req.setBody('posid='+EncodingUtil.urlEncode(posid, 'UTF-8')+'&name='+EncodingUtil.urlEncode(name , 'UTF-8')+'&email='+EncodingUtil.urlEncode(email, 'UTF-8')+'&coverletter='+EncodingUtil.urlEncode(cl, 'UTF-8'));
        req.setCompressed(true); // otherwise we hit a limit of 32000
         req.setHeader('Authorization','OAuth '+UserInfo.getSessionId());
       req.setHeader('Content-Type', 'application/json');
        Http p=new Http();
       HttpResponse res = p.send(req);
        WebServiceResponse = 'Request Status ::'+res.getStatus()+'\n Status code ::'+res.getStatusCode()+'\n Response Body ::\n '+res.getBody();
        resbody = res.getbody();
        //SUBSTITUTE(resbody,'__c','');
        resbody .replace('__c','');
        //resbody = res.getbody();
        
        system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>'+res+'<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<');
         
           
        
    }
   
    
}