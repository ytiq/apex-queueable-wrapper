public with sharing class Queueable1  implements Queueable, Database.AllowsCallouts {
    List<Cool_Object__c> records;
    public Queueable1(List<Cool_Object__c> records) {
        this.records = records;
    }

    public void execute(QueueableContext ctx) {
    }
}