public class RandomContactFactory 
{
	public static List<Contact> generateRandomContacts(integer i, string ln)
    {
        list<contact> samp = new list<contact>();
        for(integer j=0;j<i;j++)
        {
            samp.add(new contact(firstname= 'test '+j, lastname =ln));
        }
        return samp;
        
    }
}