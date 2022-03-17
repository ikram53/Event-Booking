@isTest
public class EventBookingTest {  

    
        @isTest
        public static void refuseCaseCreationWhenAnAccountIsNotAttachedToACase(){
        
            // When 
            Test.startTest();
            Database.SaveResult result = TestDataFactory.createCase('Phone',false,null,0);
            Test.stopTest();

            // Then

            System.assert(!result.isSuccess());
            System.assert(result.getErrors().size() > 0);
            System.assertEquals(Label.CaseWithoutAccount,
            result.getErrors()[0].getMessage());
        }
        
        @isTest
        public static void refuseCaseCreationWhenNoContactIsAttachedToAnAccount(){
      
            // When 
            Test.startTest();
            Database.SaveResult result = TestDataFactory.createCase('Phone',true,null,0);
            Test.stopTest();

            // Then

            System.assert(!result.isSuccess());
            System.assert(result.getErrors().size() > 0);
            System.assertEquals(Label.CaseWhithNoContactIsAttachedToAnAccount,
            result.getErrors()[0].getMessage());
        }
        
        @isTest
        public static void bookEventFromPhone(){
      
            // When 
            Test.startTest();
            Database.SaveResult result = TestDataFactory.createCase('Phone',true,TestDataFactory.LIST_CONTACT_EMAIL_3,3);
            Test.stopTest();

            // Then

            System.assert(result.isSuccess());


        }


        @isTest
        public static void refuseEventBookingWhenNumberOfAttendeesIsMoreThanThreeForPhoneCases(){
            // Given
     
            // When 

            Test.startTest();
            Database.SaveResult result = TestDataFactory.createCase('Phone',true,TestDataFactory.LIST_CONTACT_EMAIL_5,5);
            Test.stopTest();

            // Then
            System.assert(!result.isSuccess());
            System.assert(result.getErrors().size() > 0);
            System.assertEquals(Label.NumberOfAttendeesIsMoreThanThreeForPhoneCases,
            result.getErrors()[0].getMessage());

        }
        
        @isTest
        public static void bookEventFromTheWeb(){
         
            // When 

            Test.startTest();
            Database.SaveResult result = TestDataFactory.createCase('Web',true,new List<String>{TestDataFactory.EMAIL_CONTACT_1},1);
            Test.stopTest();

            // Then

            System.assert(result.isSuccess());

                
        } 
            
        @isTest
        public static void refuseEventBookingWhenNumberOfAttendeesIsMoreThanOneForWebCases(){
            // Given
            
      
            // When 

            Test.startTest();
            Database.SaveResult result = TestDataFactory.createCase('Web',true,TestDataFactory.LIST_CONTACT_EMAIL_3,3);
            Test.stopTest();

            // Then

            System.assert(!result.isSuccess());
            System.assert(result.getErrors().size() > 0);
            System.assertEquals(Label.NumberOfAttendeesIsMoreThanOneForWebCases,
            result.getErrors()[0].getMessage());

                
        } 

      /*  @isTest
        public static void confirmRegistrationKO(){
               
               Test.startTest();
               Test.setMock(HttpCalloutMock.class, new CalloutMock(Callout.HTTPSTATUS_ERRREQ,Callout.HTTPSTATUS_KO,Callout.HTTPCODE_ERRREQ));
               Database.SaveResult result = TestDataFactory.editCase('Closed');
               System.assertEquals(Limits.getFutureCalls(), 1);
               Test.stopTest();
        }*/
      
        @isTest
        public static void confirmRegistrationOK(){
              
               Test.startTest();
               Test.setMock(HttpCalloutMock.class, new CalloutMock(Callout.HTTPSTATUS_OK ,Callout.HTTPSTATUS_SUCCESS,Callout.HTTPCODE_OK));
               Database.SaveResult result = TestDataFactory.editCase('Closed');
               System.assertEquals(Limits.getFutureCalls(), 1);
               Test.stopTest();
        }
}
