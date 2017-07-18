public with sharing class AccountController 
{
    
    public list<account> acclist{get;set;}

    public AccountController()
    {
        acclist = new list<Account>();
        acclist =  [select Name, BillingCity, BillingAddress, BillingState, ownerID,phone,private__C from Account];   
        
    }

   
}