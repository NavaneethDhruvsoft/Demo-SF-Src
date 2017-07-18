@isTest
private class TestRestrictContactByName
{
	@isTest static void test1() 
    {
        Contact cntc = new Contact(firstname = 'fntest1', lastname = 'lntest1' );
        insert cntc;
    }
    @isTest static void test2() 
    {
        Contact cntc = new Contact(firstname = 'fntest1', lastname = 'invalidname' );
        insert cntc;
    	
    }
}