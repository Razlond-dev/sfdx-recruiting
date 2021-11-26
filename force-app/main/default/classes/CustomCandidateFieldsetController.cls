public with sharing class CustomCandidateFieldsetController {
  @AuraEnabled
  public static CandidateFieldSetCtrlWrapper customCandidateFieldsetInit() {
    CandidateFieldSetCtrlWrapper wrapper = new CandidateFieldSetCtrlWrapper();
    wrapper.fieldSets = RecruitingHelper.getFieldSets('Candidate__c');
    wrapper.fieldSetMetadataName = RecruitingHelper.getFieldSetMetadata(RecruitingHelper.CANDIDATE_FIELD_SET_DEVELOPER_NAME).Candidate_Creation_Field_Set__c;
    wrapper.fieldSetMembers = RecruitingHelper.getFieldSetMembers('Candidate__c', wrapper.fieldSetMetadataName);
    return wrapper;
  }

  @AuraEnabled
  public static String getCandidateFormFields(String fieldSetName) {
    return RecruitingHelper.getFieldSetMembers('Candidate__c', fieldSetName);
  }

  @AuraEnabled
  public static void updateFieldSetMetadata(String fieldValue) {
    Metadata.CustomMetadata customMetadata = new Metadata.CustomMetadata();
    customMetadata.fullName = 'Candidate_Form_Setting.Candidate_Field_Set';
    customMetadata.label = 'Candidate Field Set';
    Map<String, Object> fieldWithValues = new Map<String, Object>();
    fieldWithValues.put('Candidate_Creation_Field_Set__c', fieldValue);
    
    MetadataDeploy.updateCustomMetadata(customMetadata, fieldWithValues);
  }

  public class CandidateFieldSetCtrlWrapper {
    @AuraEnabled
    public String fieldSets;
    @AuraEnabled
    public String fieldSetMembers;
    @AuraEnabled
    public String fieldSetMetadataName;
  }
}
