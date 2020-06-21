global class SchedulereadhtmlTHRefreshBatchSch implements Schedulable{
     
    global void execute(SchedulableContext sc){
        readhtmlTH refreadhtmlTHObj = new readhtmlTH();
        database.executebatch(refreadhtmlTHObj,1);
    }
}