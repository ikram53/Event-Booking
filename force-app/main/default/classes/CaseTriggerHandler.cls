public with sharing class CaseTriggerHandler extends TriggerHandler{

    private Map<Id, Case> oldCaseMap, newCaseMap;
    private List<Case> newCaseList;

    public CaseTriggerHandler() {
        newCaseList = (List<Case>) Trigger.new;
        oldCaseMap = (Map<Id, Case>) Trigger.oldMap;
        newCaseMap = (Map<Id, Case>) Trigger.newMap;
    }

    public override void afterUpdate() {
        CaseTriggerHelper.confirmReservation(oldCaseMap,newCaseMap);
    }

    public override void beforeInsert(){
        CaseTriggerHelper.checkReservationInformation(newCaseList);
    }

    
}
