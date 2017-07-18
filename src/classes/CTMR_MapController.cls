public with sharing class CTMR_MapController {
    public Map<String,List<contact>> carColorsMap {get; set;}

    public CTMR_MapController() {
    
                carColorsMap = new Map<String,List<contact>>();
                for(Account acc:[select id,name,(select id,name,email from contacts)from account])
                {
                   // options.add(new selectOption(acc.id,acc.name));
                    carColorsMap .put(acc.name,acc.contacts);
                }
    
    
    
     

     /*   carColorsMap.put('Model A', new List<String>{'blue', 'red', 'green'} );
        carColorsMap.put('Model B', new List<String>{'black', 'yellow', 'red'} );
        carColorsMap.put('Model C', new List<String>{'white', 'black', 'orange'} );*/
    }
}