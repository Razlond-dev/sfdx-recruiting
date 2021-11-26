public with sharing class NewCandidateFormController {
    @AuraEnabled
    public static List<String> newCandidateFormInit() {
      Candidate_Form_Setting__mdt fieldSetMetadata = RecruitingHelper.getFieldSetMetadata(RecruitingHelper.CANDIDATE_FIELD_SET_DEVELOPER_NAME);
      return RecruitingHelper.getFieldSetMembersAPINames('Candidate__c', fieldSetMetadata.Candidate_Creation_Field_Set__c);
    }
}
