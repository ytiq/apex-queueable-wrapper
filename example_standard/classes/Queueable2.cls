public with sharing class Queueable2 implements Queueable, Database.AllowsCallouts {
    List<Cool_Object__c> records;
    public Queueable2(List<Cool_Object__c> records) {
        this.records = records;
    }

    public void execute(QueueableContext ctx) {
    }
}