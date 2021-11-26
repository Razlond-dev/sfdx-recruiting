@isTest
private class CloseOldPositionsScheduledTest {
    private static String CRON_EXP = '0 0 0 ? * * *';
    
    @isTest
    private static void CloseOldPositionsScheduledTest() {
    List<AsyncApexJob> jobsBefore = [select Id, ApexClassID, ApexClass.Name, Status, JobType from AsyncApexJob];
    System.assertEquals(0, jobsBefore.size(), 'Do not expecting any asyncjobs');

    Test.startTest();
    String jobId = System.schedule('myJobTestJobName', CRON_EXP, new CloseOldPositionsScheduled());
    Test.stopTest();

    // Check schedulable is in the job list
    List<AsyncApexJob> jobsScheduled = [select Id, ApexClassID, ApexClass.Name, Status, JobType from AsyncApexJob where JobType = 'ScheduledApex'];
    System.assertEquals(1, jobsScheduled.size(), 'Expecting one scheduled job');
    System.assertEquals('CloseOldPositionsScheduled', jobsScheduled[0].ApexClass.Name, 'Expecting specific scheduled job');

    // check apex batch is in the job list
    List<AsyncApexJob> jobsApexBatch = [select Id, ApexClassID, ApexClass.Name, Status, JobType from AsyncApexJob where JobType = 'BatchApex'];
    System.assertEquals(1, jobsApexBatch.size(), 'Expecting one apex batch job');
    System.assertEquals('CloseOldPositionsBatch', jobsApexBatch[0].ApexClass.Name, 'Expecting specific batch job');
    }
}
