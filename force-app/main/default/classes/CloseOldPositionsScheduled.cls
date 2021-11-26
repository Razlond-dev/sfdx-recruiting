public without sharing class CloseOldPositionsScheduled implements Schedulable {
  public static final String DAILY_MIDNIGHT_INTERVAL = '0 0 0 ? * * *';
  public void execute(SchedulableContext ctx) {
    Database.executebatch(new CloseOldPositionsBatch());
  }
}
