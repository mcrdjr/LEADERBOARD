@isTest
public class Test_LB {
    private static testMethod void myTestMethod() {
    test.starttest();
    string chron = '0 0 1 * * ? * ';
    system.schedule('Schedulereadhtml5RefreshBatchSch', chron , new Schedulereadhtml5RefreshBatchSch());
    test.stopTest();
    }
}