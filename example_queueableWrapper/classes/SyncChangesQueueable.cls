public with sharing class SyncChangesQueueable extends QueueableWrapper implements Database.AllowsCallouts {
    Cool_Object__c coolObject;

    public SyncChangesQueueable(Cool_Object__c coolObject) {
        super('SyncChangesQueueable');
        this.coolObject = coolObject;
    }
    public void work() {
        System.debug('###this.name = ' + this.name);
        // Sync some changes
    }
}