public class Zxy {
    public static void inserting1()
    {
        Contact jane = new Contact(FirstName='Jane12',

                         LastName='Smith12',

                         Email='jane.smith12@example.com',

                         Description='Contact of the day12');

insert jane;

 

// 1. Upsert using an idLookup field

// Create a second sObject variable.

// This variable doesn’t have any ID set.


Contact jane2 = new Contact(FirstName='Jane12',

                         LastName='Smith12', 

                         Email='jane.smith12@example.com',

                         Description='Prefers to be contacted by email12.');

// Upsert the contact by using the idLookup field for matching.

upsert jane2 Contact.fields.Email;
 Contact[] jane3 = [SELECT Id FROM Contact WHERE LastName = 'chfgjh'];
 delete jane3;

// Verify that the contact has been updated

System.assertEquals('Prefers to be contacted by email12.',

                   [SELECT Description FROM Contact WHERE Id=:jane.Id].Description);
System.debug('equal for jane2');

    }

}