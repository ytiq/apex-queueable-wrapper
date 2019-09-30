public with sharing class SuperIntegrationQueueable extends QueueableWrapper implements Database.AllowsCallouts{

    public SuperIntegrationQueueable() {
        super('SuperIntegrationQueueable');
    }

    public void work() {
        System.debug('###this.name = ' + this.name);

        Cool_Object__c coolObject = new Cool_Object__c(Name = 'Queueable for ages');
        insert coolObject;

        QueueableWrapper.enqueue(new SyncChangesQueueable(coolObject));
    }
}