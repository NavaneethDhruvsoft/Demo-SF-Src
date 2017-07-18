global class CandidateEmail implements Messaging.InboundEmailHandler 
{
  global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,Messaging.Inboundenvelope envelope)
  {
    candidate__c cand;
    Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
    try 
    {
     // Look for account whose name is the subject and create it if necessary
        if ([select count() from Candidate__c where email__c =:email.fromAddress] == 0) 
        {
            cand = new candidate__c();
            cand.email__c = email.fromAddress;
            cand.Last_Name__c= email.fromName;
            cand.First_Name__c = email.fromName+'FN';
            insert cand;
            //cand = [select Id from candidate__c where email__c =:email.fromAddress];
            
        } 
        else 
        {
            cand = [select Id from candidate__c where email__C =:email.fromAddress];
        }
        if(email.subject != null)
        {
            list<position__c> poslist = [select id,name from position__c];
            for(position__c pos : poslist)
                if(pos.id == email.subject)
            	{
                	Application__c app = new Application__c();
            		app.candidate__c = cand.id;
            		app.Position__c = pos.id;
            		app.Name = 'AN'+email.fromname;
            		app.Cover_Letter__c = email.plaintextbody;
            		insert app;
                }	
        }
        result.success = true;
    }
    catch (Exception e) 
    {
      result.success = false;
      result.message = 'Oops, I failed.';
    }
    return result;
  }
}