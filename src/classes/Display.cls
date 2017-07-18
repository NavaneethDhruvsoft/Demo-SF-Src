public class Display {

   public list<account> ac{get;set;}
   public list<Contact> clist{get;set;}
   public list<wrapper> cnlist{get;set;}
   public Display(){
data();
   }
public class wrapper{
      public boolean checkme{get;set;}
      public  contact ct{get;set;}
      public wrapper(boolean b,contact cp){
          checkme=b;
          ct=cp;
      }
  }
  public void data(){
      //------------------------------------------------------Account with Contacts----------------------   
   list<contact> cn=new list<contact>();
   clist=new list<contact>();  
   ac=new list<account>(); 
   ac=[Select name,(Select Name,Email,Phone,Accountid from Contacts) from Account];
  
//------------------------------------------------------Wrapper class--------------------------------------------------------------       
      list<wrapper> wraplist=new list<wrapper>();
      cnlist=new list<wrapper>();
      for(contact cp:[Select Name,Accountid,Email,Phone from contact where accountid='']){
          wrapper w=new wrapper(False,cp);
          wraplist.add(w);
      }
     cnlist=wraplist; 
      
  
  }      

public void saveRecords(){
   list<contact> cs=new list<Contact>();
   for(wrapper wt:this.cnlist){
       if(wt.checkme==true){
       cs.add(wt.ct);
       }
   }
   update cs;
   data();
}     
          
      }