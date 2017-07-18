public with sharing class testExts1 
{
public String myString;

public String x{get;set;}

public String getValue()
{
    myString = 'testExsts1';
    return myString;
}

public pagereference submit(){
    x='x1';
    return null;
}

}