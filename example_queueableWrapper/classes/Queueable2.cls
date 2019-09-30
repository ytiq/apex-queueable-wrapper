public with sharing class Queueable2 extends QueueableWrapper implements Database.AllowsCallouts {
    List<Cool_Object__c> records;
    public Queueable2(List<Cool_Object__c> records) {
        super('Queueable2');
        this.records = records;
    }

    public void work() {
        System.debug('###this.name = ' + this.name);
    }
}