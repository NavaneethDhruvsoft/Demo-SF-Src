global class HotelLocator {

    public HotelLocator(ApexPages.StandardSetController controller) {

    }

@RemoteAction
global static List<interview__c> interhotels(String lat, String lon) {
// Initialize results to an empty list
List<interview__c> results = new List<interview__c>();

    // method implementation goes here

// If geolocation parameters are invalid, use San Francisco
if(String.isBlank(lat) || String.isBlank(lon)) {
lat = '37.793731';
lon = '-122.395002';
}
 
   //results = [select id,name,name__c,address__c,Location__Longitude__s, Location__Latitude__s,state__c,city__c,capacity__c from hotel__c where ]; 
        results = [select id,name,position__c,candidate__c,application__c,venue__c,venue__r.Location__Longitude__s,venue__r.Location__Latitude__s,venue__r.Address__c,venue__r.City__c,venue__r.Phone__c from interview__c where position__c = :ApexPages.currentPage().getParameters().get('id') ];
    // Return the query results
return(results);

}

}