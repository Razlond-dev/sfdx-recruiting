trigger ReviewTrigger on Review__c(after insert, after update, after delete, after undelete) {
  if (Trigger.isAfter && Trigger.isInsert) {
    ReviewTriggerHandler.afterInsert(Trigger.new);
  }
  if (Trigger.isAfter && Trigger.isUpdate) {
    ReviewTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
  }
  if (Trigger.isAfter && Trigger.isDelete) {
    ReviewTriggerHandler.afterDelete(Trigger.old);
  }
  if (Trigger.isAfter && Trigger.isUndelete) {
    ReviewTriggerHandler.afterUndelete(Trigger.new);
  }
}
