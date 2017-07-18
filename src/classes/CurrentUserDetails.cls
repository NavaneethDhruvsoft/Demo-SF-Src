public with sharing class CurrentUserDetails {

    public user currentuser{get;set;}
    public CurrentUserDetails(ApexPages.StandardController controller)
    {
         currentuser=new User();
         currentuser=[Select Id,Name,Email,phone,title from User where Id=:userinfo.getuserId()];
    }

}