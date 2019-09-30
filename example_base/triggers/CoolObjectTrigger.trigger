trigger CoolObjectTrigger on Cool_Object__c (after insert) {
    new CoolObjectHandler().handle(Trigger.new, Trigger.oldMap, Trigger.operationType);
}