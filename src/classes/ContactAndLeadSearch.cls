public class ContactAndLeadSearch 
{
		public static List<List< SObject>> searchContactsAndLeads(String str)
		{
            list<list<sobject>> clsearch = [find :str in name fields returning contact(name where firstname=:str or lastname=:str),
                                                                                 lead(name where firstname=:str or lastname=:str)];
			return clsearch;
        }
}