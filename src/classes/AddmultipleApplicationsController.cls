public class AddmultipleApplicationsController 
{
    Application__C application = new Application__c(position__c = ApexPages.currentPage().getParameters().get('id'));
    public list<Application__c> listApplication{ get; set; }
    public list<application__C> delApplicationList = new list<application__c>();
    public integer index{set;get;}
   
    public AddmultipleApplicationsController(ApexPages.StandardController controller)
    {
          listApplication=new list<Application__c>([select id,name,candidate__c,status__c,position__c from application__C where position__c= :ApexPages.currentPage().getParameters().get('id') ]);
          listApplication.add(application);  
    }

     public AddmultipleApplicationsController()
    {
        listApplication=new list<Application__c>();
        listApplication.add(application);
    }
    Public void addApplication()
    {
        Application__c app = new Application__c(position__c = ApexPages.currentPage().getParameters().get('id'));
        listApplication.add(app);
    }
    
    public void deleteRecord()
    {
      
        Application__c app1 = listApplication.get(index);
        
        //listApplication.remove(index);
        //delete app1;
       
       if(app1.id != null)
       {
           listApplication.remove(index);
            delete app1;
       }
       else
           listApplication.remove(index);
       
    }
    
    public PageReference saveApplications() {
        for(Integer i=0; i<listApplication.size(); i++)
        {
            upsert listApplication;
        }
        return Page.Allapplicationssaved;
    }
}