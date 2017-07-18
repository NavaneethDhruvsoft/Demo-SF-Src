public class offerLineItems 
{
    public list<offer__c> offlist {set;get;}
    public list<offer_line_items__c> olilist {set;get;}
    public list<salary__c> sallist{set;get;}
    public list<salary_line_item__c> slilist{set;get;}
    public salary__c sal{set;get;}
    public offer__c off = new offer__c();
    public decimal percount{set;get;}
    public integer index{set;get;}
    public offerLineItems(ApexPages.StandardController controller)
    {
        percount=0;
        olilist = new list<offer_line_items__c>();
        olilist = [select id,Offer_line_item_id__c,name,Salary_component__c,Offer__c,Amount__c,per_of_ctc__c from offer_line_items__c where Offer__c = :ApexPages.currentPage().getParameters().get('id')]; 
        off = [select id,name,offer_id__c,Application__c,candidate__c,position__c,Offer_date__c,Offer_status__c,CTC__c,Offer_valid_till_date__c from offer__c where id = :ApexPages.currentPage().getParameters().get('id') limit 1 ];
        slilist = new list<salary_line_item__c>();
        for(offer_line_items__c oli : olilist)
        {
            percount+=oli.per_of_ctc__c;
        }
    }
    
    public pagereference ok()
    {
        percount = 0;
        for(offer_line_items__c oli : olilist)
        {
            percount+=oli.per_of_ctc__c;
        }
        if(percount != 100)
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'total percount should be == 100'));
        else
        {
            sal = new salary__c();
           // sal = [select id,name,offer__c,Candidate__c,Start_date__c ,End_date__c , CTC__c  from salary__c where offer__c = : off.id limit 1];
            if([select count() from salary__c where offer__c = : off.id] != 0)
                 sal = [select id,name,offer__c,Candidate__c,Start_date__c ,End_date__c , CTC__c  from salary__c where offer__c = : off.id limit 1];
            sallist = new list<salary__c>();
            sal.Candidate__c = off.Candidate__c; 
            sal.offer__c = off.id;
            sal.Start_date__c = off.Offer_date__c;
            sal.End_date__c = off.Offer_valid_till_date__c;
            sal.CTC__c = off.ctc__c; 
            upsert sal;
            for(offer_line_items__c oli1 : olilist)
            {
                salary_line_item__c sli1 = new salary_line_item__c();
                sli1.Salary_component__c = oli1.Salary_component__c;
                sli1.perc_of_ctc__c = oli1.per_of_ctc__c;
                sli1.Salary_line_item_id__c = 'sli - '+oli1.Offer_line_item_id__c;
                sli1.salary__c = sal.id;
                slilist.add(sli1);
            }
           upsert slilist;
           slilist = [select Salary_component__c ,perc_of_ctc__c ,Salary_line_item_id__c ,salary__c ,id,amount__c from salary_line_item__c where salary__c = :sal.id];
        }
        
        return null;
    }
    
    public void addLineItem()
    {
       offer_line_items__c app = new offer_line_items__c (offer__c = ApexPages.currentPage().getParameters().get('id'));
       olilist .add(app); 
    }
    
    public void deleteRecord()
    {
      
        offer_line_items__c oli1 = olilist .get(index);
        if(oli1.id != null)
        {
               olilist .remove(index);
               delete oli1;
        }
       else
           olilist .remove(index);
        percount = 0;
        for(offer_line_items__c oli : olilist)
        {
            percount+=oli.per_of_ctc__c;
        }
       
    }
    
    public pagereference saveLI()
    {
        percount = 0;
        for(offer_line_items__c oli : olilist)
        {
            percount+=oli.per_of_ctc__c;
        }
        for(Integer i=0; i<olilist.size(); i++)
        {
            upsert olilist;
        }
        olilist = [select id,Offer_line_item_id__c,name,Salary_component__c,Offer__c,Amount__c,per_of_ctc__c from offer_line_items__c where Offer__c = :ApexPages.currentPage().getParameters().get('id')]; 

         return null;
    }

}