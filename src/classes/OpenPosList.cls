global class OpenPosList {

    public OpenPosList(ApexPages.StandardSetController controller) {

           
    }

    public position__c position{get;set;}

    public string searchkey{set;get;}
    public string skills{set;get;}
    public string respon{set;get;}
    public string edu{set;get;}
    public integer anInt{set;get;}
    public string city{set;get;}
    public decimal minpay{set;get;}
    public candidate__c cand{get;set;}
    public candidate__c cand1{get;set;}
    public application__c app{get;set;}
    public integer index{set;get;}
    public position__c pos1 = new position__c();
    global String posid { get; set; }
    public position__c pos2{get;set;}
    public String selectedlocationId { get; set; }
    public list<position__c> poslist{set;get;}
    public list<position__c> poslist1{set;get;}
    
    //recapctcha
    
    private static String baseUrl = 'https://www.google.com/recaptcha/api/verify';
    private static String privateKey = '6LfYOAsTAAAAAO1Jjl2vO7w4QLLHTAm1ulLMiAWt';
    public String publicKey { 
        get { return '6LfYOAsTAAAAAN3i7tKNMqeQjtavwrVthM9iQQSm'; }  //6LfYOAsTAAAAAN3i7tKNMqeQjtavwrVthM9iQQSm
    } 
    
    public String challenge { 
        get {
            return ApexPages.currentPage().getParameters().get('recaptcha_challenge_field');
        }
    }
    public String response  { 
        get {
            return ApexPages.currentPage().getParameters().get('recaptcha_response_field');
        }
    }

    public Boolean verified { get; private set; }
    
   // public reCAPTCHA() {
       // this.verified = false;
   // }
    
    public PageReference verify() {
        System.debug('reCAPTCHA verification attempt');
        // On first page load, form is empty, so no request to make yet
        if ( challenge == null || response == null ) { 
            System.debug('reCAPTCHA verification attempt with empty form');
            return null; 
        }
                    
        HttpResponse r = makeRequest(baseUrl,
            'privatekey=' + privateKey + 
            '&remoteip='  + remoteHost + 
            '&challenge=' + challenge +
            '&response='  + response
        );
        
        if ( r!= null ) {
            this.verified = (r.getBody().startsWithIgnoreCase('true'));
        }
        
        if(this.verified) {
            // If they pass verification, you might do something interesting here
            // Or simply return a PageReference to the "next" page
            return null;
        }
        else {
            // stay on page to re-try reCAPTCHA
            return null; 
        }
    }
    private static HttpResponse makeRequest(string url, string body)  {
        HttpResponse response = null;
        HttpRequest req = new HttpRequest();   
        req.setEndpoint(url);
        req.setMethod('POST');
        req.setBody (body);
        try {
            Http http = new Http();
            response = http.send(req);
            System.debug('reCAPTCHA response: ' + response);
            System.debug('reCAPTCHA body: ' + response.getBody());
        } catch(System.Exception e) {
            System.debug('ERROR: ' + e);
        }
        return response;
    }   
    
    private String remoteHost { 
        get { 
            String ret = '127.0.0.1';
            // also could use x-original-remote-host 
            Map<String, String> hdrs = ApexPages.currentPage().getHeaders();
            if (hdrs.get('x-original-remote-addr')!= null)
                ret =  hdrs.get('x-original-remote-addr');
            else if (hdrs.get('X-Salesforce-SIP')!= null)
                ret =  hdrs.get('X-Salesforce-SIP');
            return ret;
        }
    }
    
    //recaptcha
    
    public OpenPosList(ApexPages.StandardController controller)
    {
         position = new position__C();
        poslist = new list<position__c>([select id,name,status__c,open_date__c,close_date__c,Skills_Required__c,Responsibilities__c,Educational_Requirements__c,location__c,min_pay__c  from position__c where status__c = 'open - approved']);
        cand= new candidate__c();
        pos2= new position__c();
        this.verified = false;
    } 
    public Attachment attachment 
    {
      get {
          if (attachment == null) attachment = new Attachment();
          return attachment;
          }
          set;
    }
    
      
    public void go()
    {
        getsearch();
    }
    public pagereference apply()
    {
       
          PageReference pageRef = Page.openPosCandReg;
          pageRef.getParameters().put('posid1',posid);
          return PageRef ;  
    }
    
    public pagereference candsave()
    {
        upsert cand;
        cand1= new candidate__c();
        cand1 = [select id,last_name__c,email__c from candidate__c where id = :cand.id];
        attachment.parentid = cand1.id;
 
        try 
        {
          //insert document;
          insert attachment;
        } catch (DMLException e)
        {
          ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading file'));
          return null;
        } finally 
        {
         
          attachment .body = null;
          attachment = new Attachment();
        }
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'File uploaded successfully'));
        posid = ApexPages.currentPage().getParameters().get('posid1');
        Application__c app1 = new Application__c();
        app1.name='AP'+cand1.last_name__c;
        app1.candidate__c = cand1.id;
        app1.position__c = posid;
        insert app1;
        return page.addApplication;
    }
    
    public list<position__c> getsearch()
    {
        if(string.isblank(skills) && string.isblank(respon) && string.isblank(edu) && string.isblank(city) && (minpay == null) )
        {
            return poslist;
        }
        else
        {
            poslist1 = new list<position__c>();
           for(position__c pos : [select id,name,status__c,open_date__c,close_date__c,Skills_Required__c,Responsibilities__c,Educational_Requirements__c,location__c,min_pay__c from position__c where status__c = 'open - approved'])
            {
              if ((pos.Skills_Required__c != NUll &&  pos.Skills_Required__c.contains(skills) ) && (pos.Responsibilities__c  != NUll && pos.Responsibilities__c.contains(respon)) && (pos.Educational_Requirements__c != NUll && pos.Educational_Requirements__c .contains(edu)) && (pos.location__c!= NUll && pos.location__c.contains(city)) && (minpay <= pos.min_pay__c) )
              {
                   poslist1.add(pos);
              }
             
            }
            return poslist1;
        }
    }
}