/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class LoginHistoryObject {
    global String Application {
        get;
        set;
    }
    global String ErrorMsg {
        get;
        set;
    }
    global String iconUrl {
        get;
        set;
    }
    global String LoginTime {
        get;
        set;
    }
    global String objStatus {
        get;
        set;
    }
    global String userFullName {
        get;
        set;
    }
    global String userID {
        get;
        set;
    }
    global LoginHistoryObject(String recID) {

    }
    @AuraEnabled
    global static List<roreblcloghist.LoginHistoryObject> getLoginHistoryLimitInt(String uStatus, Integer rowsLimit) {
        return null;
    }
    @AuraEnabled
    global static List<roreblcloghist.LoginHistoryObject> getLoginHistoryLimit(String uStatus, String rowsLimit) {
        return null;
    }
}
