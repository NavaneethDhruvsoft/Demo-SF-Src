public class templSelector {

    public templSelector(ApexPages.StandardController controller) {

    }
    public String selectedTemplateId { get; set; }

    public List<SelectOption> getMyPersonalTemplateOptions() {
        List<SelectOption> options = new List<SelectOption>();
        for (EmailTemplate t : [select Id,Name from EmailTemplate /* where FolderId = :UserInfo.getUserId() */])
            // Each User has a 'My Personal Templates' folder
            // of EmailTemplates, whose Id is the User's Id
        {
            options.add(new SelectOption(t.Id,t.Name));
        }
        return options;
    }

}