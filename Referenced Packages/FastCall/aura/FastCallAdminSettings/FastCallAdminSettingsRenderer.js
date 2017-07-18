({
	render: function(component, helper) {
		
        //var el = document.getElementById("fc-settings-container");
        
        //$A.util.removeElement(el);
        
        //window['FastCallAdminSettings'] = {isLightning:true,lightningCmpId: component.getGlobalId()};
    
        return component.superRender();
    },
    
	afterRender: function(component, helper) {
		component.superAfterRender();
	},
	
	unrender: function(component, helper) {
        // Synchronously remove elements because Angular gets very unhappy if we leave them in the DOM
        var el = component.find("fc-settings-container").getElement();
        $A.util.removeElement(el);
        
		component.superUnrender();
	}
})