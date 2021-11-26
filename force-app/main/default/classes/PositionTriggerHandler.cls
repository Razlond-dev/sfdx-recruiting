public inherited sharing class PositionTriggerHandler {
  public static void beforeUpdate(List<Position__c> newList, Map<Id,Position__c> oldMap) {
    for (Position__c position : newList) {
      if (position.Status__c == 'Closed' && position.Status__c != oldMap.get(position.Id).Status__c && position.Closed_At__c == null) {
        position.Closed_At__c = Date.today();
      }
    }
  }
}
