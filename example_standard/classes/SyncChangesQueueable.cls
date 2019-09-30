public with sharing class SyncChangesQueueable implements Queueable, Database.AllowsCallouts {
    Cool_Object__c coolObject;

    public SyncChangesQueueable(Cool_Object__c coolObject) {
        this.coolObject = coolObject;
    }
    public void execute(QueueableContext ctx) {
        // Sync some changes
    }
}