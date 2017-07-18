public with sharing class searchcontroller {

    public void multi() {
        string fields;
        if(selected.size()==1 && selected[0] == 'Other'){
            list<string> li = new list<string>();
            for(integer i = 0; i<mts.size(); i++){
                li.add(mts[i]);
            }
            //fields = li.substring(0, li.length()-1);
            selected=li; 
        }  
                
    }
    public list<string>selected{get;set;}
    public list<string>mts = new list<string>();
    public string name{get;set;}
    public string industry{get;set;}
    public string type{get;set;}
    public string Ownership{get;set;}
    public string rating{get;set;}
    public list<Account> acts{get;set;}
    public Account ac{get;set;}
    
    public void searchcontroller(){
        ac = new Account();
        acts = new list<Account>();
        system.debug('-----2nn--'+ac.name);
        search();
    }
    
    public void Search() {
        system.debug('-------------------->'+type);
        list<string> fields = new list<string>();
        if(name!= null && Name != '')
            fields.add('Name like \'%'+ac.name+'%\'');
        if(Type!= 'Account Type')
            fields.add('Type like \'%'+ac.type+'%\'');
        if(Industry!= 'industry')
            fields.add('Industry like \'%'+ac.Industry+'%\'');
        if(ac.Rating!= null && ac.Rating!= '')
            fields.add('Rating like \'%'+ac.Rating+'%\'');
        if(ac.Ownership!= null && ac.Ownership!= '')
            fields.add('Qwnership like \'%'+ac.Ownership+'%\'');
        
        if(fields.size()>0){
            string query = 'select id, name, type, industry, rating, Ownership from Account where '+fields[0];
            
            for(integer i=1; i<fields.size(); i++){
                 query += ' AND'+' '+ fields[i];
            }
            
            acts = database.query(query); 
        }
    }
    public list<selectoption> getTypelist(){
        List<SelectOption> options = new List<SelectOption>();
        Schema.DescribeFieldResult fieldResult = Account.Type.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry f : ple)
        {
            options.add(new SelectOption(f.getLabel(), f.getValue()));
            mts.add(f.getValue());
        }       
        return options;
    }
    public list<selectoption> getIndustrylist(){
        List<SelectOption> options = new List<SelectOption>();
        Schema.DescribeFieldResult fieldResult = Account.Industry.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry f : ple)
        {
            options.add(new SelectOption(f.getLabel(), f.getValue()));
        }       
        return options;
    }
    public list<selectoption> getRatinglist(){
        List<SelectOption> options = new List<SelectOption>();
        Schema.DescribeFieldResult fieldResult = Account.Rating.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry f : ple)
        {
            options.add(new SelectOption(f.getLabel(), f.getValue()));
        }       
        return options;
    }
    public list<selectoption> getOwnershiplist(){
        List<SelectOption> options = new List<SelectOption>();
        Schema.DescribeFieldResult fieldResult = Account.Ownership.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry f : ple)
        {
            options.add(new SelectOption(f.getLabel(), f.getValue()));
        }       
        return options;
    }
}