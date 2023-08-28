trigger OppLineTrigger on OpportunityLineItem (After Insert,After Update ,After Delete) {
    if(Trigger.isAfter && Trigger.isInsert || Trigger.isUpdate){
        OpportunityCount.UpdateAcc(Trigger.new);

    }
    if(Trigger.isAfter && Trigger.isDelete){
        OpportunityCount.UpdateAcc(Trigger.old);
        
    }

}