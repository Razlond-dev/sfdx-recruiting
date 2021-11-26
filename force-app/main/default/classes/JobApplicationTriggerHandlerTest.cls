@isTest
private class JobApplicationTriggerHandlerTest {
  @TestSetup
  static void makeData() {
    TestDataFactory.createJobApplications(250);
  }

  @isTest
  static void testJobApplicationTriggerAfterUpdateSuccess() {
    Job_Application__c[] jobAppsList = [SELECT Stage__c FROM Job_Application__c];

    Test.startTest();
    for (Job_Application__c jobApp : jobAppsList) {
      jobApp.Stage__c = 'Approved';
    }
    update jobAppsList;
    Test.stopTest();

    Job_Application__c[] resultList = [SELECT Position__r.Status__c FROM Job_Application__c];
    for (Job_Application__c jobApp : resultList) {
      System.assertEquals(
        jobApp.Position__r.Status__c,
        'Closed',
        'Trigger should close position this job application relates to.'
      );
    }
  }

  @isTest
  static void testJobApplicationTriggerAfterUpdateNoEffect() {
    Job_Application__c[] jobAppsList = [SELECT Stage__c, Position__r.Status__c FROM Job_Application__c];

    Test.startTest();
    Job_Application__c jobAppToUpdate1 = jobAppsList.get(0);
    Job_Application__c jobAppToUpdate2 = jobAppsList.get(1);
    jobAppToUpdate1.Stage__c = 'Technical interview';
    jobAppToUpdate2.Stage__c = 'Rejected';
    update jobAppsList;
    Test.stopTest();

    Job_Application__c[] resultList = [SELECT Position__r.Status__c FROM Job_Application__c];
    for (Integer i = 0; i < jobAppsList.size(); i++) {
      System.assertEquals(
        jobAppsList.get(i).Position__r.Status__c,
        resultList.get(i).Position__r.Status__c,
        'Trigger should not update status field of position if none job application related to this position did not Approved.'
      );
    }
  }
}
