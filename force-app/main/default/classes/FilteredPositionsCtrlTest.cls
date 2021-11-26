@isTest
private class FilteredPositionsCtrlTest {
  @TestSetup
  static void makeData() {
    TestDataFactory.createPositions(5);
    TestDataFactory.createUser('Standard User', 'systemAdministratorTest@testorg.com');
  }

  @isTest
  static void testCorrectUserCurrencyConstant() {
    Test.startTest();
    FilteredPositionsCtrl pageController = new FilteredPositionsCtrl();
    Test.stopTest();
    System.assertEquals(
      pageController.USER_CURRENCY,
      UserInfo.getDefaultCurrency()
    );
  }

  @isTest
  static void testGetPositionList() {
    FilteredPositionsCtrl pageController = new FilteredPositionsCtrl();

    Test.startTest();
    List<Position__c> resultList = pageController.positionList;
    Test.stopTest();

    Position__c[] positionList = [
      SELECT Name, Closed_At__c, Opened_At__c, Status__c, Max_Salary__c, Min_Salary__c
      FROM Position__c
    ];
    System.assertEquals(positionList, resultList);
  }

  @isTest
  static void testGetPositionListWithConstructorError() {
    User testUser = [ SELECT Id FROM User WHERE username = 'systemAdministratorTest@testorg.com'];

    System.runAs(testUser) {
      Test.startTest();
      FilteredPositionsCtrl pageController = new FilteredPositionsCtrl();
      Test.stopTest();

      List<Apexpages.Message> messages = ApexPages.getMessages();
      Boolean hasSpecificMessage = false;
      for (Apexpages.Message msg : messages) {
        if (msg.getDetail().contains(System.Label.Records_access_error)) {
          hasSpecificMessage = true;
        }
      }

      System.assert(ApexPages.hasMessages(ApexPages.Severity.ERROR), 'There should be an ApexPage error message!');
      System.assert(hasSpecificMessage, 'Constructor should has specifik error message.');
    }
  }

  @isTest
  static void testFilterRecordsAccessError() {
    Exception capturedException;
    User testUser = [ SELECT Id FROM User WHERE username = 'systemAdministratorTest@testorg.com'];
    FilteredPositionsCtrl pageController = new FilteredPositionsCtrl();

    System.runAs(testUser) {
      Test.startTest();
      pageController.filterRecords();
      Test.stopTest();

      List<Apexpages.Message> messages = ApexPages.getMessages();
      Boolean hasSpecificMessage = false;
      for (Apexpages.Message msg : messages) {
        if (msg.getDetail().contains(System.Label.Records_access_error)) {
          hasSpecificMessage = true;
        }
      }

      System.assert(ApexPages.hasMessages(ApexPages.Severity.ERROR), 'There should be an ApexPage error message!');
      System.assert(hasSpecificMessage, 'Constructor should has specifik error message.');
    }
  }

  @isTest
  static void testGetStatuses() {
    FilteredPositionsCtrl pageController = new FilteredPositionsCtrl();

    Test.startTest();
    List<SelectOption> options = pageController.getStatuses();
    Test.stopTest();

    System.assertEquals( options.size(), Position__c.Status__c.getDescribe().getPickListValues().size() + 1);
    System.assertEquals(options.get(0).getValue(), 'All Statuses');
  }

  @isTest
  static void testGetStatusesError() {
    Exception capturedException;
    User testUser = [SELECT Id FROM User WHERE username = 'systemAdministratorTest@testorg.com'];

    System.runAs(testUser) {
      Test.startTest();
      try {
        List<SelectOption> options = RecruitingHelper.getStatuses();
      } catch (Exception e) {
        System.debug(e.getMessage());
        capturedException = e;
      }
      Test.stopTest();
      System.assertEquals(
        System.Label.Records_access_error,
        capturedException.getMessage(),
        'Method getPositions should throw an AuraHandledException with specifik message'
      );
    }
  }

  @isTest
  static void testGetFilteredByAllStatuses() {
    FilteredPositionsCtrl pageController = new FilteredPositionsCtrl();

    Test.startTest();
    pageController.selectedStatus = 'All Statuses';
    pageController.filterRecords();
    List<Position__c> resultList = pageController.positionList;
    Test.stopTest();

    Position__c[] positionList = [
      SELECT Name, Closed_At__c, Opened_At__c, Status__c, Max_Salary__c, Min_Salary__c
      FROM Position__c
    ];
    System.assertEquals(positionList, resultList);
  }

