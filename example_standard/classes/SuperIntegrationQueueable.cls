public with sharing class SuperIntegrationQueueable implements Queueable, Database.AllowsCallouts{

    public void execute(QueueableContext ctx) {
        Cool_Object__c coolObject = new Cool_Object__c(Name = 'Queueable for ages');
        insert coolObject;

        System.enqueueJob(new SyncChangesQueueable(coolObject));
    }
}