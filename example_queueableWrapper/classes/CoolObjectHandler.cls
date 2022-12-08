public with sharing class CoolObjectHandler {

    public void handle(List<Cool_Object__c> records, Map<Id, Cool_Object__c> oldRecords, TriggerOperation operation) {
        records = records != null ? records : new List<Cool_Object__c>();
        oldRecords = oldRecords != null ? oldRecords : new Map<Id, Cool_Object__c>();

        switch on operation {
            when AFTER_INSERT {
                complexIntegration(records);
            }
        }
    }

    private static void complexIntegration(List<Cool_Object__c> records) {
        QueueableBase.enqueueJob(new SuperIntegrationQueueable(records));
    }

}

