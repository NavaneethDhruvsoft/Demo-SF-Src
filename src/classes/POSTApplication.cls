@RestResource(urlMapping='/POSTApplication/*')
global with sharing class POSTApplication 
{
  
  @HttpPost
    global static String doPost(string posid,String name,string email, string coverletter) 
    {
       candidate__c can = new candidate__c();
       can.first_name__c = 'fn'+name;
       can.last_name__c = 'ln'+name;
       can.email__c = email;
       insert can;
       application__c app = new application__c();
       app.name = name;
       app.candidate__c = can.id;
       app.position__c = posid;
       app.cover_letter__c = coverletter;
       insert app;
       string done = 'done';
       return done;
       
    }
}