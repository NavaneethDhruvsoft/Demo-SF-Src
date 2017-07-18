public with sharing class taskinsert {

    //Use @AuraEnabled to enable client- and server-side access to the method
    @AuraEnabled
    public static string resp(decimal lat,decimal longi, string sub){
       // string lat1 = (string)lat;
       // string longi1 = (string)longi;
      tasklog__c t = new tasklog__c();
      t.subject__c = sub;
      t.location__latitude__s = lat;
       t.location__longitude__s = longi;
      //t.location__c.longitude = longi1;
      insert t; 
      
      
              //system.debug('>>>>>>>from component<<<<<<the laitutde is ::::::::::::'+lat);
        // +'longitude is........ '+longi1+'.....subject.... is,,,,'+sub1);
        // +'>>>>>>>>>Longitude is'+longi+'<<<<<<<<<<<<<Subject is'+sub );

        return 'done';
            }
}