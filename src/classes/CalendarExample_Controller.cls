global class CalendarExample_Controller {
 
    public Boolean includeMyEvents {get;set;}
    public integer i{get;set;}
    public list<calEvent> events {get;set;}
    public string color{get;set;}
    public list<string> colors{get;set;}
   //The calendar plugin is expecting dates is a certain format. We can use this string to get it formated correctly
    String dtFormat = 'EEE, d MMM yyyy HH:mm:ss Z';
    // <apex:includeScript value="{!$Resource.moment_min_js}"  />﻿  
    //constructor
    public CalendarExample_Controller() {
        //Default showing my events to on
        includeMyEvents = true;
        color = '#CC9999';
       colors = new list<string>{'#000000',    '#000033',  '#000066',  '#000099',  '#0000CC',  '#0000FF',

'#006600',  '#006633',  '#006666',  '#006699',  '#0066CC',  '#0066FF',

'#330000',  '#330033',  '#330066',  '#330099',  '#3300CC',  '#3300FF',

'#660000',  '#660033',  '#660066',  '#660099',  '#6600CC',  '#6600FF',

'#990000',  '#990033',  '#990066',  '#990099',  '#9900CC',  '#9900FF',

'#CC0000',  '#CC0033',  '#CC0066',  '#CC0099',  '#CC00CC',  '#CC00FF',

'#FF0000',  '#FF0033',  '#FF0066',  '#FF0099',  '#FF00CC',  '#FF00FF'};
  }      
       
    public PageReference pageLoad() {
        events = new list<calEvent>();
        //Get Contact's Birthdays
        for(Contact cont : [select Id, Birthdate, FirstName, LastName from Contact where Birthdate != null]){
            //here we need to replace the birth year with the current year so that it will show up on this years calendar
            DateTime startDT = datetime.newInstance(Date.Today().Year(),cont.Birthdate.Month(), cont.Birthdate.Day());
            calEvent bday = new calEvent();
             
            bday.title = cont.FirstName + ' ' + cont.LastName + '\'s Birthday!';
            bday.allDay = true;
            bday.startString = startDT.format(dtFormat);
            //Because this is an all day event that only spans one day, we can leave the send date null
            bday.endString = '';
            bday.url = '/' + cont.Id;
            bday.className = 'event-birthday';
            events.add(bday);
        }
         
        //Get Campaigns
        for(Campaign camp : [select Id, Name, StartDate, EndDate from Campaign where IsActive = true]){
            DateTime startDT = camp.StartDate;
            DateTime endDT = camp.EndDate;
            calEvent campEvent = new calEvent();
             
            campEvent.title = camp.Name;
            campEvent.allDay = true;
            campEvent.startString = startDT.format(dtFormat);
            campEvent.endString = endDT.format(dtFormat);
            campEvent.url = '/' + camp.Id;
            campEvent.className = 'event-campaign';
            events.add(campEvent);
        }
         
        //Get my Events if we have selected the correct option
        if(includeMyEvents){
            for(Event evnt: [select Id, Subject, isAllDayEvent, StartDateTime, EndDateTime from Event where OwnerID = :UserInfo.getUserId()]){
                DateTime startDT = evnt.StartDateTime;
                DateTime endDT = evnt.EndDateTime;
                calEvent myEvent = new calEvent();
                 
                myEvent.title = evnt.Subject;
                myEvent.allDay = evnt.isAllDayEvent;
                myEvent.startString = startDT.format(dtFormat);
                myEvent.endString = endDT.format(dtFormat);
                myEvent.url = '/' + evnt.Id;
                myEvent.className = 'event-personal';
                events.add(myEvent);
            }
        }
        return null;
    }
     
    public PageReference toggleMyEvents() {
        if(includeMyEvents){
            includeMyEvents = false;
        }
        else{
            includeMyEvents = true;
        }
        pageload();
        return null;
    }
    
    @RemoteAction
    global static Contact updateContact(String cntid, String name, String enddate) 
    {
       String id1 = cntid.Substring(cntid.length()-18,cntid.length());
       contact con = new Contact();
      // Date date12 = (date)enddate;

        try{
        con = [select Id, Birthdate, FirstName, LastName,sam__c from Contact where id = :id1];
        con.sam__c = 'Updated.....';
        upsert con;
        }catch(Exception e){}
        
        return con;
    }

 
     
    //Class to hold calendar event data
    public class calEvent{
        public String title {get;set;}
        public Boolean allDay {get;set;}
        public String startString {get;set;}
        public String endString {get;set;}
        public String url {get;set;}
        public String className {get;set;}
    }
}