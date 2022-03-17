@isTest
public  class TestDataFactory {

    public static FINAL String EMAIL_CONTACT_1 = 'contact1@gmail.com';
    public static FINAL String EMAIL_CONTACT_2 = 'contact2@gmail.com';
    public static FINAL String EMAIL_CONTACT_3 = 'contact3@gmail.com';
    public static FINAL String EMAIL_CONTACT_4 = 'contact4@gmail.com';
    public static FINAL String EMAIL_CONTACT_5 = 'contact5@gmail.com';
    public static FINAL List<String> LIST_CONTACT_EMAIL_3 = new List<String> { EMAIL_CONTACT_1,EMAIL_CONTACT_2,EMAIL_CONTACT_3};
    public static FINAL List<String> LIST_CONTACT_EMAIL_5 = new List<String> { EMAIL_CONTACT_1,EMAIL_CONTACT_2,EMAIL_CONTACT_3,EMAIL_CONTACT_4,EMAIL_CONTACT_5};

    public static Database.SaveResult createCase(String caseOrigin,Boolean caseRelatedToAccount,List<String> contactsEmail,Integer numberOfRelatedContact){

        Case request = new Case(Origin = caseOrigin,Subject = 'Event Booking', Description = 'Book Spots');
        List<Contact> contactToInsert = new List<Contact>();

       if(caseRelatedToAccount){
           Account account = new Account(Name = 'Salesforce');
           insert account;
           request.AccountId = account.Id;
        }

        if(numberOfRelatedContact > 0 && contactsEmail.size() == numberOfRelatedContact){
            for(Integer i=1; i<=numberOfRelatedContact; i++){
                Contact contact = new Contact(LastName = 'Contact'+i,email = contactsEmail[i-1] ,AccountId = request.AccountId);
                contactToInsert.add(contact);
            }
        }


        Database.insert(contactToInsert, false);
        return Database.insert(request, false);
       
    }

    public static Database.SaveResult editCase(String status){
        Case confirmedReservation = new Case();
        confirmedReservation.Id = createCase('Phone',true,TestDataFactory.LIST_CONTACT_EMAIL_3,3).getId();
        confirmedReservation.status = 'Closed';
        
        return Database.update(confirmedReservation, false);
    }



}
