public with sharing class AccountPagination {
    ApexPages.StandardSetController con;
    
    public AccountPagination(ApexPages.StandardSetController controller) {
        con = controller;
        ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.Error,  'getSelected()'+controller.getSelected()));
     
    }    
   
    public pagereference  getSelectedAccounts(){
      //  return (List<Account>)[select name,id from account where id in :con.getSelected()];
           List<Account> a = [select name,id from account where id in :con.getSelected()];
           system.debug('<<<<<<<<<<List of Accs >>>>>>>>>>>>>>>>>>>>>>>>>>>>>'+a);
        delete a; 
        PageReference pageRef = new PageReference('/001?fcf=00B280000027jV1');
       return pageref;
        
        
        }
    
   
}

/*

{!REQUIRESCRIPT("/soap/ajax/21.0/connection.js")}

//Below ObjectType can be replaced by anyObject. I have used "Test Name"

Set<Id> records = new Set<Id>{ '005w0000003hMII' };  
    user a = [select id,name from user where id IN :records]; 
var records = {!GETRECORDIDS($ObjectType.postion__c)};

if(a.Id === {!User.Id}){

if (records[0] == null) {
   alert("Please select at least one record.")
} else {

   var opt = confirm("Are you sure you want to delete selected records ?");
   if (opt == true) {
       var errors = [];
       var result = sforce.connection.deleteIds(records);
       if (result && result.length) {
           var numFailed = 0;
           var numSucceeded = 0;
           for (var i = 0; i < result.length; i++) {                 
            var res = result[i];                 
         if (res && res.success == 'true') {                         numSucceeded++;              
  } 
else {                    
var es = res.getArray("errors");                    
if (es.length > 0) 
{
errors.push(es[0].message);
}
numFailed++;
 }
 }
 if (numFailed > 0) {
               alert("Failed: " + numFailed + "nSucceeded: " + numSucceeded + " n Due to: " + errors.join("n"));
           } else {
               alert("Number of records deleted: " + numSucceeded);
           }
       }
       window.location.reload();
   }
}
}

*/