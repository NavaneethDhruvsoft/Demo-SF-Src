public class importDataFromCSVControllerCon {
public Blob csvFileBody{get;set;}
public string csvAsString{get;set;}
public String[] csvFileLines{get;set;}
public List<account> acclist{get;set;}
public List<contact> conlist{get;set;}
public Map<id,id> accmaplist ;
  
public importDataFromCSVControllerCon()
{
    csvFileLines = new String[]{};
    acclist = New List<Account>();
    conlist = New List<Contact>();
    accmaplist = new map<id,id>();
    
     
}
  
public void importCSVFile()
{
       try{
       for(Account ac : [Select id,name from Account])
        accmaplist.put(ac.id,ac.id);
     System.debug('<<<<<<<<<<<<<<<<accmaplist>>>>>>>>>>>>>>>>>>>'+accmaplist);
           csvAsString = csvFileBody.toString();
           csvFileLines = csvAsString.split('\n'); 
            
           for(Integer i=1;i<csvFileLines.size();i++){
               contact accObj = new contact() ;
                 string[] csvRecordData = csvFileLines[i].split(',');
                 accObj.FirstName= csvRecordData[0] ;            
                 accObj.LastName = csvRecordData[1];
                 accObj.Email = csvRecordData[2];
                 System.debug('------------------------- csvRecordData[3] -----------------------'+csvRecordData[3]);
                 String id = csvRecordData[3];
                 System.debug('------------------------- Id -----------------------'+Id);
                 System.debug('------------------------- Account.id -----------------------'+accmaplist.get(id));
                 accObj.Accountid=accmaplist.get(id);   
              // accObj.Account.id=(id)id;  
                 conlist.add(accObj);  
                
           }
        //insert acclist;
        }
        catch (Exception e)
        {
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured while importing data Please make sure input csv file is correct---------'+e);
            ApexPages.addMessage(errorMessage);
        }  
  }
}