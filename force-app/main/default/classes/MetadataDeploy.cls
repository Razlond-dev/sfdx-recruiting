public without sharing class MetadataDeploy implements Metadata.DeployCallback {
  public static String updateCustomMetadata(Metadata.CustomMetadata customMetadata, Map<String, Object> fieldWithValues) {

    for (String key : fieldWithValues.keySet()) {
      Metadata.CustomMetadataValue customField = new Metadata.CustomMetadataValue();
      customField.field = key;
      customField.value = fieldWithValues.get(key);
      customMetadata.values.add(customField);      
    }

    Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();
    mdContainer.addMetadata(customMetadata);

    MetadataDeploy callback = new MetadataDeploy();
    Id jobId;
    if (!Test.isRunningTest()) {
      jobId = Metadata.Operations.enqueueDeployment(mdContainer, callback);
    }
    return 'Success';
  }

  public void handleResult(Metadata.DeployResult result, Metadata.DeployCallbackContext context) {
    if (result.status == Metadata.DeployStatus.SUCCEEDED) {
      System.debug(' ===>' + result);
    } else {
      System.debug(' ===> fail ' + result);
    }
  }
}
