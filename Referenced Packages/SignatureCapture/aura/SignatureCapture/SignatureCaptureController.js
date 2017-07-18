({
	setup : function(component, event, helper) {
        helper.setupSignature(component);
    },
    save : function(component, event, helper) {
        helper.saveSignature(component);
    },
    clear : function(component, event, helper) {
        helper.clearSignature(component);
    }
})