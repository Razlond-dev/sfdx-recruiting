@isTest
private class CloseOldPositionsBatchTest {
    @isTest
    private static void CloseOldPositionsBatchTest() {
        TestDataFactory.createPositions(200, Date.today().addDays(-100));
        Test.startTest();
        Database.executeBatch(new CloseOldPositionsBatch());
        Test.stopTest();
        Integer updatedPositionsCount = [SELECT COUNT() FROM Position__c WHERE Closed_At__c != null AND Status__c = 'Closed'];
        System.assertEquals(200, updatedPositionsCount);
    }
}
