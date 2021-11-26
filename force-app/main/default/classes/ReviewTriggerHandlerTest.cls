@isTest
private class ReviewTriggerHandlerTest {
  @TestSetup
  static void makeData() {
    TestDataFactory.createJobApplications(1);
  }

  @isTest
  static void testReviewTriggerAfterInsertSuccess() {
    Integer count = 240;
    Job_Application__c jobApp = [
      SELECT Stage__c, Grade_Summary__c, Number_of_Reviews__c, Average_Grade__c, (SELECT Grade__c FROM Reviews__r)
      FROM Job_Application__c
    ];

    Test.startTest();
    List<Review__c> reviewList = new List<Review__c>();
    for (Integer i = 0; i < count; i++) {
      reviewList.add(
        new Review__c(Grade__c = 3.5, Type__c = 'Test Task', Job_Application__c = jobApp.Id)
      );
    }
    insert reviewList;
    Job_Application__c resultJobAppInsert = [
      SELECT Grade_Summary__c, Number_of_Reviews__c, Average_Grade__c, (SELECT Grade__c FROM Reviews__r)
      FROM Job_Application__c
      WHERE Id = :jobApp.Id
    ];
    Test.stopTest();
    System.assertEquals(resultJobAppInsert.Grade_Summary__c, count * 3.5);
    System.assertEquals(resultJobAppInsert.Number_of_Reviews__c, count);
    System.assertEquals(resultJobAppInsert.Average_Grade__c, 3.5);
  }

  @isTest
  static void testReviewTriggerAfterUpdateSuccess() {
    Integer count = 240;
    Job_Application__c jobApp = [
      SELECT Stage__c, Grade_Summary__c, Number_of_Reviews__c, Average_Grade__c, (SELECT Grade__c FROM Reviews__r)
      FROM Job_Application__c
    ];

    List<Review__c> reviewList = new List<Review__c>();
    for (Integer i = 0; i < count; i++) {
      reviewList.add(
        new Review__c(Grade__c = 3.5, Type__c = 'Test Task', Job_Application__c = jobApp.Id)
      );
    }
    insert reviewList;

    Test.startTest();
    for (Review__c review : reviewList) {
      review.Grade__c = 3;
    }
    update reviewList;
    Test.stopTest();
    Job_Application__c resultJobAppUpdate = [
      SELECT Grade_Summary__c, Number_of_Reviews__c, Average_Grade__c, (SELECT Grade__c FROM Reviews__r)
      FROM Job_Application__c
      WHERE Id = :jobApp.Id
    ];

    System.assertEquals(resultJobAppUpdate.Grade_Summary__c, count * 3);
    System.assertEquals(resultJobAppUpdate.Number_of_Reviews__c, count);
    System.assertEquals(resultJobAppUpdate.Average_Grade__c, 3);
  }

  @isTest
  static void testReviewTriggerAfterDeleteSuccess() {
    Integer count = 240;
    Job_Application__c jobApp = [
      SELECT Stage__c, Grade_Summary__c, Number_of_Reviews__c, Average_Grade__c, (SELECT Grade__c FROM Reviews__r)
      FROM Job_Application__c
    ];

    List<Review__c> reviewList = new List<Review__c>();
    for (Integer i = 0; i < count; i++) {
      reviewList.add(
        new Review__c(Grade__c = 3.5, Type__c = 'Test Task', Job_Application__c = jobApp.Id)
      );
    }
    insert reviewList;

    Test.startTest();
    delete reviewList;
    Test.stopTest();

    Job_Application__c resultJobAppDelete = [
      SELECT Grade_Summary__c, Number_of_Reviews__c, Average_Grade__c, (SELECT Grade__c FROM Reviews__r)
      FROM Job_Application__c
      WHERE Id = :jobApp.Id
    ];
    System.assertEquals(resultJobAppDelete.Average_Grade__c, null);
  }

  @isTest
  static void testReviewTriggerAfterUndeleteSuccess() {
    Integer count = 240;
    Job_Application__c jobApp = [
      SELECT Stage__c, Grade_Summary__c, Number_of_Reviews__c, Average_Grade__c, (SELECT Grade__c FROM Reviews__r)
      FROM Job_Application__c
    ];

    List<Review__c> reviewList = new List<Review__c>();
    for (Integer i = 0; i < count; i++) {
      reviewList.add(
        new Review__c(Grade__c = 3.5, Type__c = 'Test Task', Job_Application__c = jobApp.Id)
      );
    }
    insert reviewList;
    delete reviewList;

    Test.startTest();
    undelete reviewList;
    Test.stopTest();

    Job_Application__c resultJobAppUndelete = [
      SELECT Grade_Summary__c, Number_of_Reviews__c, Average_Grade__c, (SELECT Grade__c FROM Reviews__r)
      FROM Job_Application__c
      WHERE Id = :jobApp.Id
    ];
    System.assertEquals(resultJobAppUndelete.Grade_Summary__c, count * 3.5);
    System.assertEquals(resultJobAppUndelete.Number_of_Reviews__c, count);
    System.assertEquals(resultJobAppUndelete.Average_Grade__c, 3.5);
  }
}
