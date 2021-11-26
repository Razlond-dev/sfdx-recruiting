public inherited sharing class ReviewTriggerHandler {
  public static void afterInsert(List<Review__c> newList) {
    Set<Id> jobAppsIds = new Set<Id>();

    for (Review__c review : newList) {
      if (review.Job_Application__c != null) {
        jobAppsIds.add(review.Job_Application__c);
      }
    }
    updateAverageGrade(jobAppsIds);
  }

  public static void afterUpdate(List<Review__c> newList, Map<Id,Review__c> oldMap) {
    Set<Id> jobAppsIds = new Set<Id>();

    for (Review__c review : newList) {
      if (review.Job_Application__c != null && review.Grade__c != oldMap.get(review.Id).Grade__c) {
        jobAppsIds.add(review.Job_Application__c);
      }
    }
    updateAverageGrade(jobAppsIds);
  }

  public static void afterDelete(List<Review__c> oldList) {
    Set<Id> jobAppsIds = new Set<Id>();

    for (Review__c review : oldList) {
      if (review.Job_Application__c != null) {
        jobAppsIds.add(review.Job_Application__c);
      }
    }
    updateAverageGrade(jobAppsIds);
  }

  public static void afterUndelete(List<Review__c> newList) {
    Set<Id> jobAppsIds = new Set<Id>();

    for (Review__c review : newList) {
      if (review.Job_Application__c != null) {
        jobAppsIds.add(review.Job_Application__c);
      }
    }
    updateAverageGrade(jobAppsIds);
  }

  public static void updateAverageGrade(Set<Id> jobAppsIds) {
    List<Job_Application__c> jobAppListToUpdate = new List<Job_Application__c>();

    Map<Id, AggregateResult> groupedResultsMap = new Map<Id, AggregateResult>([
      SELECT Job_Application__c Id, COUNT(Id) totalNumber, SUM(Grade__c) gradeSum
      FROM Review__c
      WHERE Job_Application__c IN :jobAppsIds
      GROUP BY Job_Application__c
    ]);

    for (Id id : jobAppsIds) {
      AggregateResult ar = groupedResultsMap.get(id);
      if (ar != null) {
        jobAppListToUpdate.add(
          new Job_Application__c(
            Id = (Id) ar.get('Id'),
            Number_of_Reviews__c = (Decimal) ar.get('totalNumber'),
            Grade_Summary__c = (Decimal) ar.get('gradeSum')
          )
        );
      } else {
        jobAppListToUpdate.add(new Job_Application__c(Id = id, Number_of_Reviews__c = 0, Grade_Summary__c = 0));
      }
    }

    update jobAppListToUpdate;
  }
}
