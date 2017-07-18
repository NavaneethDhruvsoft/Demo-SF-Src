global class jpSchedJobOnExpiryWithPosition Implements Schedulable
{
	global void execute(SchedulableContext sc)
	{
		jpupdate();			
  	}
 	public void jpupdate()
 	{
  		list<job_posting__c> jplist = [select id,position__c,position__r.status__C,position__r.hire_by__c,expiry_date__c,status__c from job_posting__c ];
        //list<position__c> poslist;
        for(job_posting__c jpp : jplist)
        {
            if(jpp.position__r.status__C != 'Closed - Filled' || jpp.position__r.status__C != 'Closed Cancelled' || jpp.position__r.status__C != 'Closed - Not Approved')
            {
                jpp.Status__c= 'open';
                if(jpp.position__r.hire_by__c < system.today())
                {
                    //jpp.position__r.hire_by__c = system.today()+30;
                    //id posid = jpp.Position__c;
					//poslist = [select id,hire_by__C from position__c where id =: posid];
                    //for(position__c pos1 : poslist)
                       // pos1.hire_by__c = system.today()+30;
                    jpp.Expiry_Date__c = system.today()+30;
                }
                else
                    jpp.Expiry_Date__c = jpp.position__r.hire_by__c;
            }
            update jplist;
            //update poslist;
        }
  
 	}
}