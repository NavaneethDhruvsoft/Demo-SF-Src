public with sharing class CTMR_MapController1 {
    public Map<String,List<String>> carColorsMap {get; set;}

    public CTMR_MapController1() {
        carColorsMap = new Map<String,List<String>>();

        carColorsMap.put('Model A', new List<String>{'blue', 'red', 'green'} );
        carColorsMap.put('Model B', new List<String>{'black', 'yellow', 'red'} );
        carColorsMap.put('Model C', new List<String>{'white', 'black', 'orange'} );
    }
}