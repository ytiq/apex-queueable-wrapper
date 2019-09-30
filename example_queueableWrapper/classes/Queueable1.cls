public with sharing class Queueable1 extends QueueableWrapper implements Database.AllowsCallouts {
    List<Cool_Object__c> records;
    public Queueable1(List<Cool_Object__c> records) {
        super('Queueable1');
        this.records = records;
    }

    public void work() {
        System.debug('###this.name = ' + this.name);
    }
}