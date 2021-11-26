@isTest
private class CustomSettingsControllerTest {
  @TestSetup
  static void makeData() {
    TestDataFactory.createUser('System Administrator', 'systemAdministratorTest@testorg.com');
    TestDataFactory.createUser('Standard User', 'standardUserTest@testorg.com');
  }

  @isTest
  static void testGetCustomSettings() {
    Test.startTest();
    Color_themes__c settings = CustomSettingsController.getCustomSettings();
    Test.stopTest();

    Color_themes__c result = Color_themes__c.getInstance(UserInfo.getUserId());
    System.assertEquals( result, settings, 'Method getCustomSettings should return custom settings for the current user');
  }

  @isTest
  static void testUpdateCustomSettings() {
    String backgroundColor = '#fff';
    String buttonColor = '#328757';
    String linkColor = '#222222';
    User testUser = [ SELECT Id FROM User WHERE username = 'systemAdministratorTest@testorg.com'];

    System.runAs(testUser) {
      Color_themes__c initCustomSettings = new Color_themes__c();
      initCustomSettings.Background_Color__c = '#000';
      initCustomSettings.Button_Color__c = '#111';
      initCustomSettings.Link_Color__c = '#222';
      insert initCustomSettings;

      Test.startTest();
      Color_themes__c customSettings = Color_themes__c.getInstance(UserInfo.getUserId());
      customSettings.Background_Color__c = backgroundColor;
      customSettings.Button_Color__c = buttonColor;
      customSettings.Link_Color__c = linkColor;
      CustomSettingsController.updateCustomSettings(customSettings);
      Test.stopTest();

      Color_themes__c result = Color_themes__c.getInstance(UserInfo.getUserId());
      System.assertEquals( result.Background_Color__c, backgroundColor, 'Method updateCustomSettings should properly update background color');
      System.assertEquals( result.Button_Color__c, buttonColor, 'Method updateCustomSettings should properly update button color');
      System.assertEquals( result.Link_Color__c, linkColor, 'Method updateCustomSettings should properly update link color');
    }
  }

  @isTest
  static void testInsertNewCustomSettings() {
    String backgroundColor = '#fff';
    String buttonColor = '#328757';
    String linkColor = '#222222';
    User testUser = [ SELECT Id FROM User WHERE username = 'systemAdministratorTest@testorg.com'];

    System.runAs(testUser) {
      Test.startTest();
      Color_themes__c customSettings = new Color_themes__c();
      customSettings.Background_Color__c = backgroundColor;
      customSettings.Button_Color__c = buttonColor;
      customSettings.Link_Color__c = linkColor;
      CustomSettingsController.updateCustomSettings(customSettings);
      Test.stopTest();

      Color_themes__c result = Color_themes__c.getInstance(UserInfo.getUserId());
      System.assertEquals( result.Background_Color__c, backgroundColor, 'Method updateCustomSettings should create correct background color color theme custom setting' );
      System.assertEquals( result.Button_Color__c, buttonColor, 'Method updateCustomSettings should create correct button color color theme custom setting' );
      System.assertEquals( result.Link_Color__c, linkColor, 'Method updateCustomSettings should create correct link color color theme custom setting' );
    }
  }

  @isTest
  static void testUpdateCustomSettingsError() {
    Exception capturedException;
    User testUser = [ SELECT Id FROM User WHERE username = 'standardUserTest@testorg.com'];

    System.runAs(testUser) {
    Test.startTest();
    try {
      Color_themes__c customSettings = new Color_themes__c();
      CustomSettingsController.updateCustomSettings(customSettings);
    } catch (Exception e) {
      System.debug(e.getMessage());
      capturedException = e;
    }
    Test.stopTest();
    System.assertEquals(System.Label.Records_access_error, capturedException.getMessage(), 'Method getPositions should throw an AuraHandledException with specifik message');
    }
  }
}
