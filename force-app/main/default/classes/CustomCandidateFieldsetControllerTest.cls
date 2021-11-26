@isTest
private class CustomCandidateFieldsetControllerTest {
  public final static String SOBJECT_NAME = 'Candidate__c';
  public final static String CURRENTLY_CHOSEN_FIELD_SET_NAME = 'All_candidate_fields';
  public final static String SEARCHED_DEVELOPER_NAME = 'Candidate_Field_Set';
  public final static String GET_FIELD_SETS_RESULT = '[{"value":"All_candidate_fields","label":"All candidate fields"},{"value":"Only_required","label":"Only required"}]';
  public final static String GET_FIELD_SETS_MEMBERS_RESULT = '[{"pickListValues":null,"isRequired":true,"fieldType":"STRING","fieldLabel":"Candidate Full Name","fieldAPIName":"Name"},{"pickListValues":null,"isRequired":true,"fieldType":"EMAIL","fieldLabel":"Email","fieldAPIName":"Email__c"},{"pickListValues":null,"isRequired":false,"fieldType":"DOUBLE","fieldLabel":"Age","fieldAPIName":"Age__c"},{"pickListValues":null,"isRequired":false,"fieldType":"STRING","fieldLabel":"Address","fieldAPIName":"Address__c"},{"pickListValues":null,"isRequired":false,"fieldType":"TEXTAREA","fieldLabel":"About","fieldAPIName":"About__c"}]';

  @TestSetup
  static void makeData() {
    TestDataFactory.createUser('Standard User', 'standardUserTest@testorg.com');
  }
  
  @isTest
  static void testCustomCandidateFieldsetControllerCustomCandidateFieldsetInit() {
    Test.startTest();
    CustomCandidateFieldsetController.CandidateFieldSetCtrlWrapper wrapper = CustomCandidateFieldsetController.customCandidateFieldsetInit();
    Test.stopTest();
    CustomCandidateFieldsetController.CandidateFieldSetCtrlWrapper resultWrapper = new CustomCandidateFieldsetController.CandidateFieldSetCtrlWrapper();
    resultWrapper.fieldSets = RecruitingHelper.getFieldSets('Candidate__c');
    resultWrapper.fieldSetMetadataName = RecruitingHelper.getFieldSetMetadata(SEARCHED_DEVELOPER_NAME).Candidate_Creation_Field_Set__c;
    resultWrapper.fieldSetMembers = RecruitingHelper.getFieldSetMembers('Candidate__c', wrapper.fieldSetMetadataName);

    System.assertEquals(wrapper.fieldSetMembers, resultWrapper.fieldSetMembers);
    System.assertEquals(wrapper.fieldSetMetadataName, resultWrapper.fieldSetMetadataName);
    System.assertEquals(wrapper.fieldSets, resultWrapper.fieldSets);
  }

  @isTest
  static void testCustomCandidateFieldsetControllerGetCandidateFormFields() {
    Test.startTest();
    String candidateFormFields = CustomCandidateFieldsetController.getCandidateFormFields(CURRENTLY_CHOSEN_FIELD_SET_NAME);
    Test.stopTest();
    System.assertEquals(candidateFormFields, GET_FIELD_SETS_MEMBERS_RESULT);
  }

  @isTest
  static void testCustomCandidateFieldsetControllerUpdateFieldsetMetadata() {
    String fieldValue = 'Only_required';
    Test.startTest();
    CustomCandidateFieldsetController.updateFieldSetMetadata(fieldValue);
    Test.stopTest();
  }

  @isTest
  static void testRecruitingHelperGetFieldSetsSuccess() {
    Test.startTest();
    String fieldSets = RecruitingHelper.getFieldSets(SOBJECT_NAME);
    Test.stopTest();
    System.assertEquals(fieldSets, GET_FIELD_SETS_RESULT);
  }

  @isTest
  static void testRecruitingHelperGetFieldSetsError() {
    User testUser = [ SELECT Id FROM User WHERE username = 'standardUserTest@testorg.com'];
    Exception capturedException;

    System.runAs(testUser) {
    Test.startTest();
    try {
      String fieldSets = RecruitingHelper.getFieldSets('WRONG NAME');
    } catch (Exception e) {
        System.debug(e.getMessage());
        capturedException = e;
    }
    Test.stopTest();
      System.assertEquals(
        System.Label.Unknown_error_message,
        capturedException.getMessage()
      );
    }
  }

  @isTest
  static void testRecruitingHelperGetFieldSetMembersAPINamesSuccess() {
    Test.startTest();
    List<String> fieldSets = RecruitingHelper.getFieldSetMembersAPINames(SOBJECT_NAME, CURRENTLY_CHOSEN_FIELD_SET_NAME);
    Test.stopTest();
    List<String> listOfAPINames = new List<String>();
    for (Schema.FieldSetMember fieldMember : SObjectType.Candidate__c.fieldSets.getMap().get(CURRENTLY_CHOSEN_FIELD_SET_NAME).getFields()) {
      listOfAPINames.add(fieldMember.getFieldPath());
    }
    System.assertEquals(fieldSets, listOfAPINames);
  }

  @isTest
  static void testRecruitingHelperGetFieldSetMembersAPINamesError() {
    User testUser = [ SELECT Id FROM User WHERE username = 'standardUserTest@testorg.com'];
    Exception capturedException;

    System.runAs(testUser) {
    Test.startTest();
    try {
      List<String> fieldSets = RecruitingHelper.getFieldSetMembersAPINames(SOBJECT_NAME, 'Wrong field set');
    } catch (Exception e) {
        System.debug(e.getMessage());
        capturedException = e;
    }
    Test.stopTest();
      System.assertEquals(
        System.Label.Unknown_error_message,
        capturedException.getMessage()
      );
    }
  }

  @isTest
  static void testRecruitingHelperGetFieldSetMembersError() {
    User testUser = [ SELECT Id FROM User WHERE username = 'standardUserTest@testorg.com'];
    Exception capturedException;

    System.runAs(testUser) {
    Test.startTest();
    try {
      String fieldSetsMembers = RecruitingHelper.getFieldSetMembers(SOBJECT_NAME, 'Wrong field set');
    } catch (Exception e) {
        System.debug(e.getMessage());
        capturedException = e;
    }
    Test.stopTest();
      System.assertEquals(
        System.Label.Unknown_error_message,
        capturedException.getMessage()
      );
    }
  }

  @isTest
  static void testRecruitingHelperGetFieldSetMetadataSuccess() {
    Test.startTest();
    Candidate_Form_Setting__mdt searchedMetadata = RecruitingHelper.getFieldSetMetadata(SEARCHED_DEVELOPER_NAME);
    Test.stopTest();
    Candidate_Form_Setting__mdt result = [SELECT Candidate_Creation_Field_Set__c FROM Candidate_Form_Setting__mdt WHERE DeveloperName = :SEARCHED_DEVELOPER_NAME];
    System.assertEquals(searchedMetadata, result);
  }

  @isTest
  static void testRecruitingHelperGetFieldSetMetadataError() {
    User testUser = [ SELECT Id FROM User WHERE username = 'standardUserTest@testorg.com'];
    Exception capturedException;

    System.runAs(testUser) {
    Test.startTest();
    try {
      Candidate_Form_Setting__mdt searchedMetadata = RecruitingHelper.getFieldSetMetadata(SEARCHED_DEVELOPER_NAME);
    } catch (Exception e) {
        System.debug(e.getMessage());
        capturedException = e;
    }
    Test.stopTest();
      System.assertEquals(
        System.Label.Records_access_error,
        capturedException.getMessage()
      );
    }
  }
}
