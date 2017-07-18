public class NewCaseListController {
    public list<case> getNewCases()
    {
        list<case> newcases = [select id,casenumber from case where status='new'];
        return newcases;
    }

}