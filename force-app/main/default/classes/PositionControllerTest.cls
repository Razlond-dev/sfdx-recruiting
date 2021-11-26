@isTest
private class PositionControllerTest {
  static Integer offset = 0;
  static Integer recordsPerPage = 2;
  static String selectedStatus = 'All Statuses';

  @TestSetup
  static void makeData() {
    TestDataFactory.createPositions(5);
    TestDataFactory.createUser('Standard User', 'standardUser-test@testorg.com');
  }

  @isTest
  static void testGetAllPositions() {
    Test.startTest();
    List<Position__c> resultList = PositionController.getPositions(offset, recordsPerPage, selectedStatus);
    Test.stopTest();

    Position__c[] positionList = [
      SELECT Name, Closed_At__c, Opened_At__c, Status__c, Max_Salary__c, Min_Salary__c
      FROM Position__c
      LIMIT :recordsPerPage
    ];
    System.assertEquals(positionList, resultList, 'Method getPositions should return all positions accessible within limit with filter "All Statuses"');
  }

  @isTest
  static void testGetAllPositionsWithOffset() {
    Test.startTest();
    offset = 2;
    List<Position__c> resultList = PositionController.getPositions(offset, recordsPerPage, selectedStatus);
    Test.stopTest();

    Position__c[] positionList = [
      SELECT Name, Closed_At__c, Opened_At__c, Status__c, Max_Salary__c, Min_Salary__c
      FROM Position__c
      LIMIT :recordsPerPage
      OFFSET :offset
    ];
    System.assertEquals(positionList, resultList, 'Method getPositions should return all positions accessible within limit with offset');
  }

  @isTest
  static void testGetPositionsWithModifiedParams() {
    Test.startTest();
    offset = 2;
    selectedStatus = 'Opened';
    List<Position__c> resultList = PositionController.getPositions(offset, recordsPerPage, selectedStatus);
    Test.stopTest();

    Position__c[] positionList = [
      SELECT Name, Closed_At__c, Opened_At__c, Status__c, Max_Salary__c, Min_Salary__c
      FROM Position__c
      WHERE Status__c = :selectedStatus
      LIMIT :recordsPerPage
      OFFSET :offset
    ];
    System.assertEquals(positionList, resultList, 'Method getPositions should return all positions accessible within limit with specific filter and offset');
  }

  @isTest
  static void testGetAllPositionsCount() {
    Test.startTest();
    Integer result = PositionController.getPositionsCount(selectedStatus);
    Test.stopTest();

    Integer positionCount = [
        SELECT COUNT()
        FROM Position__c
    ];
    System.assertEquals(positionCount, result, 'Method getPositionsCount should return all positions number with filter "All Statuses"');
  }

  @isTest
  static void testGetPositionsCountError() {
    Exception capturedException;
    User testUser = [ SELECT Id FROM User WHERE username = 'standardUser-test@testorg.com'];

    System.runAs(testUser) {
    Test.startTest();
    try {
      Integer positionCount = RecruitingHelper.getPositionsCount(selectedStatus);
    } catch (Exception e) {
      System.debug(e.getMessage());
      capturedException = e;
    }
    Test.stopTest();
    System.assertEquals(System.Label.Records_access_error, capturedException.getMessage(), 'Method savePositions should throw an AuraHandledException with specifik message');
    }
  } 

  @isTest
  static void testGetPositionsCountBySelectedStatus() {
    Test.startTest();
    selectedStatus = 'Opened';
    Integer result = PositionController.getPositionsCount(selectedStatus);
    Test.stopTest();

    Integer positionCount = [
        SELECT COUNT()
        FROM Position__c
        WHERE Status__c = :selectedStatus
    ];
    System.assertEquals(positionCount, result, 'Method getPositionsCount should return all positions number with specific filter');
  }

  @isTest
  static void testSave() {
    String statusToChange = 'Freezed';

    Test.startTest();
    List<Position__c> resultList = PositionController.getPositions(offset, recordsPerPage, selectedStatus);
    resultList.get(0).Status__c = statusToChange;
    resultList.get(1).Status__c = statusToChange;
    Id firstPosId = resultList.get(0).Id;
    Id secondPosId = resultList.get(1).Id;

    // since apex get only changed positions List from Front End, create a new list
    List<Position__c> changedPositionList = new List<Position__c>{resultList.get(0), resultList.get(1)};
    PositionController.savePositions(changedPositionList);
    Test.stopTest();

    List<Position__c> changedStatusPositions = [
      SELECT Name, Closed_At__c, Opened_At__c, Status__c, Max_Salary__c, Min_Salary__c
      FROM Position__c
      WHERE Id IN (:firstPosId, :secondPosId)
    ];
    
    System.assertEquals(changedStatusPositions.get(0).Status__c, statusToChange, 'Method savePositions should update first passed position');
    System.assertEquals(changedStatusPositions.get(1).Status__c, statusToChange, 'Method savePositions should update all positions that were passed');
  }
  
@isTest
  static void testSaveAuraExeption() {
    Exception capturedException;
    Test.startTest();
    List<String> changedPositionList = new List<String>{'Invalid data'};
    try {
      PositionController.savePositions(changedPositionList);
    } catch (Exception e) {
      capturedException = e;
    }
    Test.stopTest();
    System.assertEquals(System.Label.Records_updated_error, capturedException.getMessage(), 'Method savePositions should throw an AuraHandledException with specifik message');
  }
}
