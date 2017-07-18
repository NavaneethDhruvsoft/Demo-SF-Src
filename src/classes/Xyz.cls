public class Xyz {
    public static void inserting()
    {
        // Insert the Josh contact

Contact josh = new Contact(FirstName='Joshytt',LastName='Kaplanaaa',Department='Finance');   
        Integer I;

insert josh;

 

// Josh's record has been inserted

//   so the variable josh has now an ID

//   which will be used to match the records by upsert

josh.Description = 'Josh\'s record has been updated by the upsert operation.';

 system.debug('josh inserted');

// Create the Kathy contact, but don't persist it in the database

Contact kathy = new Contact(FirstName='Kathy',LastName='Brown',Department='Technology');

 

// List to hold the new contacts to upsert

List<Contact> contacts = new List<Contact> { josh, kathy };

 

// Call upsert

upsert contacts;

 

// Result: Josh is updated and Kathy is created.

    }

}