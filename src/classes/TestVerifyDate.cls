@isTest
private class TestVerifyDate {
		@isTest static void test1()
        {
            date d1 = date.newInstance(2015, 07, 10);
			date d2 = date.newInstance(2015, 07, 10);
            Date result = verifydate.checkdates(d1,d2);
            // System.assertEquals(d1, result);
        }
    	@isTest static void test2()
        {
            date d1 = date.newInstance(2015, 08, 10);
			date d2 = date.newInstance(2015, 07, 04);
			date d3 = date.newInstance(2015, 08, 30);
            Date result = verifydate.checkdates(d1,d2);
            //System.assertEquals(d3, result);
        }
    	@isTest static void test3()
        {
            date d1 = date.newInstance(2015, 07, 10);
			date d2 = date.newInstance(2015, 08, 04);
			date d3 = date.newInstance(2015, 08, 04);
            Date result = verifydate.checkdates(d1,d2);
            System.assertEquals(d3, result);
        }
    	
}