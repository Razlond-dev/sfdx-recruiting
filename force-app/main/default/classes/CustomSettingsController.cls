public with sharing class CustomSettingsController {
  @AuraEnabled
  public static Color_themes__c getCustomSettings() {
    return Color_themes__c.getInstance(UserInfo.getUserId());
  }

  @AuraEnabled
  public static void updateCustomSettings(Color_themes__c updatedSettings) {
    if (Schema.sObjectType.Position__c.isAccessible()) {
      upsert updatedSettings;      
    } else {
      AuraHandledException e = new AuraHandledException(System.Label.Records_access_error);
      e.setMessage(System.Label.Records_access_error);
      throw e;
    }
  }
}
