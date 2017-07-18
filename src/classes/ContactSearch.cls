public class ContactSearch {
	public static List<contact> searchForContacts(String str1, String str2)
    {
        Contact[] cntct = [select ID,Name From contact where LastName=:str1 and MailingPostalCode=:str2 ];
        return cntct;
    }
}