public class sendMassMailController 
{
    Application__C application = new Application__c(position__c = ApexPages.currentPage().getParameters().get('id'));
     public List<wApplication> appList {get; set;}
     public List<Application__c> selectedappls {set;get;} 
     public integer count{set;get;}
     public list<string> lststr{set;get;}
     public String selectedTemplateId { get; set; }
     public integer index{set;get;}
     public integer errcount{set;get;}
     public integer succount{set;get;}
   
    public sendMassMailController(ApexPages.StandardController controller)
    {
           lststr= new list<string>(); 
          
          getApplicants();  
    }
    
    public sendMassMailController()
    {
         getApplicants(); 
    }
    
    public List<wApplication> getApplicants() {
        if(appList == null) {
            appList = new List<wApplication>();
            for(Application__c a: [select id,name,candidate__c,status__c,position__c,candidate__r.email__c from application__C where position__c= :ApexPages.currentPage().getParameters().get('id')]) {
                // As each contact is processed we create a new cContact object and add it to the contactList
                appList.add(new wApplication(a));
            }
        }
        return appList;
    }

   
    public pageReference Next1()
    {
        selectedappls = new List<Application__c>();
        for(wApplication w: getApplicants()) 
        {
            if(w.selected == true) 
            {
                selectedappls.add(w.appl);
            }
        }

        count = selectedappls.size();
        System.debug('These are the selected Contacts...--------------------------------------------------------------->>>>>>>>>>>>>>>>'+count);
        for(Application__c appp: selectedappls)
        {
            system.debug('---------------------------------------------------------------------------<<<<<<<<<<'+appp);
        }
       return page.selEmailTempl;
    }
  
    public pageReference Next2()
    {
        
       // lststr.add('navaneeth@dhruvsoft.com');
        //for(integer i=0;i<selectedappls.size();i++)
          //  lststr.add(selectedappls[i].candidate__r.email__c);
            for(application__c app2 : selectedappls)
            {
                string str = app2.candidate__r.email__c;
                system.debug('----->>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>'+str);
                lststr.add(str);
            }
        System.debug('This is to invoke this method');
        system.debug('lstStr -------------------------------------------------------------,,,,,......->'+lstStr);
        Id targetObjectId = ApexPages.currentPage().getParameters().get('id');
        system.debug('-------------targetObjectId -------------'+targetObjectId );
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        //mail.setTargetObjectId(targetObjectId);
        mail.setToAddresses(lstStr);
        mail.setBccAddresses(new String[]{'dosapatinavaneeth@gmail.com'});
        mail.setCcAddresses(new String[] {'navaneeth@dhruvsoft.com'});
        mail.setBccSender(true);
        mail.setTemplateId(ApexPages.currentPage().getParameters().get('selectedTemplateId'));
        emailtemplate et = [select id,name,subject,body from emailtemplate where id = :selectedTemplateId  limit 1];
        mail.setSubject(et.subject);
        mail.setPlainTextBody(et.body);
        mail.setSaveAsActivity(false);
        Messaging.SendEmailResult [] res ;
        try{
        
           res = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            }
            catch(exception e){
            system.debug(e);}
        system.debug('res--->'+res);
        errcount =res[0].getErrors().size();
        succount = count- errcount;
        if(res == null)
            return page.unsuccesfull;
        else
        return page.succesmail;
         
        //System.debug(results[0].getErrors().size());
    }
    public pagereference view ()
    {
        return null;
    }
    
    public List<SelectOption> getMyPersonalTemplateOptions() {
        List<SelectOption> options = new List<SelectOption>();
        for (EmailTemplate t : [select Id,Name,subject,body from EmailTemplate ])
            
        {
            options.add(new SelectOption(t.Id,t.Name));
        }
        return options;
    }

public class wApplication 
{

        public Application__c appl {get; set;}

        public Boolean selected {get; set;}

        public wApplication(Application__c a)
        {

            appl = a;

            selected = false;

        }

}

}