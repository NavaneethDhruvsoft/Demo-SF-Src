@RestResource(urlMapping='/positions/*')
global with sharing class GETAllPosition 
{

   
    @HttpGet
    global static list<position__c> doGet() 
    {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String memberId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        //Member__c result = [SELECT Id, Name FROM Member__c WHERE Id = :memberId];
        list<position__c> poslist = [select id,name from position__c];
        return poslist ;
    }
 
}