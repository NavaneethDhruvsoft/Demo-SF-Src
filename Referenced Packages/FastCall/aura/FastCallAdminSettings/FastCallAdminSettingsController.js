({
    initializeNgView : function(component, event, helper) {
        
        // Define service for access AuraEnabled controllerm methods
        var dataService = {
            request : $A.getCallback(function(actionName, params, defer) {
                
                var componentActionName = 'c.' + actionName;
                var action = component.get(componentActionName);
                
                action.setParams(params);
                
                action.setCallback(this, function(a) {
                    try {
                        
                        var state = a.getState();
                        if (state === 'SUCCESS') {
                            defer.resolve(a.getReturnValue());
                        }
                        else if (state === 'ERROR') {
                            var errors = a.getError();
                            if (errors) {
                                defer.reject(errors[0].message);
                            } else {
                                defer.reject('Lightning server side unknown error');
                            }
                        }
                    } catch (ex) {
                        console.log('### Exception: ');
                        console.log(ex);
                    }
                });
                
				$A.enqueueAction(action);
				
            })
        };
        
        // Application initialization
        var fc_root_element = angular.element(component.find("fc-settings-container").getElement());
        
        setTimeout(function () {
            
            // Define angular app constants (Lightning requieriments)
            angular.module('fastCallAdminSettings').constant('appConfig',{
                isLightning:true,
                lightningDataService: dataService
            });
            
            // Bootsrap angular app
            angular.bootstrap(fc_root_element,['fastCallAdminSettings']);
            
            // Get profile info and send the app to "home"
            setTimeout(function () {
                
                var fc_injector = fc_root_element.injector();
                var $state = fc_injector.get('$state');
                var $rootScope = fc_injector.get('$rootScope');
                
                // Remove preloader
                var preloader = $(component.find("fc-settings-container").getElement()).find('.fc-app-preloader');
                preloader.hide(250,function () {
                    preloader.remove();
                });
                
                // Navigate to home
                $state.go('home',{},{location:false});
                
            },500);
            
        }, 500);
        
    }
})