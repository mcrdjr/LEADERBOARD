global class Schedulereadhtml0RefreshBatchSch implements Schedulable{
     
    global void execute(SchedulableContext sc){
        readhtml0  refreadhtml0Obj = new readhtml0();
        database.executebatch(refreadhtml0Obj,1);
    }
}