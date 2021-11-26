@isTest
private class PositionTriggerHandlerTest {
  @TestSetup
  static void makeData() {
    TestDataFactory.createPositions(250);
  }

  @isTest
  static void testPositionTriggerBeforeUpdateSuccess() {
    Position__c[] positionList = [SELECT Name, Closed_At__c, Status__c FROM Position__c WHERE Status__c != 'Closed'];
    List<Id> updatedPositionIds = new List<Id>();
    Test.startTest();
    for (Position__c pos : positionList) {
      pos.Status__c = 'Closed';
      updatedPositionIds.add(pos.Id);
    }
    update positionList;
    Test.stopTest();

    Position__c[] resultList = [SELECT Name, Closed_At__c, Status__c FROM Position__c WHERE Id IN : updatedPositionIds];
    for (Position__c pos : resultList) {
      System.assertEquals(
        pos.Closed_At__c,
        Date.today(),
        'Trigger should update all closed_at date fields when positions were updated to "Closed" status.'
      );
    }
  }

  @isTest
  static void testPositionTriggerBeforeUpdateNoEffect() {
    Position__c[] positionList = [SELECT Name, Closed_At__c, Status__c FROM Position__c LIMIT 2];
    List<Id> updatedPositionIds = new List<Id>();

    Test.startTest();
    Position__c posToUpdate1 = positionList.get(0);
    updatedPositionIds.add(posToUpdate1.Id);
    Position__c posToUpdate2 = positionList.get(1);
    updatedPositionIds.add(posToUpdate2.Id);
    posToUpdate1.Status__c = 'Editing';
    posToUpdate2.Status__c = 'Opened';
    update positionList;
    Test.stopTest();

    Position__c[] resultList = [SELECT Name, Closed_At__c, Status__c FROM Position__c WHERE Id IN : updatedPositionIds];

    for (Integer i = 0; i < positionList.size(); i++) {
      System.assertEquals(
        positionList.get(i).Closed_At__c,
        resultList.get(i).Closed_At__c,
        'Trigger should not update closed_at date fields when positions were updated to other then "Closed" status.'
      );
    }
  }
}
