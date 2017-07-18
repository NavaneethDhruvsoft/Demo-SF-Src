public class AccountHandler {
	
    public static Account insertNewAccount(String name1)
    {
        try
        {
            Account acct=new Account(Name = name1);
        	insert acct;
        	Account acct2 = [SELECT Name FROM Account where Name= :name1];
    		return acct2;
    	} catch (DMLException e)
        {
            System.debug('exception'+e);
            return null;
        }
    
}
}