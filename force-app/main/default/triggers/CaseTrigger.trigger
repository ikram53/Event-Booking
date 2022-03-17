trigger CaseTrigger on Case (before update,before insert,after update) {        
    
    new CaseTriggerHandler().run();
    
}