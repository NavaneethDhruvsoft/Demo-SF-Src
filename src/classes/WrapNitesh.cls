public class WrapNitesh {

//CONTROLLER CLASS

    public list<wrapaccount> wrapaccountList { get; set; }
    public list<account> selectedAccounts{get;set;}    

      
      public WrapNitesh (){
      
     //if(wrapaccountList ==null){
          wrapaccountList =new list<wrapaccount>();
          for(account a:[select id,name,billingcity,phone from account limit 10]){
           wrapaccountlist.add(new wrapaccount(a));
        
           }
        // }
      }

    //### SELECTED ACCOUNT SHOWN BY THIS METHOD
      public void ProcessSelected(){
     selectedAccounts=new list<account>();
     
      for(wrapaccount wrapobj:wrapaccountlist){
           if(wrapobj.isSelected==true){
           selectedAccounts.add(wrapobj.accn);
           }
            
         }
      }
      
  //##THIS IS WRAPPER CLASS
   // account and checkbox taken in wrapper class
   
   public class wrapaccount{
    
    public account accn{get;set;}
    public boolean isSelected{get;set;}
     
       public wrapaccount(account a){
     
         accn=a;
         isselected=false;
       }
  }
}