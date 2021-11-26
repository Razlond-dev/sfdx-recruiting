public with sharing class PositionController {
  @AuraEnabled
  public static List<Position__c> getPositions( Integer offsetRange, Integer recordsNum, String selectedStatus) {
    return RecruitingHelper.getFilteredPositions(offsetRange, recordsNum, selectedStatus);
  }

  @AuraEnabled
  public static void savePositions(Object data) {
    try {
      List<Position__c> positionsForUpdate = (List<Position__c>) JSON.deserialize( JSON.serialize(data), List<Position__c>.class);
      RecruitingHelper.savePositions(positionsForUpdate);
    } catch (Exception err) {
      AuraHandledException e = new AuraHandledException(System.Label.Records_updated_error);
      e.setMessage(System.Label.Records_updated_error);
      throw e;
    }
  }

  @AuraEnabled
  public static Integer getPositionsCount(String selectedStatus) {
    return RecruitingHelper.getPositionsCount(selectedStatus);
  }
}
