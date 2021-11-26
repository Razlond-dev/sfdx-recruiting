public inherited sharing class RecruitingHelper {
  public static final Integer DEFAULT_LIMIT = 20;
  public static final Integer DEFAULT_OFFSET = 0;
  public static final String CANDIDATE_FIELD_SET_DEVELOPER_NAME = 'Candidate_Field_Set';

  public static List<Position__c> getFilteredPositions(Integer offsetRange, Integer recordsNum, String selectedStatus) {
    try {
      if (selectedStatus == System.Label.All_Statuses || selectedStatus == null) {
        return [
          SELECT Name, Status__c, Closed_At__c, Opened_At__c, convertCurrency(Max_Salary__c), convertCurrency(Min_Salary__c)
          FROM Position__c
          WITH SECURITY_ENFORCED
          LIMIT :recordsNum
          OFFSET :offsetRange
        ];
      } else {
        return [
          SELECT Name, Status__c, Closed_At__c, Opened_At__c, convertCurrency(Max_Salary__c), convertCurrency(Min_Salary__c)
          FROM Position__c
          WHERE Status__c = :selectedStatus
          WITH SECURITY_ENFORCED
          LIMIT :recordsNum
          OFFSET :offsetRange
        ];
      }
    } catch (Exception err) {
      System.debug(err.getMessage());
      AuraHandledException e = new AuraHandledException(System.Label.Records_access_error);
      e.setMessage(System.Label.Records_access_error);
      throw e;
    }
  }

  public static Integer getPositionsCount(String selectedStatus) {
    try {
      if (selectedStatus == System.Label.All_Statuses) {
        return [SELECT COUNT() FROM Position__c WITH SECURITY_ENFORCED];
      } else {
        return [
          SELECT COUNT()
          FROM Position__c
          WHERE Status__c = :selectedStatus
          WITH SECURITY_ENFORCED
        ];
      }
    } catch (Exception err) {
      System.debug(err.getMessage());
      AuraHandledException e = new AuraHandledException(System.Label.Records_access_error);
      e.setMessage(System.Label.Records_access_error);
      throw e;
    }
  }

  public static List<SelectOption> getStatuses() {
    if (Schema.sObjectType.Position__c.isAccessible()) {
      List<SelectOption> optionList = new List<SelectOption>();
      Schema.DescribeFieldResult fieldResult = Position__c.status__c.getDescribe();
      List<Schema.PickListEntry> listResult = fieldResult.getPickListValues();
      optionList.add(new SelectOption(System.Label.All_Statuses, System.Label.All_Statuses));
      for (Schema.PickListEntry obj : listResult) {
        optionList.add(new SelectOption(obj.getValue(), obj.getLabel()));
      }
      return optionList;
    } else {
      AuraHandledException e = new AuraHandledException(System.Label.Records_access_error);
      e.setMessage(System.Label.Records_access_error);
      throw e;
    }
  }

  public static void savePositions(List<Position__c> data) {
    if (!Schema.SObjectType.Position__c.isUpdateable()) {
      AuraHandledException e = new AuraHandledException(System.Label.Records_access_error);
      e.setMessage(System.Label.Records_access_error);
      throw e;
    }

    try {
      update data;
    } catch (Exception error) {
      System.debug(error.getMessage());
      AuraHandledException e = new AuraHandledException(System.Label.Records_updated_error);
      e.setMessage(System.Label.Records_updated_error);
      throw e;
    }
  }

  public static String getFieldSets(String sObjectName) {
    try {
      Schema.SObjectType sObj = Schema.getGlobalDescribe().get(sObjectName);
      List<FieldMemberHelperClass> fieldSetList = new List<FieldMemberHelperClass>();
        for (Schema.FieldSet FS : sObj.getDescribe().fieldsets.getMap().values()) {
          FieldMemberHelperClass fmember = new RecruitingHelper.FieldMemberHelperClass();
          fmember.label = FS.getLabel();
          fmember.value = FS.getName();
          fieldSetList.add(fmember);
        }
      return JSON.serialize(fieldSetList);
    } catch (Exception error) {
      System.debug(error.getMessage());
      AuraHandledException e = new AuraHandledException(System.Label.Unknown_error_message);
      e.setMessage(System.Label.Unknown_error_message);
      throw e;
    }
  }

  public static String getFieldSetMembers( String objectName, String fieldSetName) {
    try {
      List<FieldSetMemberWrapperClass> wrapperList = new List<FieldSetMemberWrapperClass>();
      Schema.SObjectType sObj = Schema.getGlobalDescribe().get(objectName);

      for (Schema.FieldSetMember fieldMember : sObj.getDescribe().fieldSets.getMap().get(fieldSetName).getFields()) {
        FieldSetMemberWrapperClass wrapper = new FieldSetMemberWrapperClass();
        if (fieldMember.getRequired() || fieldMember.getDbRequired()) {
          wrapper.isRequired = true;
        } else {
          wrapper.isRequired = false;
        }
        wrapper.fieldType = String.valueOf(fieldMember.getType());
        wrapper.fieldLabel = fieldMember.getLabel();
        wrapper.fieldAPIName = fieldMember.getFieldPath();
        if (
          String.valueOf(fieldMember.getType()) == 'PICKLIST' ||
          String.valueOf(fieldMember.getType()) == 'MULTIPICKLIST'
        ) {
          wrapper.pickListValues = sObj.getDescribe()
            .fields.getMap()
            .get(fieldMember.getFieldPath())
            .getDescribe()
            .getPicklistValues();
        }
        wrapperList.add(wrapper);
      }

      return JSON.serialize(wrapperList);
    } catch (Exception error) {
      System.debug(error.getMessage());
      AuraHandledException e = new AuraHandledException(System.Label.Unknown_error_message);
      e.setMessage(System.Label.Unknown_error_message);
      throw e;
    }
  }

  public static List<String> getFieldSetMembersAPINames(String objectName, String fieldSetName) {
    try {
      List<String> listOfAPINames = new List<String>();
      Schema.SObjectType sObj = Schema.getGlobalDescribe().get(objectName);

      for (Schema.FieldSetMember fieldMember : sObj.getDescribe().fieldSets.getMap().get(fieldSetName).getFields()) {
        listOfAPINames.add(fieldMember.getFieldPath());
      }

      return listOfAPINames;
    } catch (Exception error) {
      System.debug(error.getMessage());
      AuraHandledException e = new AuraHandledException(System.Label.Unknown_error_message);
      e.setMessage(System.Label.Unknown_error_message);
      throw e;
    }
  }

  public static Candidate_Form_Setting__mdt getFieldSetMetadata(String searchedDeveloperName) {
    try {
      return [SELECT Candidate_Creation_Field_Set__c FROM Candidate_Form_Setting__mdt WHERE DeveloperName = :searchedDeveloperName WITH SECURITY_ENFORCED];
    } catch (Exception err) {
      System.debug(err.getMessage());
      AuraHandledException e = new AuraHandledException(System.Label.Records_access_error);
      e.setMessage(System.Label.Records_access_error);
      throw e;
    }
  }

  public class FieldSetMemberWrapperClass {
    public Boolean isRequired { get; set; }
    public String fieldType { get; set; }
    public String fieldLabel { get; set; }
    public String fieldAPIName { get; set; }
    public List<Schema.PicklistEntry> pickListValues { get; set; }
  }

  public class FieldMemberHelperClass {
    public String value { get; set; }
    public String label { get; set; }
  }
}
