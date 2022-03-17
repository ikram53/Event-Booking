public  class ExternalSystemService {

    private String webServiceURL;



    public static void registerAttendees(Set<Id> reservationsAccount){
        notifyExternalSystem(reservationsAccount);

    }

    @future(Callout=true)
    public static void notifyExternalSystem(Set<Id> reservationsAccount){


        for(Contact attendee : [SELECT id,name, email FROM Contact where accountid in  :reservationsAccount]){
                
                // Set the body as a JSON object
                JSONGenerator body = JSON.createGenerator(true);    
                body.writeStartObject();      
                body.writeStringField('name', attendee.name + '-' + attendee.email);
                body.writeEndObject();   

                HttpResponse response = Callout.doCallout(Callout.WEB_SERVICE_URL,Callout.POST_METHOD,Callout.HEADER_CONTENT_TYPE,Callout.APPLICATION_CONTENT_TYPE,body.getAsString());
                // Parse the JSON response
                if (response.getStatusCode() != 201) {
                    ErrorLogUtility.createLogRecord('Confirmation is not broadcasted to an external system',
                                                    'Case',
                                                    'ExternalSystemService', 
                                                    'notifyExternalSystem', 
                                                    'The status code returned was not expected: ' +response.getStatusCode() + ' ' + response.getStatus());
                 
                } 
                else {
                   // Everything went as expected.
                   system.debug('Success');
                }
            }
        
    }
    


    /*public static void notifyAttendeeByEmail(Contact attendee){
      
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        List<String> toAddresses = new String[] {attendee.email};
        mail.setToAddresses(toAddresses);
        mail.setSubj'Registration Confirmed'ect();
        mail.setPlainTextBody('Your Registation is confirmed ....');

        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

    }*/



    /*public void notifyAttendeeByEmail(Contact account){
      
        Task tk = new Task();
        tk.Subject = 'Send Email To' + account.name;
        tk.Status = 'Open';
        tk.Priority = 'Normal';
        tk.WhatId = account.ID;
        insert tk;
    } */


}
