public class StringArrayTest
	{
        
        public static List<String> generateStringArray(Integer num)
		{
    		List<String> str = new List<String>();
            integer i;
            //String x= ' ';
            for(i=0;i<num;i++)
            {
            	str.add('Test '+i);
                System.debug('the value in the string is : '+str[i]);
            	//x+=str[i];
            }
            return str; 
         }
	}