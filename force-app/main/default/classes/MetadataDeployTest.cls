@isTest
public with sharing class MetadataDeployTest {
  public final static String METADATA_VALUE = 'Only_required';
  public final static String METADATA_RECORD_FULLNAME = 'Candidate_Form_Setting.Candidate_Field_Set';
  public final static String METADATA_RECORD_LABEL = 'Candidate Field Set';
  public final static String METADATA_API_NAME = 'Candidate_Creation_Field_Set__c ';

  @isTest
  static void testMetadataDeploy() {
    Metadata.CustomMetadata customMetadata = new Metadata.CustomMetadata();
    customMetadata.fullName = METADATA_RECORD_FULLNAME;
    customMetadata.label = METADATA_RECORD_LABEL;
    Map<String, Object> fieldWithValues = new Map<String, Object>();
    for (Integer i = 0; i < 100; i++) {
      fieldWithValues.put(METADATA_API_NAME, METADATA_VALUE);
    }
    
    Test.startTest();
    String result = MetadataDeploy.updateCustomMetadata(customMetadata, fieldWithValues);
    Test.stopTest();
    System.assertEquals( result, 'Success');
  }

  @isTest
  static void testMetadataDeployHandleResult() {
    MetadataDeploy mtdDeploy = new MetadataDeploy();
    Test.startTest();
    mtdDeploy.handleResult(new Metadata.DeployResult(), new Metadata.DeployCallbackContext());
    Test.stopTest();
  }
}
