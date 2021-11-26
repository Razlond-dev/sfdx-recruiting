trigger PositionTrigger on Position__c (before update) {
  if (Trigger.isBefore && Trigger.isUpdate) {
    PositionTriggerHandler.beforeUpdate(Trigger.new, Trigger.oldMap);
  }
}