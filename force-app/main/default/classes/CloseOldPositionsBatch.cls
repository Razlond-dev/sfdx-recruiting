public without sharing class CloseOldPositionsBatch implements Database.Batchable<sObject> {
  public static Database.QueryLocator start(Database.BatchableContext BC) {
    return Database.getQueryLocator([SELECT Closed_At__c FROM Position__c WHERE Opened_At__c < LAST_N_DAYS:90 AND (Status__c != 'Closed' OR Closed_At__c = null)]);
  }

  public static void execute(Database.BatchableContext ctx, List<Position__c> scope) {
    for (Position__c pos : Scope) {
      pos.Status__c = 'Closed';
      pos.Closed_At__c = Date.today();
    }
    update scope;
  }

  public static void finish(Database.BatchableContext ctx) {
    System.debug('Batch finished');
  }
}
