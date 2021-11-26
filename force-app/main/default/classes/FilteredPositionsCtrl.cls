public with sharing class FilteredPositionsCtrl { 
  public final String USER_CURRENCY { get { return UserInfo.getDefaultCurrency();}}
  public String selectedStatus { get; set; }
  public List<Position__c> positionList { get; set; }

  public FilteredPositionsCtrl() {
    try {
      positionList = RecruitingHelper.getFilteredPositions(RecruitingHelper.DEFAULT_OFFSET, RecruitingHelper.DEFAULT_LIMIT, selectedStatus);
    } catch (Exception err) {
      ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, System.Label.Records_access_error));
    }
  }

  public void filterRecords() {
    try {
      positionList = RecruitingHelper.getFilteredPositions(RecruitingHelper.DEFAULT_OFFSET, RecruitingHelper.DEFAULT_LIMIT, selectedStatus);
    } catch (Exception err) {
      ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, System.Label.Records_access_error));
    }
  }

  public void save() {
    try {
      List<Position__c> listToUpdate = new List<Position__c>();
      for (Position__c position : positionList) {
        Position__c newPos = new Position__c(Id=position.Id, Status__c=position.Status__c);
        listToUpdate.add(newPos);
      }
      RecruitingHelper.savePositions(listToUpdate);
      filterRecords();
      ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM, System.Label.Records_updated));
    } catch (Exception e) {
      ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, System.Label.Records_updated_error));
    }
  }

  public List<SelectOption> getStatuses() {
    return RecruitingHelper.getStatuses();
  }
}
