public with sharing class SuperIntegrationQueueable extends QueueableWrapper implements Database.AllowsCallouts{

    List<Cool_Object__c> records;
    public SuperIntegrationQueueable(List<Cool_Object__c> records) {
        super('SuperIntegrationQueueable');

        this.records = records;
    }

    public void work() {
        QueueableBase.enqueueJob(new Queueable1(records));
        QueueableBase.enqueueJob(new Queueable2(records));
    }
}