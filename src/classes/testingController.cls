public with sharing class testingController 
{
    public String JSONdata{get;set;}
    
    @remoteAction
    public static void display(String jsondata1)
    {
        
        System.debug(JSONdata1);
        String fieldName;
        JSONParser parser = JSON.createParser(jsondata1);
        
        While(parser.nextToken() != null)
        {
           System.debug('-------parser.nextToken()---------'+parser.nextToken());
           System.debug('-------parser.getCurrentName()---------'+parser.getCurrentName());
           fieldName += parser.getCurrentName();
        }
        System.debug('-------fieldName---------'+fieldName);
    }
    
    
}