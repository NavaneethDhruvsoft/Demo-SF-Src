@RestResource(urlMapping='/GETPositionDetail/*')
global with sharing class GETPositionDetail 
{

   
    @HttpGet
    global static position__c doGet() 
    {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String memberId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
       
        position__c pos = [select id,name,status__c from position__c where id=:memberId ];
        return pos ;
    }
 
}