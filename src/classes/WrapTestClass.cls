public with sharing class WrapTestClass {
List<string> lstselectedNames = new List<string>();
public PageReference selRecDisplay() {
for(wrapper w: lstwrap){
if(w.ischecked==true){
lstselectedNames.add(w.Tname);
}
}
List<Contact> lstselectedrecords = [select Id,name from Contact where name in : lstselectedNames];
List<String> lstselectedRecordIds = new List<String>();
for(Integer i=0;i<lstselectedrecords.size();i++){
lstselectedRecordIds.add(lstselectedrecords[i].Id);
}
string s='';
for(Integer i=0;i<lstselectedRecordIds.size();i++)
{
if(i<lstselectedRecordIds.size()-1)
s=s+lstselectedRecordIds[i]+':';
else
s=s+lstselectedRecordIds[i];
}
pagereference ref = new pagereference('apex/wrapperclass1');
ref.setredirect(true);
return ref;
}
List<wrapper> lstwrap = new List<wrapper>();
List<contact> lsttest = new List<contact>();
public List<wrapper> getTestingrecords() {
lsttest = [select Id,name from contact];
for(Integer i=0;i<lsttest.size();i++)
{
lstwrap.add(new wrapper(lsttest[i].name));
}
return lstwrap;
}
public class wrapper{
public String Tname{get;set;}

public boolean ischecked{get;set;}
public wrapper(String Tname)
{
this.Tname=Tname;

this.ischecked=false;
}
}
}