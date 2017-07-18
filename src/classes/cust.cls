public with sharing class cust {

    public Contact c = new Contact();
    public cust(ApexPages.StandardController controller) {

    }
    public  string name1()
    {
         String str;
         str = c.firstname+c.lastname;
         return str;    
    }

}