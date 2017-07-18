public with sharing class LeadRecFetch {

    public integer size{get;set;}
    public string type{get;set;}
    public list<lead> lelist{get;set;}
    public integer ind{get;set;}
    public LeadRecFetch(ApexPages.StandardController controller)
    {
        lelist = new list<lead>();
        // ind= 0;   
    }
    
    public void leadrecs()
    {
        lelist = [select name,id from lead limit :size];
    }
    public void go()
    {
        getleadrecs();
    }
public list<lead> getleadrecs()
    {
        if(type == 'ASC')
        lelist = [select name,id from lead  order by name ASC limit :size];
        else
        lelist = [select name,id from lead  order by name DESC limit :size];
        return lelist;
    }

}