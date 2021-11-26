public inherited sharing class JobApplicationTriggerHandler {
  public static void afterUpdate(List<Job_Application__c> newList) {
    Set<Id> positionIds = new Set<Id>();

    for (Job_Application__c job_app : newList) {
      if (job_app.Position__c != null && job_app.Stage__c == 'Approved') {
        positionIds.add(job_app.Position__c);
      }
    }

    List<Position__c> positions = new List<Position__c>();
    
    for (Id posId : positionIds) {
      positions.add(new Position__c(Id = posId, Status__c = 'Closed'));
    }

    update positions;
  }
}
