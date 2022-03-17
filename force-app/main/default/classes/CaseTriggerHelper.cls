public with sharing class CaseTriggerHelper {

    public static void checkReservationInformation(List<Case> newReservations){

        Map<String, List<Case>> reservationsByAccount = new Map<String, List<Case>>();

        for(Case reservation : newReservations){
            if(reservation.AccountId == null){
                reservation.addError(Label.CaseWithoutAccount);
            }else{
                if(!reservationsByAccount.containsKey(reservation.AccountId)){
                    reservationsByAccount.put(reservation.AccountId, new List<Case>());
                  }
                  reservationsByAccount.get(reservation.AccountId).add(reservation);
            }
        }

        List<Account> accountsWithContacts = [select id,(select id from Contacts) from Account where id in :reservationsByAccount.KeySet()];

        for(Account account : accountsWithContacts){
            Integer accountWithContactsSize = account.Contacts.size();
            for(Case reservation : reservationsByAccount.get(account.id)){
                if(accountWithContactsSize == 0){
                    reservation.addError(Label.CaseWhithNoContactIsAttachedToAnAccount);
                }else{
                    switch on reservation.Origin {
                        when 'Web' {
                            if(accountWithContactsSize >= 2 ){
                                reservation.addError(Label.NumberOfAttendeesIsMoreThanOneForWebCases);
                            }
                        }
                        when 'Phone'{
                            if(accountWithContactsSize >= 4 ){
                                reservation.addError(Label.NumberOfAttendeesIsMoreThanThreeForPhoneCases);
                            }
                        }
                    } 
                }
            }
        }     
         
    }

    public static void confirmReservation(Map<Id,Case> oldCases,Map<Id,Case> newCases){
            Set<Id>  reservationsAccount= new Set<Id>();
        for(Id caseId : newCases.keySet()){
            if(oldCases.get(caseId).Status != newCases.get(caseId).Status &&  newCases.get(caseId).Status == 'Closed' && newCases.get(caseId).AccountId != null){
                reservationsAccount.add(newCases.get(caseId).AccountId);
            }
        } 
        ExternalSystemService.registerAttendees(reservationsAccount);
        
    }
}
