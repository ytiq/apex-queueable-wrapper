public with sharing class CoolObjectHandler {

    public void handle(List<Cool_Object__c> records, Map<Id, Cool_Object__c> oldRecords, TriggerOperation operation) {
        records = records != null ? records : new List<Cool_Object__c>();
        oldRecords = oldRecords != null ? oldRecords : new Map<Id, Cool_Object__c>();

        switch on operation {
            when AFTER_INSERT {
                integration1(records);
                integration2(records);
            }
        }
    }

    private static void integration1(List<Cool_Object__c> records) {
        System.enqueueJob(new Queueable1(records));
    }
    private static void integration2(List<Cool_Object__c> records) {
        System.enqueueJob(new Queueable2(records));
    }

}