  @isTest
  static void testGetFilteredBySpecificStatus() {
    FilteredPositionsCtrl pageController = new FilteredPositionsCtrl();

    Test.startTest();
    pageController.selectedStatus = 'Closed';
    pageController.filterRecords();
    List<Position__c> resultList = pageController.positionList;
    Test.stopTest();

    Position__c[] positionList = [
      SELECT Name, Closed_At__c, Opened_At__c, Status__c, Max_Salary__c, Min_Salary__c
      FROM Position__c
      WHERE status__c = 'Closed'
    ];
    System.assertEquals(positionList, resultList);
  }

  @isTest
  static void testGetFilteredPositionsError() {
    Integer offset = 0;
    Integer maximumLimit = 200;
    String selectedStatus = 'All Statuses';

    Exception capturedException;
    User testUser = [ SELECT Id FROM User WHERE username = 'systemAdministratorTest@testorg.com'];

    System.runAs(testUser) {
      Test.startTest();
      try {
        List<Position__c> resultList = RecruitingHelper.getFilteredPositions(offset, maximumLimit, selectedStatus);
      } catch (Exception e) {
        System.debug(e.getMessage());
        capturedException = e;
      }
      Test.stopTest();
      System.assertEquals(
        System.Label.Records_access_error,
        capturedException.getMessage(),
        'Method getFilteredPositions should throw an AuraHandledException with specifik message'
      );
    }
  }

  @isTest
  static void testSaveSuccess() {
    FilteredPositionsCtrl pageController = new FilteredPositionsCtrl();
    String statusToChange = 'Editing';

    Test.startTest();
    pageController.positionList.get(0).Status__c = statusToChange;
    Id firstPosId = pageController.positionList.get(0).Id;
    pageController.save();
    Test.stopTest();

    Position__c changedStatusPosition = [
      SELECT Name, Closed_At__c, Opened_At__c, Status__c, Max_Salary__c, Min_Salary__c
      FROM Position__c
      WHERE Id = :firstPosId
    ];

    List<Apexpages.Message> messages = ApexPages.getMessages();
    Boolean hasSpecificMessage = false;
    for (Apexpages.Message msg : messages) {
      if (msg.getDetail().contains('Records were successfully updated')) {
        hasSpecificMessage = true;
      }
    }

    System.assertEquals(changedStatusPosition.Status__c, statusToChange);
    System.assert(ApexPages.hasMessages(ApexPages.Severity.CONFIRM), 'There should be an ApexPage success message!');
    System.assert(hasSpecificMessage, 'Save method should create "Records were successfully updated!" message.');
  }

  @isTest
  static void testSaveError() {
    FilteredPositionsCtrl pageController = new FilteredPositionsCtrl();
    String statusToChange = '';

    Test.startTest();
    pageController.positionList.get(0).Status__c = statusToChange;
    pageController.save();
    Test.stopTest();

    List<Apexpages.Message> messages = ApexPages.getMessages();
    Boolean hasSpecificMessage = false;
    for (Apexpages.Message msg : messages) {
      System.debug(msg.getDetail());
      if (msg.getDetail().contains('Error during updating records')) {
        hasSpecificMessage = true;
      }
    }

    System.assert(ApexPages.hasMessages(ApexPages.Severity.ERROR), 'There should be an ApexPage error message!');
    System.assert(hasSpecificMessage, 'Save method should create "Error during updating records" message.');
  }

  @isTest
  static void testSaveAccessError() {
    String statusToChange = 'Closed';
    Exception capturedException;
    User testUser = [ SELECT Id FROM User WHERE username = 'systemAdministratorTest@testorg.com'];
    List<Position__c> posList = [SELECT Name, Id FROM Position__c];

    System.runAs(testUser) {
      Test.startTest();
      try {
        RecruitingHelper.savePositions(posList);
      } catch (Exception e) {
        System.debug(e.getMessage());
        capturedException = e;
      }
      Test.stopTest();
      
      System.assertEquals(
        System.Label.Records_access_error,
        capturedException.getMessage(),
        'Method savePositions should throw an AuraHandledException with specifik message'
      );
    }
  }
}
