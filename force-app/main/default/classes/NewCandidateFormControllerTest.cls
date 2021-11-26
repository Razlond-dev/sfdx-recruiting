@isTest
private class NewCandidateFormControllerTest {
  public final static String SOBJECT_NAME = 'Candidate__c';
  public final static String CURRENTLY_CHOSEN_FIELDSET_NAME = 'All_candidate_fields';
  
  
  @isTest
  static void testNewCandidateFormControllerNewCandidateFormInit() {
    Test.startTest();
    List<String> listString = NewCandidateFormController.newCandidateFormInit();
    Test.stopTest();
    List<String> resultList = RecruitingHelper.getFieldSetMembersAPINames(SOBJECT_NAME, CURRENTLY_CHOSEN_FIELDSET_NAME);
    System.assertEquals(listString, resultList);
  }
}
