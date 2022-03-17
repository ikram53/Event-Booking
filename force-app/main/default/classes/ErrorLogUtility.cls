public with sharing class ErrorLogUtility {

     public static ErrorLog__c createLogRecord(String descriptionMsg, string sObjectName, string className, 
                                               string methodName, string errMessage){
                                                
                                                ErrorLog__c errorLog = new ErrorLog__c();
                                                errorLog.sObject_Name__c = sObjectName;
                                                errorLog.class_Name__c = className;
                                                errorLog.method__c = methodName;
                                                errorLog.errorMessage__c = errMessage;
                                                errorLog.error_description__c = descriptionMsg;

                                                insert errorLog;
                                                return errorLog;

                                               }
}
