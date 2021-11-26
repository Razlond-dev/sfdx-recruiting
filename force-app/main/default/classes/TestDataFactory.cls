@isTest
public class TestDataFactory {
  public static List<Candidate__c> createCandidates(Integer count) {
    List<Candidate__c> candidateList = new List<Candidate__c>();

    for (Integer i = 0; i < count; i++) {
      candidateList.add(new Candidate__c(Name = 'testName' + Integer.valueof((Math.random() * 10000)) + i, Email__c = i + 'testCandidate@test.com'));
    }
    insert candidateList;
    return candidateList;
  }

  public static List<Position__c> createPositions(Integer count) {
    List<Position__c> posList = new List<Position__c>();
    List<String> statusValues = new List<String>{ 'Closed', 'Opened', 'Freezed', 'Editing' };

    for (Integer i = 0; i < count; i++) {
      posList.add(
        new Position__c(
          Name = 'testName ' + i,
          Opened_At__c = Date.today(),
          Status__c = statusValues.get(Integer.valueof((Math.random() * 3))),
          Max_Salary__c = 9000,
          Min_Salary__c = 6000
        )
      );
    }
    insert posList;
    return posList;
  }

  public static List<Position__c> createPositions(Integer count, Date openedAt) {
    List<Position__c> posList = new List<Position__c>();
    List<String> statusValues = new List<String>{ 'Closed', 'Opened', 'Freezed', 'Editing' };

    for (Integer i = 0; i < count; i++) {
      posList.add(
        new Position__c(
          Name = 'testName ' + i,
          Opened_At__c = openedAt,
          Status__c = statusValues.get(Integer.valueof((Math.random() * 3))),
          Max_Salary__c = 9000,
          Min_Salary__c = 6000
        )
      );
    }
    insert posList;
    return posList;
  }


  public static List<Job_Application__c> createJobApplications(Integer count) {
    List<Position__c> positions = createPositions(count);
    List<Candidate__c> testCandidate = createCandidates(1);
    List<Job_Application__c> jobApps = new List<Job_Application__c>();

    for (Integer j = 0; j < count; j++) {
      Position__c position = positions[j];
      jobApps.add(
        new Job_Application__c(
          Stage__c = 'Unopened',
          CV__c = 'testCV.com',
          Position__c = position.Id,
          Candidate__c = testCandidate.get(0).Id
        )
      );
    }
    insert jobApps;
    return jobApps;
  }

  public static void createUser(String profileName, String userName) {
    Profile p = [SELECT Id FROM Profile WHERE Name = :profileName];
    User u = new User(
      Alias = 'standt',
      Email = 'standarduser@testorg.com',
      EmailEncodingKey = 'UTF-8',
      LastName = 'Testing',
      LanguageLocaleKey = 'en_US',
      LocaleSidKey = 'en_US',
      ProfileId = p.Id,
      TimeZoneSidKey = 'America/Los_Angeles',
      UserName = userName
    );
    insert u;
  }
}
