public with sharing class inter 
{
 
    public  interview__c inter{get;set;}
    public inter(ApexPages.StandardController controller)
    {
        inter=(interview__c)controller.getrecord();
        
       
        
        
    }
    public void asd()
    {
          if(interview__C.application__C!= null)
        {
           inter.Candidate__c = [select Candidate__c from application__C where id=:inter.application__c].Candidate__c;
           inter.position__c = [select position__c from application__C where id=:inter.application__c].position__c;
        }   
    }
    
 

}